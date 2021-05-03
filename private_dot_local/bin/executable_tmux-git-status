#!/bin/bash
set -u
flags_style=$1 ; branch_style=$2

flags=""

stash=$(git stash list | wc -l | xargs)
test $stash -ne 0 && flags="${flags}S"

all=$(git status --porcelain -b)
status=$(grep -v "^##" <<< "$all")
grep -q "^ D" <<< "$status" && flags="${flags}d"
grep -q "^D." <<< "$status" && flags="${flags}D"
grep -q "^M." <<< "$status" && flags="${flags}M"
grep -q "^ M" <<< "$status" && flags="${flags}m"
grep -q "^??" <<< "$status" && flags="${flags}?"
grep -q "ahead" <<< "$all" && flags="${flags}'"
grep -q "behind" <<< "$all" && flags="${flags},"
flags="#[$flags_style]$flags#[default]"

branch=$(git rev-parse --abbrev-ref HEAD)
branch="#[$branch_style]$branch#[default]"

echo "$branch $flags"
