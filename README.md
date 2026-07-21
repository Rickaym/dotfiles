# dotfiles

Personal dev environment: zsh (oh-my-zsh), NvChad (Neovim), yazi, tmux.
Symlink-based so edits to the live files are tracked here directly.

## What's here

    home/.zshrc        zsh + oh-my-zsh config, PATH, EDITOR, aliases
    home/.tmux.conf    tmux (transparent status bar, sixel passthrough, RGB)
    config/nvim/       NvChad-based Neovim config (plugins pinned in lazy-lock.json)
    config/yazi/       yazi theme + package manifest (flavors restored via ya pkg)
    install.sh         idempotent bootstrap: installs tools + symlinks configs

## New machine

    git clone https://github.com/rickaym/dotfiles ~/.dotfiles
    ~/.dotfiles/install.sh

The script installs oh-my-zsh, yazi, chafa, resvg, ripgrep, symlinks every
config (backing up any existing file to `<file>.bak`), and restores yazi
flavors. Neovim plugins bootstrap on first launch.

## Notes

- Tool installs assume Debian/Ubuntu (apt) on x86_64.
- `EDITOR=nvim`; yazi opens files in nvim. In nvim, `<leader>y` opens yazi.
- yazi flavors (catppuccin) are not vendored; `ya pkg install` fetches them
  from the pinned revs in `config/yazi/package.toml`.
- To add a config: place it under this repo, add a `link` line in
  `install.sh`, commit.
