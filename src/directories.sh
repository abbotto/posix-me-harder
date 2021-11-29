#!/usr/bin/env sh

# DIRECTORIES
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

# The XDG Base Directory Specification is used to ensure
# consistent locations for common types of directories
# because POSIX doesn't have definitons for them.

# If $XDG_CACHE_HOME is either not set or empty,
# a default equal to $HOME/.cache should be used.
XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
export XDG_CACHE_HOME

if [ ! -d "${XDG_CACHE_HOME}" ]; then
    mkdir -p "${XDG_CACHE_HOME}"
fi

# If $XDG_CONFIG_DIRS is either not set or empty,
# a default equal to '/etc/xdg' should be used.
XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"
export XDG_CONFIG_DIRS

# If $XDG_CONFIG_HOME is either not set or empty,
# a default equal to $HOME/.config should be used.
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CONFIG_HOME

if [ ! -d "${XDG_CONFIG_HOME}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}"
fi

# If $XDG_DATA_DIRS is either not set or empty,
# a default equal to '/usr/local/share/:/usr/share/' should be used.
XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"
export XDG_DATA_DIRS

# If $XDG_DATA_HOME is either not set or empty,
# a default equal to $HOME/.local/share should be used.
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_DATA_HOME

if [ ! -d "${XDG_DATA_HOME}" ]; then
    mkdir -p "${XDG_DATA_HOME}"
fi
