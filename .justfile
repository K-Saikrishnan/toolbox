[windows]
set shell := ["pwsh", "-NoLogo", "-Command"]

default:
  @just --list

[group('local')]
install:
  pnpm install
  uv sync
  uv run prek install --install-hooks

[group('ci')]
install_docker:
  pnpm install --silent


[group('build')]
build:
  pnpm ng build

[group('build')]
build_watch:
  pnpm ng build --watch --configuration development


[group('local')]
dev_server:
  pnpm ng serve


[group('fmt')]
fmt_check:
  pnpm oxfmt --no-error-on-unmatched-pattern --check
  pnpm prettier --check --ignore-unknown "**/*.html"

[group('fmt')]
fmt_write:
  pnpm oxfmt --no-error-on-unmatched-pattern
  pnpm prettier --write --ignore-unknown "**/*.html"


[group('lint')]
lint__commitlint_last:
  pnpm commitlint --last --verbose

[group('lint')]
lint__commitlint_pr from to:
  pnpm commitlint --from {{from}} --to {{to}} --verbose


[group('lint')]
lint__eslint:
  pnpm eslint

[group('lint')]
lint__eslint_fix:
  pnpm eslint --fix


[group('lint')]
lint__ls:
  pnpm ls-lint


[group('lint')]
lint__oxlint:
  pnpm oxlint

[group('lint')]
lint__oxlint_fix:
  pnpm oxlint --fix --fix-suggestions


[group('lint')]
lint__prek:
  uv run prek run --all-files

[group('lint')]
[group('ci')]
lint__prek_ci:
  uv run prek run --all-files --no-group=local


[group('lint')]
lint__typos:
  uv run typos

[group('lint')]
lint__typos_write:
  uv run typos --write-changes

lint__all: fmt_check lint__commitlint_last lint__eslint lint__ls lint__oxlint lint__prek lint__typos


[group('test')]
test:
  pnpm ng test
