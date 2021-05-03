use std::convert::TryInto;
use std::fmt;
use std::process::Command;
use std::result;
use std::str;

#[derive(Debug, Clone)]
struct Error {
    error: String,
}

type Result<T> = result::Result<T, Error>;

impl Error {
    fn error<T>(error: &str) -> impl Fn(T) -> Error + '_ {
        move |_| Error {
            error: error.to_string(),
        }
    }
}

impl fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.error)
    }
}

#[derive(Debug)]
struct Entry {
    id: String,
    name: String,
    active: bool,
    zoomed: bool,
    width: u64,
    height: u64,
}

fn parse_prop<T: str::FromStr>(arg: &str, error: &str) -> Result<T> {
    arg.parse::<T>().map_err(Error::error(error))
}

impl Entry {
    fn new<const S: usize>(fields: [&str; S]) -> Result<Entry> {
        Ok(Entry {
            active: fields[0] == "1",
            id: fields[1].to_string(),
            name: fields[2].to_string(),
            width: parse_prop(fields[3], "bad width")?,
            height: parse_prop(fields[4], "bad height")?,
            zoomed: fields[5] == "1",
        })
    }

    fn should_ignore(&self) -> bool {
        self.zoomed || self.name.ends_with("~")
    }
}

fn get_entries<const S: usize>(
    cmd: &str,
    format: [&str; S],
) -> Result<(Option<Entry>, Vec<Entry>)> {
    let output = Command::new("tmux")
        .arg(cmd)
        .arg("-F")
        .arg(format.join(" "))
        .output()
        .map_err(Error::error("command failed"))?;

    let entries = String::from_utf8(output.stdout)
        .map_err(Error::error("bad format"))?
        .lines()
        .map(|line| {
            Entry::new::<S>(
                line.split(" ")
                    .collect::<Vec<&str>>()
                    .try_into()
                    .map_err(Error::error("bad format"))?,
            )
        })
        .collect::<Result<Vec<Entry>>>()?;

    Ok((None, entries))
}

fn get_windows() -> Result<(Option<Entry>, Vec<Entry>)> {
    get_entries(
        "list-windows",
        [
            "#{window_active}",
            "#{window_id}",
            "#{window_name}",
            "#{window_width}",
            "#{window_height}",
            "#{window_zoomed_flag}",
        ],
    )
}

fn get_panes() -> Result<(Option<Entry>, Vec<Entry>)> {
    get_entries(
        "list-panes",
        [
            "#{pane_active}",
            "#{pane_id}",
            "-",
            "#{pane_width}",
            "#{pane_height}",
            "-",
        ],
    )
}

fn main() {
    println!("{:#?}", get_windows());
    println!("{:#?}", get_panes());
}
