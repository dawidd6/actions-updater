# actions-updater

[![Gem](https://img.shields.io/gem/v/actions-updater?color=bgreen)](https://rubygems.org/gems/actions-updater)
![Bintray](https://img.shields.io/bintray/v/dawidd6/bottles-tap/actions-updater?label=homebrew)

A rather simple utility that checks if there are any updates for used Github Actions in specified workflow files (and optionally writes them back to files).

[![asciicast](https://asciinema.org/a/OhMWVX7wtF6WqpTuJ8f87VzRg.svg)](https://asciinema.org/a/OhMWVX7wtF6WqpTuJ8f87VzRg)

## Installation

### Homebrew

```sh
brew install dawidd6/tap/actions-updater
```

### RubyGems

```sh
gem install actions-updater
```

### Source

```sh
rake install
```

## Usage

Check for available updates:

```sh
# print every used action:
actions-updater .github/workflows/*.yml
# print only if there are any updates:
actions-updater --newer .github/workflows/*.yml
```

Check for available updates and write to files:

```sh
actions-updater --write .github/workflows/*.yml
```
