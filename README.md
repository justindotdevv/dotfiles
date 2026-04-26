# dotfiles

My personal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Install

Install GNU Stow, clone the repo, then stow the modules you want:

```sh
git clone https://github.com/justindotdevv/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow nvim zsh tmux
```

Stow everything:

```sh
stow */
```

Remove a module:

```sh
stow -D nvim
```

## What's inside

Hyprland · Waybar · Walker · Mako · Alacritty · Kitty · Foot · Neovim · Tmux · Zsh · Bash · Lazygit · Btop · Fastfetch · Cava · Superfile · and more.

## Notes

- Stow will refuse to overwrite existing files — back up or remove conflicting configs first.
- Tmux plugins: install [TPM](https://github.com/tmux-plugins/tpm), then press `prefix + I` inside tmux.
