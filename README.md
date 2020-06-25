# My dotfiles

Here are my dotfiles. 

| Category       | Software              |
| -------------- | --------------------- |
| Window Manager | Sway                  |
| Editor         | Neovim, VsCode, Emacs |
| Terminal       | Alacritty             |

## Getting started

Just clone this repo (with `git clone`), install GNU `stow` and link the specific "modules" that you'll need.

For example, if you'd like to copy my Neovim configuration:

```bash
stow -t ~ neovim
```

For more information on usage, have a look at the `install`, `link`, and `backup` scripts in this directory.