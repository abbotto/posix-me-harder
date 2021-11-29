#!/usr/bin/env sh

Include ./test/tmp/posix-me-harder

posix_me_harder() {
	eval "${*}"
}

Describe 'brace expansion'
	It "should be disabled"
		When call posix_me_harder \
			"printf '%s' '{a,b,c}'"
		The output should equal '{a,b,c}'
	End
End
