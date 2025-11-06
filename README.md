# My Arch Linux Dotfiles

Hyprland setup managed with GNU Stow.

## 📦 Included Configs

- **Hyprland** - Wayland compositor
- **Waybar** - Status bar
- **Mako** - Notification daemon
- **Kitty** - Terminal emulator
- **btop** - System monitor
- **cava** - Audio visualizer
- **fastfetch** - System info
- **walker** - Application launcher
- **omarchy** - Theme manager
- **mimeapps.list** - Default applications

## 🚀 Installation
```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Stow all configs
stow btop cava fastfetch hypr kitty mako omarchy walker waybar misc

# Or stow individually
stow hypr
stow waybar
stow kitty
```

## 🔧 Usage
```bash
# Install a config
stow <package-name>

# Remove a config
stow -D <package-name>

# Reinstall a config
stow -R <package-name>
```

## 📝 Notes

- Configs are symlinked from `~/dotfiles` to `~/.config`
- Backups stored in `~/config_backup` before initial setup
- Edit files normally - they're symlinked so changes sync automatically

## 🔄 Updating
```bash
cd ~/dotfiles
git add .
git commit -m "Update configs"
git push
```
