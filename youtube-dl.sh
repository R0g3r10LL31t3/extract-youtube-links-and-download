#!/bin/sh

YDL="./youtube-dl/youtube-dl"

$YDL -q -o "%(title)s.%(ext)s" "$1"

exit 0
