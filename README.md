# Format NSIS

GitHub Action to format NSIS scripts using [ardent](https://github.com/idleberg/ardent).

## Usage

### Basic

```yaml
- name: Format NSIS Scripts
  uses: idleberg/format-nsis@v1
```

### With Options

```yaml
- name: Format NSIS Scripts
  uses: idleberg/format-nsis@v1
  with:
    eol: "lf"
    indent-size: "4"
    use-spaces: "true"
    print-width: "100"
```

### Check-Only Mode

```yaml
- name: Check NSIS Formatting
  uses: idleberg/format-nsis@v1
  with:
    check-only: "true"
```

## Inputs

| Input               | Description                                        | Required | Default             |
| ------------------- | -------------------------------------------------- | -------- | ------------------- |
| `version`           | Version of ardent to install                       | No       | (latest)            |
| `files`             | Files or glob patterns to format (space-separated) | No       | `**/*.nsi **/*.nsh` |
| `eol`               | Line ending style (`crlf` or `lf`)                 | No       | (platform default)  |
| `indent-size`       | Number of units per indentation level              | No       |                     |
| `use-spaces`        | Indent with spaces instead of tabs                 | No       | `false`             |
| `no-trim`           | Do not trim empty lines                            | No       | `false`             |
| `print-width`       | Maximum line width before wrapping (0 to disable)  | No       |                     |
| `check-only`        | Only check formatting without modifying files      | No       | `false`             |
| `working-directory` | Working directory to run ardent in                 | No       | (root)              |

## Example Workflows

### Format on Push

```yaml
name: Format NSIS Scripts

on:
  push:
    branches: [main]
    paths:
      - "**.nsi"
      - "**.nsh"

jobs:
  format:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Format NSIS Scripts
        uses: idleberg/format-nsis@v1

      - name: Commit changes
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add -A
          git diff --quiet && git diff --staged --quiet || \
            git commit -m "style: format NSIS scripts"
          git push
```

### Check Formatting in PRs

```yaml
name: CI

on:
  pull_request:
    branches: [main]
    paths:
      - "**.nsi"
      - "**.nsh"

jobs:
  check-format:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Check NSIS Formatting
        uses: idleberg/format-nsis@v1
        with:
          check-only: "true"
```

## Related

- [setup-ardent](https://github.com/idleberg/setup-ardent) - GitHub Action to install ardent
- [ardent](https://github.com/idleberg/ardent) - Opinionated formatter for NSIS scripts

## License

This work is licensed under [The MIT License](LICENSE).
