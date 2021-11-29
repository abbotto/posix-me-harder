#!/usr/bin/env sh

Include ./test/tmp/posix-me-harder

posix_me_harder() {
	eval "${*}"
}

Describe 'posix-me-harder module'
	It "should set the 'POSIXLY_CORRECT' variable"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'printf "%s" "${POSIXLY_CORRECT}"'
    	The output should equal '1'
	End
End
