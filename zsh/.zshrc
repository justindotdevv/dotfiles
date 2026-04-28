# --- Time format ---
TIMEFMT=$'\ncpu\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=32768
SAVEHIST=32768
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# --- Completion ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt AUTO_CD

# --- Key bindings ---
bindkey -v
export KEYTIMEOUT=1

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Vi-mode cursor shape (beam in insert, block in normal)
_set_cursor() {
  case $KEYMAP in
    vicmd)        printf '\e[2 q' ;;  # block
    main|viins|*) printf '\e[6 q' ;;  # beam
  esac
}
zle-keymap-select() { _set_cursor }
zle-line-init()     { _set_cursor }
zle -N zle-keymap-select
zle -N zle-line-init
preexec() { printf '\e[6 q' }  # reset to beam before running commands

# --- PATH additions (before omarchy so omarchy bin takes priority) ---
export PATH="$HOME/.cache/.bun/bin:$PATH"
export PATH="$HOME/.amp/bin:$PATH"
export PATH="$HOME/.termcast/compiled/tuitube/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

# --- Source secrets ---
[[ -f "$HOME/.secrets" ]] && . "$HOME/.secrets"

# --- Source environment files ---
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# --- Omarchy envs (ported from bash) ---
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi
export OMARCHY_PATH=$HOME/.local/share/omarchy
export PATH=$OMARCHY_PATH/bin:$PATH:$HOME/.local/bin

# --- Pi coding agent config ---
export PI_CODING_AGENT_DIR="$HOME/.config/pi"

# --- Omarchy aliases ---
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias eff='$EDITOR "$(ff)"'

if command -v zoxide &> /dev/null; then
  zd() {
    if [[ $# -eq 0 ]]; then
      builtin cd ~ && return
    elif [[ -d "$1" ]]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
  alias cd="zd"
fi

open() {
  xdg-open "$@" >/dev/null 2>&1 &
}

alias helium='helium-browser'
alias dl='yt-dlp'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='opencode'
alias cx='printf "\033[2J\033[3J\033[H" && claude --allow-dangerously-skip-permissions'
alias d='docker'
alias r='rails'
alias s='spf'
alias t='tmux attach || tmux new'
n() { if [[ $# -eq 0 ]]; then command nvim . ; else command nvim "$@"; fi; }
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# --- Omarchy functions ---
for f in $OMARCHY_PATH/default/bash/fns/*; do source "$f"; done

# --- Personal overrides ---
alias ts='tailscale'
alias :so='source ~/.zshrc'
alias :q='exit'
alias ex='exit'
alias oc='opencode'
alias zen='zen-browser'
alias zed='zeditor'
alias lg='lazygit'
alias in='omarchy-pkg-aur-install'

gac() {
  git add -u && git commit -m "$(lumen draft)"
}

faf() {
  fastfetch -l arch
}

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# --- Flutter / Android ---
export PATH="$HOME/.local/share/mise/installs/flutter/latest/bin:$PATH"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export PATH="$PATH:$JAVA_HOME/bin"
export CHROME_EXECUTABLE=/usr/bin/chromium

# --- Tool inits ---
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if command -v try &> /dev/null; then
  eval "$(SHELL=/bin/zsh try init ~/Work/tries)"
fi

if command -v fzf &> /dev/null; then
  source <(fzf --zsh 2>/dev/null) || true
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# --- Plugins (syntax highlighting + autosuggestions) ---
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- Startup ---
fastfetch -l arch

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

[[ -f "$HOME/.daytona.completion_script.zsh" ]] && source "$HOME/.daytona.completion_script.zsh"
