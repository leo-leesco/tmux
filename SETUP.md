# tmux config

## Setup

After cloning, point this repo at its versioned hooks directory:

```sh
git -C ~/.config/tmux config core.hooksPath hooks
```

This activates `hooks/post-commit`, which reloads `tmux.conf` in the running
tmux server after each commit. It's a no-op when no server is running.

Git deliberately ignores files under `.git/hooks/` from commits, so the hook
script lives at `hooks/post-commit` (versioned) and `core.hooksPath` is what
tells git to look there. The `core.hooksPath` setting is per-clone and must
be re-run on every machine.

## Plugins

Plugins are managed by [TPM](https://github.com/tmux-plugins/tpm). On a fresh
clone, install them with `prefix + I` inside tmux.

## Layout

| File                     | Purpose                                          |
| ------------------------ | ------------------------------------------------ |
| `tmux.conf`              | Orchestrator — sources every other file          |
| `options.conf`           | Core tmux options (mode-keys, mouse, indices)    |
| `status-line.conf`       | Status-left, hooks, status styling               |
| `panes.conf`             | Pane border status + format                      |
| `bindings.conf`          | General key bindings (windows, splits, popups)   |
| `vim.conf`               | Vim-aware C-hjkl pane nav (paired with nvim)     |
| `bindings-sessions.conf` | Session create/rename/move + by-index switching  |
| `bindings-azerty.conf`   | AZERTY layout overrides                          |
| `autosave.conf`          | tmux-resurrect + tmux-continuum settings         |
| `plugins.conf`           | TPM plugin list                                  |
| `local.conf` (optional)  | Per-machine overrides, sourced with `-q`         |
