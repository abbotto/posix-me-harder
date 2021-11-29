#!/usr/bin/env sh

Include ./test/tmp/posix-me-harder

posix_me_harder() {
	eval "${*}"
}

Describe 'echo'
	It "should expand backslash-escape sequences"
		When call posix_me_harder \
			'echo "Hello\nworld"'
		The output should equal 'Hello
world'
	End

	It "should not take '-n' arguments"
		When call posix_me_harder \
			'echo -n ""'
		The output should equal '-n '
	End

	It "should not take '-e' arguments"
		When call posix_me_harder \
			'echo -e ""'
		The output should equal '-e '
	End

	# This test only matters for shells that require an 'echo' polyfill
	It "should reset the \$IFS variable to the correct value"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'IFS="IFS"; export IFS; echo >/dev/null 2>&1; printf "%s" "${IFS}"'
		The output should equal "IFS"
	End
End
