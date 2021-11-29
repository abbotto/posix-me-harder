#!/usr/bin/env sh

set -u

current_tag=$(git tag --points-at)

Describe 'release'
	It "should have no uncommitted changes"
        check_git_status(){
            result=$(git status -s)

            if [ -z "${result}" ]; then
                result='pass'
            else
                result='fail'
            fi

            printf '%s' "${result}"
        }

		When call check_git_status
    	The output should equal 'pass'
	End

	It "should have a git tag on the current commit"
        check_git_commit_tag(){
            if [ -z "${current_tag}" ]; then
                result='fail'
            else
                result='pass'
            fi

            printf '%s' "${result}"
        }

		When call check_git_commit_tag
    	The output should equal 'pass'
	End

	It "should have a git tag that's correctly formatted"
        check_git_tag_version(){
            case "${current_tag}" in
                [0-9].[0-9].[0-9]) result='[0-9].[0-9].[0-9]' ;;
                *) result="${current_tag}" ;;
            esac
            printf '%s' "${result}"
        }

		When call check_git_tag_version
    	The output should equal '[0-9].[0-9].[0-9]'
	End

	It "should have a git tag that matches the current version"
        match_git_tag_with_version(){
            if [ "${current_tag}" = "$(cat ./.version)" ]; then
                result='pass'
            else
                result='fail'
            fi

            printf '%s' "${result}"
        }

		When call match_git_tag_with_version
    	The output should equal 'pass'
	End

	It "should be on the 'main' branch"
        check_git_branch(){
            if [ "$(git tag --points-at main)" != "${current_tag}" ]; then
                result="$(git tag --points-at main)"
            else
                result="${current_tag}"
            fi

            printf '%s' "${result}"
        }

		When call check_git_branch
    	The output should equal "$(cat .version)"
	End

	It "should include the latest tag in 'CHANGELOG.md'"
        check_changelog(){
            if grep -qF "## ${current_tag}" CHANGELOG.md; then
                result='pass'
            else
                result='fail'
            fi

            printf '%s' "${result}"
        }

		When call check_changelog
    	The output should equal 'pass'
	End
End
