# dotfiles

M personal configuration files for **Arch + Hyprland (Omarchy)**, managed with [GNU Stow](https://www.gnu.org/software/stow/).

A handful of modules (`zsh`, `nvim`, `tmux`, `git`, `alacritty`, `kitty`, `btop`) are portable to other Unix systems; the rest assume a Wayland/Hyprland setup.

## Install

Clone the repo:

```sh
git clone https://github.com/justindotdevv/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

If you're on a fresh Omarchy install, back up the defaults that would conflict:

```sh
for d in hypr waybar walker mako alacritty kitty foot btop fastfetch; do
  [ -e ~/.config/$d ] && mv ~/.config/$d ~/.config/$d.bak
done
```

Stow the modules you want:

```sh
stow nvim zsh tmux hypr waybar walker mako
```

Or use `--adopt` to pull existing files into the repo (then `git diff` to review before committing):

```sh
stow --adopt hypr
```

Remove a module:

```sh
stow -D nvim
```

## Tmux plugins

```sh
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Then open tmux and press `prefix + I`.

## What's inside

Hyprland · Waybar · Walker · Mako · Alacritty · Kitty · Foot · Neovim · Tmux · Zsh · Bash · Lazygit · Btop · Fastfetch · Cava · Superfile · and more.

## Notes

- Dependencies (Hyprland, waybar, neovim, etc.) are assumed to be installed already — stow only symlinks configs.
- Some configs reference Omarchy's theme system (`~/.config/omarchy/current/theme/...`) and will dangle outside of Omarchy.
