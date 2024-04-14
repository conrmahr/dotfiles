#! /bin/bash

OMZDIR=~/.dotfiles/oh-my-zsh

if [ -d "$OMZDIR" ] ; then
  echo 'Updating ohmyzsh to latest version'
  cd ~/.dotfiles/oh-my-zsh
  git pull origin master
  cd -
fi

echo 'Complete Update!'
