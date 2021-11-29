#!/usr/bin/env sh

set -eu

version=$(cat ./.version)

# Cleanup the previous 'build' directory
[ -d './build' ] && rm -rf './build'

# Create the 'build' directory and
# copy the required files to it
mkdir -p "./build"
cd ./build

# A function for appending the 'src'
# scripts to the output file
build_script() {
	awk '{if (NR!=1) {print}}' <"${1}" >>posix-me-harder
}

# Add the shebang
printf '%s\n' '#!/usr/bin/env sh' >posix-me-harder

# Add the license
# shellcheck disable=SC2129
printf '%s\n' "# POSIX_ME_HARDER ∙ Version ${version}" >>posix-me-harder
printf '%s\n' '# Copyright (c) 2021 Jared Abbott' >>posix-me-harder
printf '%s\n' '# Released under the MIT license' >>posix-me-harder
printf '%s\n' '# https://posix-me-harder.com/license/' >>posix-me-harder

# Store the module header
header="$(cat posix-me-harder)"

# Export the version
# shellcheck disable=SC2129
printf '\n%s\n' "_PMH_VERSION_=${version}" >posix-me-harder
# shellcheck disable=SC2129
printf '%s\n' "export _PMH_VERSION_" >>posix-me-harder

# Add the 'src' scripts
build_script ../src/directories.sh
build_script ../src/emulate.sh
build_script ../src/brace-expand.sh
build_script ../src/echo.sh
build_script ../src/alias.sh
build_script ../src/history.sh
build_script ../src/arguments.sh

# Store the module body
# Strip comments and squeeze multiple newlines
body="$(../dev/util/minify.sh posix-me-harder)"

# Put the build back together
printf '%s\n' "${header}" >posix-me-harder
printf '%s\n' "${body}" >>posix-me-harder

# Make the script executable
chmod +x posix-me-harder

# Bundle the release files in an archive
tar -czvf "./release-${version}.tar.gz" \
	posix-me-harder >/dev/null 2>&1
