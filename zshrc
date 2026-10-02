if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES=$HOME/.dotfiles

setopt PROMPT_SUBST

source "$DOTFILES/zsh/exports.zsh"

for f in "$DOTFILES"/zsh/*.zsh; do
  [[ "$f" == "$DOTFILES/zsh/exports.zsh" ]] && continue
  source "$f"
done

if [[ -d "$DOTFILES/zsh/custom" ]]; then
  for f in "$DOTFILES"/zsh/custom/*.zsh; do
    [[ -f "$f" ]] && source "$f"
  done
fi

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
