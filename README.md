# actions-updater

![Gem](https://img.shields.io/gem/v/actions-updater?color=bgreen)
![Bintray](https://img.shields.io/bintray/v/dawidd6/bottles-tap/actions-updater?label=homebrew%20version)

A rather simple utility that checks if there are any updates for used Github Actions in specified workflow files.

[![asciicast](https://asciinema.org/a/fV29jfCVcwza1uWlYrwyXHaWG.svg)](https://asciinema.org/a/fV29jfCVcwza1uWlYrwyXHaWG)

## Installation

### From Homebrew tap

```sh
brew install dawidd6/tap/actions-updater
```

### From RubyGems

```sh
gem install actions-updater
```

### From source

```sh
rake install
```

## Usage

### Check for available updates

```sh
actions-updater .github/workflows/*.yml
```

### Check for available updates and write to files

```sh
actions-updater --write .github/workflows/*.yml
```
