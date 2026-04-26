# dotfiles

My personal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Install

```sh
git clone https://github.com/justindotdevv/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Install specific packages only:

```sh
./install.sh nvim zsh tmux
```

Preview without changes:

```sh
./install.sh --dry-run
```

## What's inside

Hyprland · Waybar · Walker · Mako · Alacritty · Kitty · Foot · Neovim · Tmux · Zsh · Bash · Lazygit · Btop · Fastfetch · Cava · Superfile · and more.

## Notes

- Conflicting files are backed up to `~/.dotfiles-backup-<timestamp>/` by default.
- Use `--no-backup` to overwrite instead.
- Tmux plugins: open tmux and press `prefix + I`.
