#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/enchf/shell-kit.git"
TARGET_DIR="$HOME/.shell-kit"

if [ -d "$TARGET_DIR/.git" ]; then
  echo "Updating existing installation..."
  git -C "$TARGET_DIR" pull --ff-only
else
  echo "Cloning repository..."
  git clone --depth 1 "$REPO_URL" "$TARGET_DIR"
fi

# Helper to idempotently append lines to a file
append_once() {
  local marker="$1"; shift
  local file="$1"; shift
  local content="$1"; shift || true
  mkdir -p "$(dirname "$file")"
  touch "$file"
  if ! grep -Fq "$marker" "$file" 2>/dev/null; then
    echo "Adding sourcing lines to $file"
    printf "%s\n" "$content" >> "$file"
  else
    echo "Sourcing lines already present in $file"
  fi
}

ZSH_MARKER="# shell-kit zsh"
ZSH_LINES=$'\n# shell-kit zsh\n[ -f "$HOME/.shell-kit/aliases.sh" ] && source "$HOME/.shell-kit/aliases.sh"\n[ -f "$HOME/.shell-kit/functions.sh" ] && source "$HOME/.shell-kit/functions.sh"'

BASH_MARKER="# shell-kit bash"
BASH_LINES=$'\n# shell-kit bash\n[ -f "$HOME/.shell-kit/aliases.sh" ] && source "$HOME/.shell-kit/aliases.sh"\n[ -f "$HOME/.shell-kit/functions.sh" ] && source "$HOME/.shell-kit/functions.sh"'

# Detect login shell binary name (zsh/bash)
shell_name="$(basename "${SHELL:-}")"

case "$shell_name" in
  zsh)
    append_once "$ZSH_MARKER" "$HOME/.zprofile" "$ZSH_LINES"
    append_once "$ZSH_MARKER" "$HOME/.zshrc" "$ZSH_LINES"
    ;;
  bash)
    # Login: prefer ~/.bash_profile, fall back to ~/.profile
    if [ -n "${HOME:-}" ]; then
      if [ -f "$HOME/.bash_profile" ] || [ ! -f "$HOME/.profile" ]; then
        append_once "$BASH_MARKER" "$HOME/.bash_profile" "$BASH_LINES"
      else
        append_once "$BASH_MARKER" "$HOME/.profile" "$BASH_LINES"
      fi
      append_once "$BASH_MARKER" "$HOME/.bashrc" "$BASH_LINES"
    fi
    ;;
  *)
    echo "Unknown shell ($shell_name). Adding zsh-style lines to ~/.zprofile and ~/.zshrc by default."
    append_once "$ZSH_MARKER" "$HOME/.zprofile" "$ZSH_LINES"
    append_once "$ZSH_MARKER" "$HOME/.zshrc" "$ZSH_LINES"
    ;;
esac

echo "Done! Open a new shell or 'source ~/.zprofile' or 'source ~/.zshrc' (or for bash, 'source ~/.bashrc') to load changes."
