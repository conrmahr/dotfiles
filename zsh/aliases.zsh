# Navigation
alias ..='cd ..; ls'
alias ...='cd ..; cd ..; ls'
alias ~='cd ~'
alias sites='cd ~/Sites'
alias desktop='cd ~/Desktop'
alias downloads='cd ~/Downloads'
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Listing
alias ll='ls -lah'
alias la='ls -la'
alias path='echo $PATH | tr ":" "\n"'
alias cpath='pwd | tr -d "\n" | pbcopy'
alias cpwd='pwd | tr -d "\n" | pbcopy'

# .dotfiles
alias zc='cd ~/.dotfiles/zsh'
alias zs='source ~/.zshrc'
alias zv='exec zsh'

# Miscellaneous
alias history='history 1'
alias plz='eval sudo $(fc -ln -1)'
alias ports='lsof -iTCP -sTCP:LISTEN -n -P'