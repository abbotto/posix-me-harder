#!/usr/bin/env sh

posix_me_harder() {
	eval "${*}"
}

Describe 'arguments'
	It "should accept a command when called directly in a supported shell"
		When call posix_me_harder \
			"./test/tmp/posix-me-harder 'echo hello-world'"
		The output should equal "hello-world"
	End

	It "should not accept a command when sourced in a supported shell"
		When call posix_me_harder \
			". ./test/tmp/posix-me-harder 'echo hello-world'"
		The output should equal ""
	End
End
