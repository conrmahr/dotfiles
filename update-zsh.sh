#! /bin/bash

OMZDIR=~/.dotfiles/ohmyzsh

if [ -d "$OMZDIR" ] ; then
  echo 'Updating ohmyzsh to latest version'
  cd ~/.dotfiles/oh-my-zsh
  git pull origin master
  cd -
fi

echo 'Complete Update!'
