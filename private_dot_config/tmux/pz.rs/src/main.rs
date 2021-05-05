#![allow(dead_code)]

use std::convert::TryInto;
use std::process::Command;
use std::result;
use std::str;

type Result<T> = result::Result<T, String>;

#[derive(Debug, Clone)]
struct Entry {
    id: String,
    name: String,
    active: bool,
    zoomed: bool,
    width: u64,
    height: u64,
}

impl Entry {
    fn from_fields<const S: usize>(fields: [&str; S]) -> Result<Entry> {
        let entry = Entry {
            active: fields[0] == "1",
            id: fields[1].to_string(),
            name: fields[2].to_string(),
            width: fields[3]
                .parse::<u64>()
                .map_err(|_| "bad width".to_string())?,
            height: fields[4]
                .parse::<u64>()
                .map_err(|_| "bad height".to_string())?,
            zoomed: fields[5] == "1",
        };

        Ok(entry)
    }

    fn from_str<const S: usize>(line: &str) -> Result<Entry> {
        let fields: [&str; S] = line
            .split_whitespace()
            .collect::<Vec<_>>()
            .try_into()
            .map_err(|_| "bad format".to_string())?;

        Entry::from_fields(fields)
    }

    fn should_ignore(&self) -> bool {
        self.zoomed || self.name.ends_with("~")
    }
}

fn run_command<const S: usize>(cmd: &str, format: [&str; S]) -> Result<String> {
    let output = Command::new("tmux")
        .arg(cmd)
        .arg("-F")
        .arg(format.join(" "))
        .output()
        .map_err(|_| "command failed".to_string())?;

    match output.status.code() {
        Some(0) => String::from_utf8(output.stdout).map_err(|_| "bad format".to_string()),
        Some(code) => Err(format!("bad exit code: {}", code)),
        None => Err("process terminated".to_string()),
    }
}

fn get_entries<const S: usize>(
    cmd: &str,
    format: [&str; S],
) -> Result<(Option<Entry>, Vec<Entry>)> {
    let all = run_command(cmd, format)?
        .lines()
        .map(Entry::from_str::<S>)
        .collect::<Result<Vec<_>>>()?;
    let (all_active, rest): (Vec<_>, Vec<_>) = all.into_iter().partition(|v| v.active);
    let active = all_active.into_iter().nth(0);

    Ok((active, rest))
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

fn main() -> result::Result<(), String> {
    let mut resize_command: Vec<String> = vec![];

    if let (Some(active_window), _) = get_windows()? {
        if active_window.should_ignore() {
            return Ok(());
        }

        if let (Some(active_pane), panes) = get_panes()? {
            let ratio: f64 = 1.618;
            let main_width = (active_window.width as f64 / ratio) as u64;
            let main_height = (active_window.height as f64 / ratio) as u64;

            resize_command.push(format!(
                "resize-pane -t {} -x {} -y {}",
                active_pane.id, main_width, main_height
            ));
            let row = panes
                .iter()
                .filter(|entry| entry.height == active_pane.height)
                .collect::<Vec<&Entry>>();
            if row.len() > 1 {
                let x = (active_window.width - main_width) / row.len() as u64;
                for p in row {
                    resize_command.push(format!("resize-pane -t {} -x {}", p.id, x));
                }
            }

            let col = panes
                .iter()
                .filter(|entry| entry.width == active_pane.width)
                .collect::<Vec<&Entry>>();
            if col.len() > 1 {
                let y = (active_window.height - main_height) / col.len() as u64;
                for p in col {
                    resize_command.push(format!("resize-pane -t {} -y {}", p.id, y));
                }
            }
        }
    }

    println!("{}", resize_command.join(" ; "));

    Ok(())
}
