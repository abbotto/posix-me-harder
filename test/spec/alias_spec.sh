#!/usr/bin/env sh

Include ./test/tmp/posix-me-harder

posix_me_harder() {
	eval "${*}"
}

Describe 'alias'
	It "should have expansion enabled"
		alias echo='echo hello-world'
		When call posix_me_harder \
			'echo hello-world'
		The output should equal 'hello-world hello-world'
	End

	It "should be disabled"
		alias echo='echo hello-world'
		When call posix_me_harder \
			'\echo hello-world'
		The output should equal 'hello-world'
	End
End
