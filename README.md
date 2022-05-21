# bombay

`bombay` sorts the files in your working directory by filetype, and
sends them to their appropriate `$XDG_*_DIR`.

## Usage

Imagine you had this mess in your `~/Downloads`:

```bash
$ ls -al ~/Downloads
.
..
badger-sock.pdf
parallel-muffin.png
virtual-monkey.webp
student-steak.svg
kind-vulture.epub
funny-dialect.mp4
summer-dance.gif
[redacted]
```

Let's tell `bombay` to clean it up:

```bash
~ $ cd Downloads

~/Downloads $ bombay

~ $ ls ~/Pictures
parallel-muffin.png student-steak.svg virtual-monkey.webp

~ $ ls ~/Documents
badger-sock.pdf kind-vulture.epub

~ $ ls ~/Videos
summer-dance.gif funny-dialect.mp4
```

`bombay` will parse your `$XDG_CONFIG_HOME/user-dirs.dirs` to locate
the directories inside of which the files will be organized. Because
of this, it is limited to *Linux* for the moment.

## Installation

```
gem install bombay
```

## Copying

This software is licensed under the MIT license.
