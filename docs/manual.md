# 📓 Manual

[<< back to readme](../README.md#contributing)

## [Install](#install)

Get a copy of the latest release from [here](https://github.com/abbotto/posix-me-harder/releases).  
Extract the contents of the release archive into a destination directory.

```sh
wget -c https://github.com/abbotto/posix-me-harder/archive/refs/tags/release-0.0.1.tar.gz -O - | \
tar -zxvf /path/to/directory
```

## [Usage](#uasge)

Source the module in a script:

```sh
> . /path/to/posix-me-harder
```

Envoke the module with a command in its own process:

```sh
> /path/to/posix-me-harder "<COMMAND>"
```

### Environment variables
#### POSIX variables

| Name       | Description                        | Default             | Required |
| ---------- | ---------------------------------- | ------------------- | -------- |
| `FCEDIT`   | Set the default editor for `fc`.   | `$(command -v ed)`  | No       |
| `HISTFILE` | The default history file location. | `$HOME/.sh_history` | No       |
| `HISTSIZE` | The default history size.          | `2048`              | No       |

#### XDG variables

| Name              | Description                                                 | Default                         | Required |
| ----------------- | ----------------------------------------------------------- | ------------------------------- | -------- |
| `XDG_CACHE_HOME`  | Directory for user-specific non-essential data.             | `${HOME}/.cache`                | No       |
| `XDG_CONFIG_DIRS` | Preference-ordered directories for additional config files. | `/etc/xdg`                      | No       |
| `XDG_CONFIG_HOME` | Directory for user-specific config files.                   | `${HOME}/.config`               | No       |
| `XDG_DATA_DIRS`   | Preference-ordered directories for additional data files.   | `/usr/local/share/:/usr/share/` | No       |
| `XDG_DATA_HOME`   | Directory for user-specific data files.                     | `${HOME}/.local/share`          | No       |

*POSIX_ME_HARDER follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) to ensure consistent  
locations for common types of directories because POSIX doesn't have definitons for them.*

## [Development](#development)
### Source Code
#### Get a copy of the repository

```
> git clone https://github.com/abbotto/posix-me-harder.git
```

Alternatively, the latest project archive can be downloaded from [here](https://github.com/abbotto/posix-me-harder/archive/main.zip).

#### Run the setup script

```
> cd /path/to/posix-me-harder
> ./dev/util/setup.sh
```

#### Environment variables
#### Module variables

| Name            | Description         | Default        | Required |
| --------------- | ------------------- | -------------- | -------- |
| `_PMH_VERSION_` | The module version. | `cat .version` | No       |

### [Formatting](#formatting)

Format files with [shfmt](https://github.com/patrickvane/shfmt).

```
> ./dev/util/format.sh
```

### [Testing](#testing)

#### Running spec files

Run tests with [shellspec](https://shellspec.info/).

```
> ./test/util/spec.sh
```

#### [Writing tests](#writing-tests)

The tests for `POSIX_ME_HARDER` can be found in [test/spec](../test/spec).  
All tests are run through [shellspec](https://shellspec.info/) which is a full-featured BDD unit testing framework for *nix shells.

```sh
It "should set the 'POSIXLY_CORRECT' variable"
  When call posix_me_harder \
    'printf "%s" "${POSIXLY_CORRECT}"'
  The output should equal '1'
End
```

#### Linting project files

Lint scripts with [shellcheck](https://shellcheck.com/)

```
> ./test/util/lint.sh
```

#### Checking the release steps

Ensure the `main` branch is ready for release.

```
> ./test/util/release.sh
```

[<< back to readme](../README.md#contributing)
