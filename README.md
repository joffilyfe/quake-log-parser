# Quake Log Parser

This project aims to be a valid way to parse and retrieve statistics from a Quake Server log file. It uses a log example to make some assumptions about the Quake Arena game.

## Demonstration

[![asciicast](https://asciinema.org/a/uwPH9tpNrBkNhNtL6QUrUSRt2.svg)](https://asciinema.org/a/uwPH9tpNrBkNhNtL6QUrUSRt2)
## Installation

You have to clone this repository it and run:

```bash
bundle install
```

## Using it

It includes a rake task to make easy to use the parser.

```bash
$ bundle exec rake quake:log:parse -l quake-server-file.log
```

## Running tests

```bash
$ bundle exec rspec
```
