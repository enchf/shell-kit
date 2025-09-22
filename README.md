# shell-kit

A lightweight, cross-platform kit of shell aliases and functions for Linux and macOS.

Easily install and keep them up to date with a single command.

---

## 📚 Reference

See the full list of aliases and functions in the [docs/REFERENCE.md](docs/REFERENCE.md).

## 🚀 Installation

Run this in your terminal (requires `git`):

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/enchf/shell-kit/main/install.sh)
```

This will:

- Clone (or update) the repository to ~/.shell-kit.
- Add sourcing lines to your shell startup files:
  - For zsh: `~/.zprofile` (login shells) and `~/.zshrc` (interactive shells).
  - For bash: `~/.bash_profile` (or `~/.profile`) and `~/.bashrc`.
- Make the aliases and functions available on your next shell session.

## 🔄 Updating

To update to the latest version:

```bash
~/.shell-kit/install.sh
```

Or simply:

```bash
cd ~/.shell-kit && git pull
```

## 🧩 Customization

Keep personal tweaks in a separate file (e.g., ~/.zshrc.local).
shell-kit will never overwrite your ~/.zprofile; it only appends sourcing lines once.

## 🐛 Troubleshooting

Make sure you’re using Zsh as your login shell:

```bash
echo $SHELL
```

Should return something like `/bin/zsh`.

If the aliases don’t load, verify that your ~/.zprofile contains:

```bash
[ -f "$HOME/.shell-kit/aliases.sh" ] && source "$HOME/.shell-kit/aliases.sh"
[ -f "$HOME/.shell-kit/functions.sh" ] && source "$HOME/.shell-kit/functions.sh"
```

If you use bash, check `~/.bash_profile` (or `~/.profile`) and `~/.bashrc` for the same lines.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
