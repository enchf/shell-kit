# shell-kit Reference

This document lists the aliases and functions provided by shell-kit.

## Aliases

- `gs` — `git status`
- `ga` — `git add`
- `gca` — `git commit --amend`
- `gfa` — `git fetch --all`
- `gpf` — `git push -f` (force push)
- `gp` — `git pull`
- `gph` — `git push`
- `gc` — `git checkout`
- `gr` — `git rebase`
- `gb` — `git branch`
- `cb` — `git rev-parse --abbrev-ref HEAD` (print current branch)
- `cbn` — `cb | pbcopy` (copy current branch name to clipboard; macOS `pbcopy`)
- `gpu` — `git push -u origin` (set upstream when pushing a new branch)
- `glog` — `git log --all --graph --decorate --name-only`
- `reload-shell-kit` — `source ~/.zprofile` (reload shell-kit in current shell; for bash use `source ~/.bashrc`)

## Functions

- `mkcd <dir>`
  - Create a directory (including parents) and `cd` into it.
  - Example:
    ```bash
    mkcd projects/new-repo
    ```

- `prune-git`
  - Fetch with `--prune`, show branches whose upstream is gone, then delete those local branches.
  - What it runs:
    ```bash
    git fetch --prune
    git branch -vv | grep ': gone]' | awk '{print $1}'
    git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D
    ```
  - Note: review the list printed by the second command before deletion to ensure it matches your expectations.

## Notes

- Clipboard alias `cbn` uses `pbcopy`, which is available on macOS. On Linux, you may install `xclip` or `xsel` and adapt accordingly.
- The installer adds sourcing lines to your shell startup files so these are available automatically. See the README for details.
