# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/) for easy symlink management across machines.

## Prerequisites

### Required
- **Git** - Version control
- **GNU Stow** - Symlink farm manager

### Optional
- **TPM** (Tmux Plugin Manager) - For tmux plugins
- **Omarchy** - For Hyprland theme integration (see [Hyprland](#hyprland) section)

## Installation

### Quick Start

```bash
# Clone the repository
git clone https://github.com/justindotdevv/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the bootstrap script
./install.sh
```

### Manual Installation

If you prefer to install manually or selectively:

```bash
# Install GNU Stow
# Linux (Debian/Ubuntu)
sudo apt install stow

# Linux (Arch)
sudo pacman -S stow

# Linux (Fedora)
sudo dnf install stow

# macOS
brew install stow

# Stow individual packages
stow nvim      # Installs nvim config
stow zsh       # Installs zsh config
stow hypr      # Installs hyprland config
# ... etc

# Or stow everything at once
stow */
```

### Selective Installation

The bootstrap script supports selective package installation:

```bash
./install.sh              # Install all packages
./install.sh nvim zsh     # Install only nvim and zsh
./install.sh --dry-run    # Preview what would be done
./install.sh --no-backup  # Don't backup existing files
```

## Managed Applications

### Terminals
- **Alacritty** - GPU-accelerated terminal emulator
- **Kitty** - GPU-based terminal emulator

### Shell
- **Zsh** - Z shell configuration
- **Bash** - Bourne again shell configuration

### Editors
- **Neovim** - Hyperextensible Vim-based text editor (LazyVim distribution)
- **Zed** - High-performance, multiplayer code editor

### Window Management
- **Hyprland** - Dynamic tiling Wayland compositor
- **Waybar** - Highly customizable Wayland bar
- **Mako** - Lightweight notification daemon
- **NWG Dock** - GTK3 dock for Hyprland
- **SwayOSD** - On-screen display for Sway/Hyprland

### Terminal Multiplexer
- **Tmux** - Terminal multiplexer with plugins (resurrect, continuum, yank)

### System Utilities
- **Btop** - Resource monitor
- **Fastfetch** - System information tool
- **Cava** - Console-based audio visualizer

### File Management
- **Superfile** - Modern terminal file manager
- **Walker** - Application launcher

### Development Tools
- **Lazygit** - Simple terminal UI for git commands
- **Vicinae** - Development utility
- **Voxtype** - Typing practice tool

### Miscellaneous
- **Misc** - MIME type associations and other configurations

## Application-Specific Notes

### Hyprland

The Hyprland configuration sources theme files from Omarchy:

```conf
source = ~/.local/share/omarchy/default/hypr/*.conf
source = ~/.config/omarchy/current/theme/hyprland.conf
```

**Important:** If Omarchy is not installed, you'll need to:
1. Install [Omarchy](https://github.com/justindotdevv/omarchy) (or remove these source lines)
2. Or provide your own theme configuration

### Neovim

Uses [LazyVim](https://www.lazyvim.org/) distribution. First run will automatically:
- Install Lazy.nvim plugin manager
- Download and configure plugins
- Generate `lazy-lock.json`

The theme file is symlinked from Omarchy (machine-local).

### Tmux

Uses TPM (Tmux Plugin Manager) for plugin management. After installation:

```bash
# Install plugins
tmux
prefix + I  # Default prefix is Ctrl-a or Ctrl-b
```

Plugins included:
- `tmux-resurrect` - Save and restore tmux sessions
- `tmux-continuum` - Continuous saving of tmux environment
- `tmux-yank` - Copy to system clipboard

### Shell (Zsh/Bash)

Configuration files are symlinked:
- `~/.zshrc` → `~/dotfiles/zsh/.zshrc`
- `~/.bashrc` → `~/dotfiles/bash/.bashrc`

## Adding New Configurations

To add a new application configuration:

```bash
# Example: adding a new app called "foo"
cd ~/dotfiles

# Create directory structure matching ~/.config
mkdir -p foo/.config/foo

# Move your existing config
mv ~/.config/foo/* foo/.config/foo/

# Stow it
stow foo

# Commit it
git add foo
git commit -m "feat(foo): add foo configuration"
```

## Removing Configurations

```bash
# Remove a stowed package
cd ~/dotfiles
stow -D <package-name>

# Delete the package directory
rm -rf <package-name>
git add -A
git commit -m "chore: remove <package-name> configuration"
```

## Updating

```bash
cd ~/dotfiles
git pull
./install.sh  # Re-run to ensure all symlinks are up to date
```

## Structure

```
dotfiles/
├── alacritty/.config/alacritty/
├── bash/.bashrc
├── btop/.config/btop/
├── cava/.config/cava/
├── fastfetch/.config/fastfetch/
├── hypr/.config/hypr/
├── kitty/.config/kitty/
├── lazygit/.config/lazygit/
├── mako/.config/mako/
├── misc/.config/
├── nvim/.config/nvim/
├── nwg-dock-hyprland/.config/nwg-dock-hyprland/
├── superfile/.config/superfile/
├── swayosd/.config/swayosd/
├── tmux/.config/tmux/
├── vicinae/.config/vicinae/
├── voxtype/.config/voxtype/
├── walker/.config/walker/
├── waybar/.config/waybar/
├── zed/.config/zed/
└── zsh/.zshrc
```

## Customization

### Environment Variables

Some configurations may use environment variables. Add these to your shell profile:

```bash
# Example
export EDITOR=nvim
export TERMINAL=alacritty
```

### Machine-Specific Configuration

For machine-specific settings, consider:
1. Creating a `local.conf` file sourced by your configs
2. Using environment variables
3. Creating separate branches for different machines

## Troubleshooting

### Symlink Conflicts

If stow reports conflicts:

```bash
# Remove existing files manually
rm ~/.zshrc

# Or use the --no-backup flag with install.sh
./install.sh --no-backup
```

### TPM Not Working

```bash
# Ensure TPM is installed
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Then inside tmux, press prefix + I (capital i)
```

### Omarchy Theme Missing

If you see errors about missing Omarchy files, either:
1. Install Omarchy
2. Remove/comment out the Omarchy source lines in `hypr/.config/hypr/hyprland.conf`

## License

Personal configuration files.
