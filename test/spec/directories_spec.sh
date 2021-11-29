#!/usr/bin/env sh

unset XDG_CACHE_HOME
unset XDG_CONFIG_DIRS
unset XDG_CONFIG_HOME
unset XDG_DATA_DIRS
unset XDG_DATA_HOME

Include ./test/tmp/posix-me-harder

posix_me_harder() {
	eval "${*}"
}

Describe 'directories'
	It "should set the 'XDG_CACHE_HOME' variable"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'printf "%s" "${XDG_CACHE_HOME}"'
		The output should equal "$HOME/.cache"
	End

	It "should set the 'XDG_CONFIG_DIRS' variable"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'printf "%s" "${XDG_CONFIG_DIRS}"'
		The output should equal "/etc/xdg"
	End

	It "should set the 'XDG_CONFIG_HOME' variable"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'printf "%s" "${XDG_CONFIG_HOME}"'
		The output should equal "$HOME/.config"
	End

	It "should set the 'XDG_DATA_DIRS' variable"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'printf "%s" "${XDG_DATA_DIRS}"'
		The output should equal "/usr/local/share/:/usr/share/"
	End

	It "should set the 'XDG_DATA_HOME' variable"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'printf "%s" "${XDG_DATA_HOME}"'
		The output should equal "$HOME/.local/share"
	End

	It "should ensure the 'XDG_CONFIG_HOME' directory exists"
		check_config_path(){
			exit_code=1
			[ -d "${XDG_CONFIG_HOME}" ] && exit_code=0
			echo "${exit_code}"
		}

		When call check_config_path
		The output should equal 0
	End

	It "should ensure the 'XDG_DATA_HOME' directory exists"
		check_data_path(){
			exit_code=1
			[ -d "${XDG_DATA_HOME}" ] && exit_code=0
			echo "${exit_code}"
		}

		When call check_data_path
		The output should equal 0
	End
End
