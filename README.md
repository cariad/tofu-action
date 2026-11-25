# tofu-action

A GitHub Action that runs [OpenTofu](https://opentofu.org).

For example, the action can plan your infrastructure changes when you open a pull request, and apply them when you merge it.

It posts OpenTofu's output as comments on pull requests, so you can see what's going to change by a plan, and what *did* change after a deployment.

## Usage

To plan the module in `infra` for every pull request that changes it:

```yaml
on:
  pull_request:
    paths:
      - infra/**

jobs:
  plan:
    runs-on: ubuntu-26.04
    permissions:
      contents: read
      pull-requests: write

    steps:
      - uses: actions/checkout@<commit> # <release>
        with:
          persist-credentials: false

      - uses: cariad/tofu-action@<commit> # <release>
        env:
          MY_API_KEY: ${{ secrets.MY_API_KEY }}
        with:
          directory: infra
          mode: plan
          tofu-version: 1.13.9
```

Pass your backend's and providers' credentials in the step's `env`.

To apply a pull request when it's merged, use `mode: apply` in a workflow that runs on the pull request's `closed` event, in a job with `if: github.event.pull_request.merged`.

## Inputs

| Input          | Required | Description                                                                                |
| -------------- | -------- | ------------------------------------------------------------------------------------------ |
| `directory`    | Yes      | The module's directory, such as `infra`. The module must commit its `.terraform.lock.hcl`. |
| `mode`         | Yes      | `plan` to plan the changes, or `apply` to apply them.                                      |
| `tofu-version` | Yes      | The exact version of OpenTofu to run, such as `1.13.9`.                                    |

## Security

A plan runs the pull request's OpenTofu code with the credentials that you pass it. Plans don't lock the state, so give them read-only credentials where you can.

GitHub doesn't hide secrets in comments, so mark secret values as `sensitive` in your OpenTofu code.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) to learn about contributing bug reports, feature requests, and code changes.
