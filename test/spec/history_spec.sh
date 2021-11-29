#!/usr/bin/env sh

Include ./test/tmp/posix-me-harder

posix_me_harder() {
	eval "${*}"
}

Describe 'history'
	It "should set the 'HISTSIZE' variable"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'printf "%s" "${HISTSIZE}"'
		The output should equal "2048"
	End

	It "should set the 'HISTFILE' variable"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'printf "%s" "${HISTFILE}"'
		The output should equal "${HOME}/.sh_history"
	End

	It "should set the 'FCEDIT' variable if it is unset"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'printf "%s" "${FCEDIT}"'
		The output should equal "$(command -v ed)"
	End
End
