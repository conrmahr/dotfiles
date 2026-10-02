# Dotfiles

## How to install
```
git clone https://github.com/conrmahr/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.bash
```

## After installing

- Set your terminal font to **MesloLGS NF** (Warp: Settings > Appearance > Text) so the prompt icons render.
- Zinit and its plugins install themselves the first time you open a new shell.
- Put machine-specific aliases, functions, and exports in `zsh/custom/*.zsh`. Those files are sourced automatically and ignored by git; see `zsh/custom/example.zsh`.
- To change the prompt style, run `p10k configure`. It rewrites `p10k.zsh` in this repo.
