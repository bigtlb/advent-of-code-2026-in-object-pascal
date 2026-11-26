# Advent of Code 2026 — Object Pascal

A small Free Pascal scaffold for solving each day's puzzle from the command line or VS Code.

## Requirements

- Free Pascal Compiler (`fpc`)
- `zsh`
- VS Code (optional)

## Run a puzzle

Put the day's example in `data/day01/example.txt` and your Advent of Code input in `data/day01/input.txt`. The real input file is ignored by Git.

From the project root, run either part against the example or your real input:

```zsh
zsh scripts/run.zsh 1 1 --example
zsh scripts/run.zsh 1 2 --example
zsh scripts/run.zsh 1 1
zsh scripts/run.zsh 1 2 --input
```

The day and part are numeric arguments. The real input is the default; `--example` selects `example.txt`, and `--input` explicitly selects `input.txt`. The runner builds the program before executing it. To compile without running:

```zsh
zsh scripts/build.zsh
```

The Day 1 routines currently return `Not implemented`; add each part's solution in `src/days/day01.pas`. Both parts receive the selected file as a list of lines.

## Add a day

From the project root, run the scaffold command with a day number from 1 to 25:

```zsh
zsh scripts/add-day.zsh 2
```

This creates `src/days/day02.pas` with both part templates, creates `data/day02/`, and registers the unit with the command-line dispatcher. The command refuses to overwrite an existing day unit; add `example.txt` and `input.txt` to the new data directory before running it.

## VS Code

Open this folder in VS Code. Use **Terminal → Run Task → Run Advent of Code** and answer the prompts for day, part, and input type. **Build Advent of Code** (also available with `Ctrl+Shift+B`) compiles the project. These tasks invoke the same scripts used from the terminal.

## Project layout

```text
.vscode/tasks.json        VS Code build and run tasks
data/day01/               Example and real puzzle input
scripts/build.zsh         Compile the program
scripts/run.zsh           Build and run a selected day and part
scripts/add-day.zsh       Create and register a day template
src/aoc.pas               Command-line entry point
src/aocinput.pas          Shared input-file loader
src/days/day01.pas        Day 1 part templates
```

Generated files go in `bin/` and `build/`; both are ignored by Git.