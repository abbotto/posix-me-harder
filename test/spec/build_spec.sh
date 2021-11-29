#!/usr/bin/env sh

Include ./test/tmp/posix-me-harder

posix_me_harder() {
	eval "${*}"
}

Describe 'module'
	It "should only have one shebang"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'grep -o "#!/usr/bin/env sh" ./test/tmp/posix-me-harder | wc -l | tr -d " "'
		The output should equal "1"
	End

	It "should have the correct version"
		version="$(cat .version)"
		# shellcheck disable=SC2016
		When call posix_me_harder \
			'echo $_PMH_VERSION_'
		The output should equal "${version}"
	End
	It "should not contain comments"
		number_of_comments=$(
			awk '/^#/ {if (NR>5) {print $1}}' ./test/tmp/posix-me-harder | wc -l
		)
		# shellcheck disable=SC2016
		When call posix_me_harder \
			 "echo $number_of_comments"
		The output should equal "0"
	End
End
