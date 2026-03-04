# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PATH additions (before omarchy source so omarchy bin takes priority)
export PATH="$HOME/.cache/.bun/bin:$PATH"
export PATH="$HOME/.amp/bin:$PATH"
export PATH="$HOME/.termcast/compiled/tuitube/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

# Source secrets (API keys)
[[ -f "$HOME/.secrets" ]] && . "$HOME/.secrets"

# Source environment files
[[ -f "$HOME/.cargo/env" ]]                            && . "$HOME/.cargo/env"
[[ -f "$HOME/.local/share/omarchy/default/bash/rc" ]]  && . "$HOME/.local/share/omarchy/default/bash/rc"
[[ -f "$HOME/.local/bin/env" ]]                        && . "$HOME/.local/bin/env"

# Re-enable command hashing (omarchy disables it for mise, but it causes
# ble.sh to do expensive PATH lookups on every keystroke)
set -h

# --- Personal overrides (after omarchy source so these win) ---

alias ts='tailscale'
alias :so='source ~/.bashrc'
alias :q='exit'
alias ex='exit'
alias oc='opencode'
alias zen='zen-browser'
alias zed='zeditor'
alias lg='lazygit'

gac() {
  git add -u && git commit -m "$(lumen draft)"
}

faf() {
  fastfetch -l arch
}

fastfetch -l arch

# Flutter Android Development Environment
export PATH="$HOME/.local/share/mise/installs/flutter/latest/bin:$PATH"

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export PATH="$PATH:$JAVA_HOME/bin"

export CHROME_EXECUTABLE=/usr/bin/chromium

