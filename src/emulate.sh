#!/usr/bin/env sh

# EMULATE
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html
# https://en.wikipedia.org/wiki/X/Open#Output
# https://illumos.org/man/5/XPG4
# https://www.gnu.org/software/bash/manual/html_node/Bash-POSIX-Mode.html
# https://yash.osdn.jp/doc/posix.html
# https://zsh.sourceforge.io/Doc/Release/Invocation.html#Compatibility
# https://zsh.sourceforge.io/Doc/Release/Options.html#index-POSIXARGZERO

# Enable POSIX emulation in supported shells (bash,mksh,yash,zsh)
if set -o | grep 'posix ' >/dev/null 2>&1; then
	# shellcheck disable=SC2039,SC3040
	set -o posix # bash,mksh
elif set -o | grep 'posixlycorrect' >/dev/null 2>&1; then
	# shellcheck disable=SC2039,SC3040
	set -o posixlycorrect # yash
elif set -o | grep 'posixbuiltins' >/dev/null 2>&1; then
	# Emulations use 'NO_FUNCTION_ARGZERO' instead of 'POSIX_ARGZERO'.
	# Running 'emulate' within a function or script could result in an unexpected scoping of $0.
	# Using the '-o POSIX_ARGZERO' argument with the 'emulate' command will avoid the issue.
	emulate -R sh -o POSIX_ARGZERO # zsh
fi

# Systems such as *BSD and GNU/Linux ship POSIX-compliant utilities which
# can be found in '/bin' or '/usr/bin'. However, POSIX-compliant utilities
# are not always located in '/bin' or '/usr/bin' on other systems. Unix
# systems such as Solaris have a directory called '/usr/xpg*/bin' that
# contains POSIX-compliant utilities. When '/usr/xpg*/bin' is added to
# $PATH before '/bin' and '/usr/bin' the POSIX versions of system utilities
# are given precedence. When there are multiple versions of an application
# in $PATH, the one that appears earliest in $PATH gets executed.

# POSIX utility directories for GNU/Linux, MacOS, Solaris, and other *nix systems.
posix_xpg_bin='/bin/posix','/usr/bin/posix','/usr/xpg6/bin','/usr/xpg5/bin','/usr/xpg4/bin','/usr/xpg3/bin','/usr/xpg2/bin','/usr/xpg/bin','/xpg'

# Loop over each path name and find the POSIX utility directory
# shellcheck disable=SC2154
for bin in $(printf '%s' "${posix_xpg_bin}" | sed "s/,/ /g"); do
	if [ -d "${bin}" ]; then
		PATH="${bin}":"${PATH}"
		break
	elif [ "${bin}" = '/xpg' ]; then
		# In some shells, the 'xpg' directory doesn't actually need to exist but
		# still needs to be referenced before '/bin' and '/usr/bin' in $PATH. For
		# example, updating $PATH to the following will ensure that 'echo' works
		# correctly in 'ksh93u+'.
		PATH=/xpg:"${PATH}"
	fi
done

export PATH

# Ensure that 'POSIXLY_CORRECT=1' for consistency across shells.
# This environment variable isn't defined by POSIX but it is a de
# facto standard that is used by *nix operating systems to ensure
# the system behaviour aligns with the behaviour defined by POSIX.
POSIXLY_CORRECT=1
export POSIXLY_CORRECT
