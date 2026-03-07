#!/usr/bin/env bash

# Dotfiles Bootstrap Script
# Automatically installs GNU Stow and symlinks all configurations

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script configuration
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false
NO_BACKUP=false
PACKAGES=()

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

# Print functions
info() {
    echo -e "${BLUE}→${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

dry_run() {
    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${YELLOW}[DRY RUN]${NC} $1"
    fi
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install GNU Stow based on OS
install_stow() {
    if command_exists stow; then
        success "GNU Stow is already installed"
        return 0
    fi

    info "Installing GNU Stow..."

    if [[ "$DRY_RUN" == true ]]; then
        dry_run "Would install GNU Stow"
        return 0
    fi

    case "$OS" in
        linux)
            if command_exists apt; then
                sudo apt update && sudo apt install -y stow
            elif command_exists pacman; then
                sudo pacman -S --noconfirm stow
            elif command_exists dnf; then
                sudo dnf install -y stow
            elif command_exists zypper; then
                sudo zypper install -y stow
            elif command_exists emerge; then
                sudo emerge app-admin/stow
            else
                error "Could not detect package manager. Please install GNU Stow manually."
                return 1
            fi
            ;;
        macos)
            if command_exists brew; then
                brew install stow
            else
                error "Homebrew is not installed. Please install it from https://brew.sh"
                return 1
            fi
            ;;
        *)
            error "Unsupported OS: $OS. Please install GNU Stow manually."
            return 1
            ;;
    esac

    success "GNU Stow installed successfully"
}

# Backup existing file
backup_file() {
    local file="$1"

    if [[ "$NO_BACKUP" == true ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            dry_run "Would remove: $file"
        else
            rm -rf "$file"
        fi
        return
    fi

    if [[ ! -d "$BACKUP_DIR" ]]; then
        mkdir -p "$BACKUP_DIR"
        info "Created backup directory: $BACKUP_DIR"
    fi

    local backup_path="$BACKUP_DIR/$(basename "$file")"
    local counter=1

    while [[ -e "$backup_path" ]]; do
        backup_path="$BACKUP_DIR/$(basename "$file")_$counter"
        ((counter++))
    done

    if [[ "$DRY_RUN" == true ]]; then
        dry_run "Would backup: $file -> $backup_path"
    else
        mv "$file" "$backup_path"
        info "Backed up: $file -> $backup_path"
    fi
}

# Stow a package
stow_package() {
    local package="$1"
    local package_path="$DOTFILES_DIR/$package"

    if [[ ! -d "$package_path" ]]; then
        warning "Package directory not found: $package"
        return 1
    fi

    # Check for conflicts
    local conflicts=()
    while IFS= read -r -d '' file; do
        local relative_path="${file#$package_path/}"
        local target_path="$HOME/$relative_path"

        if [[ -e "$target_path" && ! -L "$target_path" ]]; then
            conflicts+=("$target_path")
        fi
    done < <(find "$package_path" -type f -print0 2>/dev/null)

    # Handle conflicts
    if [[ ${#conflicts[@]} -gt 0 ]]; then
        info "Handling conflicts for $package..."
        for conflict in "${conflicts[@]}"; do
            if [[ -e "$conflict" ]]; then
                backup_file "$conflict"
            fi
        done
    fi

    # Stow the package
    if [[ "$DRY_RUN" == true ]]; then
        dry_run "Would stow: $package"
    else
        cd "$DOTFILES_DIR"
        stow --restow "$package" 2>&1 | while read -r line; do
            if [[ "$line" =~ "existing" ]] || [[ "$line" =~ "conflict" ]]; then
                warning "$line"
            else
                info "$line"
            fi
        done
        success "Stowed: $package"
    fi
}

# Get all available packages
get_all_packages() {
    local packages=()
    for dir in "$DOTFILES_DIR"/*/; do
        local package=$(basename "$dir")
        # Skip hidden directories and .git
        if [[ ! "$package" =~ ^\. ]] && [[ "$package" != ".git" ]]; then
            packages+=("$package")
        fi
    done
    echo "${packages[@]}"
}

# Initialize TPM (Tmux Plugin Manager)
init_tpm() {
    if [[ "$DRY_RUN" == true ]]; then
        dry_run "Would check/initialize TPM"
        return 0
    fi

    local tpm_path="$HOME/.config/tmux/plugins/tpm"

    if [[ ! -d "$tpm_path" ]]; then
        info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_path"
        success "TPM installed to $tpm_path"
        info "Run 'prefix + I' inside tmux to install plugins"
    else
        success "TPM already installed"
    fi
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dry-run|-n)
                DRY_RUN=true
                shift
                ;;
            --no-backup)
                NO_BACKUP=true
                shift
                ;;
            --help|-h)
                cat <<EOF
Usage: $(basename "$0") [OPTIONS] [PACKAGES...]

Bootstrap script for dotfiles managed with GNU Stow.

Options:
    -n, --dry-run      Show what would be done without making changes
    --no-backup        Remove conflicting files instead of backing them up
    -h, --help         Show this help message

Arguments:
    PACKAGES           Space-separated list of packages to install
                       If not specified, all packages will be installed

Examples:
    $(basename "$0")                  # Install all packages
    $(basename "$0") nvim zsh        # Install only nvim and zsh
    $(basename "$0") --dry-run       # Preview all changes
    $(basename "$0") --no-backup nvim # Install nvim without backing up

Available packages:
    $(get_all_packages)

EOF
                exit 0
                ;;
            -*)
                error "Unknown option: $1"
                echo "Run '$(basename "$0") --help' for usage"
                exit 1
                ;;
            *)
                PACKAGES+=("$1")
                shift
                ;;
        esac
    done
}

# Main function
main() {
    echo -e "${BLUE}Dotfiles Bootstrap Script${NC}"
    echo -e "${BLUE}========================${NC}"
    echo

    # Detect OS
    info "Detected OS: $OS"

    # Check for git
    if ! command_exists git; then
        error "Git is required but not installed"
        exit 1
    fi

    # Install Stow
    install_stow || exit 1

    # Determine which packages to install
    if [[ ${#PACKAGES[@]} -eq 0 ]]; then
        read -ra PACKAGES <<< "$(get_all_packages)"
        info "No packages specified, installing all packages"
    fi

    echo
    info "Packages to install: ${PACKAGES[*]}"
    echo

    # Stow packages
    for package in "${PACKAGES[@]}"; do
        stow_package "$package"
    done

    # Initialize TPM if tmux was installed
    if [[ " ${PACKAGES[*]} " =~ " tmux " ]]; then
        echo
        init_tpm
    fi

    echo
    if [[ "$DRY_RUN" == true ]]; then
        warning "Dry run complete. No changes were made."
        echo "Run without --dry-run to apply changes."
    else
        success "Dotfiles installation complete!"

        if [[ -d "$BACKUP_DIR" ]]; then
            echo
            info "Backups stored in: $BACKUP_DIR"
        fi

        echo
        info "Next steps:"
        echo "  • Restart your shell or run: source ~/.zshrc (or ~/.bashrc)"
        echo "  • For tmux: open tmux and press prefix + I to install plugins"
        echo "  • For nvim: first run will install plugins automatically"
    fi
}

# Run main function
parse_args "$@"
main
