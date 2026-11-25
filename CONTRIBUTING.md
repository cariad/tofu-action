# Contributing

## Bug reports and feature requests

Bug reports and feature requests are very welcome! Please create them as [issues](https://github.com/cariad/tofu-action/issues).

Issues written with AI assistance are welcome.

## Code changes

If you want to contribute a code change, please find or create the [issue](https://github.com/cariad/tofu-action/issues) first, then leave a comment to mention [@cariad](https://github.com/cariad) to let me know you want to take it on. Wait until we've discussed and agreed the change before submitting a pull request.

**Unplanned and unexpected pull requests won't be accepted.**

To set up the project on your development machine, see [Setup](#setup).

Code written with AI assistance is welcome.

## Required tools

- [mise](https://mise.jdx.dev/)

## Setup

1. Clone this repository.

   ```bash
   git clone git@github.com:cariad/tofu-action.git
   ```

1. Change into the repository's directory.

   ```bash
   cd tofu-action
   ```

1. Install the project's tools.

   ```bash
   mise install
   ```

1. To verify the setup, run the linters and check they all pass.

   ```bash
   mise run lint
   ```

## Testing

CI's `test` job runs the action on every runner and OpenTofu version in its matrix, against the modules in `tests`. They keep their state in local files, so they need no secrets.

- It plans `tests/changes`, which adds a resource, and `tests/failure`, whose plan always fails.
- On a pull request, it checks that the action commented both plans. It also checks that applying `tests/changes` fails, as it must for a pull request that isn't merged, so every run comments "Apply failed" on the pull request too.
- On a push to `main`, it applies `tests/changes`, and checks the state.

CI can't merge a pull request, so it never runs the README's apply workflow, or posts its comment on a merged pull request.

A pull request from a fork gets a token that can't comment, so its `test` jobs fail. Push to your fork's `main` to run the tests instead.

## Bumping versions

Dependabot bumps the actions in `action.yml` and `.github/workflows/`. Bump everything else by hand:

- **OpenTofu:** the `tofu` matrix in the `test` job in `.github/workflows/ci.yml`, and `tofu-version` in the README's examples.
- **mise:** `min_version` in `.config/mise.toml`, and `version` in the `jdx/mise-action` step in `.github/workflows/ci.yml`.
- **Tools:** `.config/mise.toml`, then run `mise lock`.
- **Runners:** the `runner` matrix in the `test` job and the `lint` job's `runs-on` in `.github/workflows/ci.yml`.
