#!/usr/bin/env bash
# Bootstrap a dev environment from these dotfiles.
# Idempotent: safe to re-run. Existing real files are backed up to <file>.bak.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$HOME/.local/bin"
mkdir -p "$BIN" "$HOME/.config"

log() { printf '\n==> %s\n' "$*"; }

# Symlink src -> dst, backing up an existing real file/dir once.
link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then rm -f "$dst"; fi
  if [ -e "$dst" ]; then mv "$dst" "$dst.bak"; echo "backed up $dst -> $dst.bak"; fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "linked $dst -> $src"
}

# Download the latest GitHub release asset matching a pattern.
gh_release_asset() {
  local repo="$1" pattern="$2"
  curl -s "https://api.github.com/repos/$repo/releases/latest" \
    | grep -oE "https://[^\"]*$pattern" | head -1
}

install_omz() {
  if [ -d "$HOME/.oh-my-zsh" ]; then echo "oh-my-zsh present"; return; fi
  log "Installing oh-my-zsh"
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_zsh_plugins() {
  local dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  log "Installing zsh plugins"
  [ -d "$dir/zsh-autosuggestions" ] || \
    git clone -q https://github.com/zsh-users/zsh-autosuggestions "$dir/zsh-autosuggestions"
  [ -d "$dir/zsh-syntax-highlighting" ] || \
    git clone -q https://github.com/zsh-users/zsh-syntax-highlighting "$dir/zsh-syntax-highlighting"
}

install_chafa() {
  command -v chafa >/dev/null && { echo "chafa present"; return; }
  log "Installing chafa"
  sudo apt-get update -qq && sudo apt-get install -y chafa
}

install_yazi() {
  command -v yazi >/dev/null && { echo "yazi present"; return; }
  log "Installing yazi"
  local url; url="$(gh_release_asset sxyazi/yazi 'yazi-x86_64-unknown-linux-gnu.zip')"
  local tmp; tmp="$(mktemp -d)"
  curl -sL "$url" -o "$tmp/yazi.zip" && unzip -oq "$tmp/yazi.zip" -d "$tmp"
  install -m755 "$tmp"/*/yazi "$BIN/yazi"
  install -m755 "$tmp"/*/ya   "$BIN/ya"
  rm -rf "$tmp"
}

install_resvg() {
  command -v resvg >/dev/null && { echo "resvg present"; return; }
  log "Installing resvg (SVG previews)"
  local url; url="$(gh_release_asset linebender/resvg 'resvg-linux-x86_64.tar.gz')"
  local tmp; tmp="$(mktemp -d)"
  curl -sL "$url" -o "$tmp/resvg.tar.gz" && tar xzf "$tmp/resvg.tar.gz" -C "$tmp"
  install -m755 "$tmp/resvg" "$BIN/resvg"
  rm -rf "$tmp"
}

install_nvchad_deps() {
  # ripgrep powers NvChad's telescope live-grep; nice to have.
  command -v rg >/dev/null || { log "Installing ripgrep"; sudo apt-get install -y ripgrep; }
}

link_configs() {
  log "Linking configs"
  link "$DOTFILES/home/.zshrc"     "$HOME/.zshrc"
  link "$DOTFILES/home/.tmux.conf" "$HOME/.tmux.conf"
  link "$DOTFILES/config/nvim"     "$HOME/.config/nvim"
  # yazi: link individual files so ya-managed flavors/ stays local
  link "$DOTFILES/config/yazi/theme.toml"   "$HOME/.config/yazi/theme.toml"
  link "$DOTFILES/config/yazi/package.toml" "$HOME/.config/yazi/package.toml"
}

restore_yazi_flavors() {
  command -v ya >/dev/null || return 0
  log "Restoring yazi flavors from package.toml"
  ya pkg install || true
}

main() {
  install_omz
  install_zsh_plugins
  install_chafa
  install_yazi
  install_resvg
  install_nvchad_deps
  link_configs
  restore_yazi_flavors
  log "Done. Open a new shell. On first nvim launch, plugins bootstrap automatically."
}

main "$@"
