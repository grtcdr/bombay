# bombay

[![Gem Version](https://badge.fury.io/rb/bombay.svg)](https://badge.fury.io/rb/bombay)

`bombay` groups (stacks) the files in your working directory by
filetype, and sends them to their appropriate `$XDG_*_DIR`.

## Installation

```
gem install bombay
```

## Usage

Imagine you had this mess in your `~/Downloads`:

```bash
~/Downloads $ ls -al
.
..
badger-sock.pdf
parallel-muffin.png
virtual-monkey.webp
student-steak.svg
kind-vulture.epub
funny-dialect.mp4
summer-dance.gif
```

Run `bombay` to clean it up:

```bash
~/Downloads $ bombay

~/Downloads $ ls ~/Pictures
parallel-muffin.png student-steak.svg virtual-monkey.webp

~/Downloads $ ls ~/Documents
badger-sock.pdf kind-vulture.epub

~/Downloads $ ls ~/Videos
summer-dance.gif funny-dialect.mp4
```

## Platform support

`bombay` was initially built for Linux with support for XDG user
directories, but has been extended to support macOS, although that remains to
be tested. The program will not run on any other platforms.

## Copying

This software is licensed under the MIT license.
