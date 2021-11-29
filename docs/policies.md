# 📓 Policies

[<< back to readme](../../README.md#contributing)

## [Contributor Covenant](#contributor-covenant)

A [code of conduct](https://www.contributor-covenant.org/version/1/4/code-of-conduct.html) for open source projects.

From the [website](https://www.contributor-covenant.org/version/1/4/code-of-conduct.html):

> In the interest of fostering an open and welcoming environment, we as contributors and maintainers pledge to make participation in our project and our community a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, sex characteristics, gender identity and expression, level of experience, education, socio-economic status, nationality, personal appearance, race, religion, or sexual identity and orientation.

## [Conventional Commits](#contributor-commits)

[Rules](https://www.conventionalcommits.org/en/v1.0.0/) for commit message formatting.

From the [website](https://www.conventionalcommits.org/en/v1.0.0/):

> The Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of. This convention dovetails with SemVer, by describing the features, fixes, and breaking changes made in commit messages.

*This project uses the [commitlint/config-conventional](https://github.com/conventional-changelog/commitlint/tree/master/%40commitlint/config-conventional) commit template.*

## [Semantic Versioning](#semantic-versioning)

A [version management](https://semver.org/) policy for software.  

From the [website](https://semver.org/):

> Consider a version format of X.Y.Z (Major.Minor.Patch). Bug fixes not affecting the API increment the patch version, backwards compatible API additions/changes increment the minor version, and backwards incompatible API changes increment the major version.

| Increment | Description                 | Conventional commit map |
| --------- | --------------------------- | ----------------------- |
| `MAJOR`   | Breaking changes introduced | `BREAKING CHANGE`       |
| `MINOR`   | New features                | `feat`                  |
| `PATCH`   | Fixes                       | `fix` + everything else |

- `fix` type commits should be part of a `PATCH` release.
- `feat` type commits should be part of a `MINOR` release.
- `BREAKING CHANGE` commits, regardless of type, should be part of a `MAJOR` release.

*This project uses [commitizen](https://github.com/commitizen-tools/commitizen) to bump the version.*
*The `cz commit` command opens an interactive tool for creating commits.*

[<< back to readme](../../README.md#contributing)
