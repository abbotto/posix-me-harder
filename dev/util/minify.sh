#!/usr/bin/env sh

set -eu

# Remove leading/trailing spaces from each line
awk '{$1=$1}1' "${1}" | \
# Remove comments at the end of a line
sed 's/\s#\s.*//g' | \
# Remove lines that start with comments
awk '/^#/{next}1' | \
# Remove blank lines
awk '!/^[[:space:]]*$/'
