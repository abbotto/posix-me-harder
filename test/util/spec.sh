#!/usr/bin/env sh

set -eu

./dev/util/build.sh

platform=$(uname -s | tr '[:upper:]' '[:lower:]')

mkdir -p './test/tmp'
cp -r './test/spec/.' './test/tmp/spec'
cp -r './build/posix-me-harder' './test/tmp'

shells=bash,dash,ksh,mksh,yash,zsh

# Loop over each shell name and run the tests for a given shell
for PMH_ENV in $(printf '%s' "${shells}" | sed "s/,/ /g"); do
	export PMH_ENV

	# Set the shebang header in each script
	find './test/tmp' -type f | while read -r file; do
		pattern='\(ba\|da\|k\|mk\|ya\|z\|\)sh?93'
		sed_prefix="sed -i"

		if [ "${platform}" = 'darwin' ]; then
			sed_prefix="${sed_prefix} '' -e"
		fi

		eval "${sed_prefix} 's@env ${pattern}@env ${PMH_ENV:-sh}@g' '${file}'"
	done

	# Skip to the next shell if the shell isn't found
	if ! command -v "${PMH_ENV:-}" >/dev/null 2>&1; then
		printf "\nWARN: %s\n\n" "Unrecognizd shell (${PMH_ENV:-}), skipping..."
		continue
	fi

	shell=$(command -v "${PMH_ENV:-}")

	find . \
		-wholename './test/spec/*.sh' ! \
		-wholename "./test/spec/release_spec.sh" \
		-type f -exec shellspec --shell "${shell}" {} +
done

trap "rm -rf ./test/tmp" EXIT INT HUP TERM
