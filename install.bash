#!/bin/bash

# Function to determine package manager
function determine_package_manager() {
  which brew > /dev/null && {
    echo "homebrew"
    export OSPACKMAN="homebrew"
    return;
  }
}

function setup_zsh() {
  echo 'Adding ohmyzsh to dotfiles...'
  OMZDIR=~/.dotfiles/oh-my-zsh

  if [ -d "$OMZDIR" ] ; then
    echo 'Updating ohmyzsh to latest version'
    cd ~/.dotfiles/oh-my-zsh
    git pull origin master
    cd -
  else
    echo 'Adding ohmyzsh to dotfiles...'
    git clone https://github.com/ohmyzsh/ohmyzsh.git oh-my-zsh
  fi
}

function determine_shell() {
  echo 'Please pick your favorite shell:'
  echo '(1) Bash'
  echo '(2) Zsh'
  read -p 'Enter a number: ' SHELL_CHOICE
  if [[ $SHELL_CHOICE == '1' ]] ; then
    export LOGIN_SHELL="bash"
  elif [[ $SHELL_CHOICE == '2' ]] ; then
    export LOGIN_SHELL="zsh"
  else
    echo 'Could not determine choice.'
    exit 1
  fi
}

function setup_vim() {
  echo "Setting up vim... ignore any vim errors post install"
  vim +BundleInstall +qall
}

# Check git config is setup
function setup_git() {
    if [[ ! $(git config --get user.name) ]] || [[ ! $(git config --get user.email) ]]; then
      echo 'Setting up git config...'
      read -p 'Enter Github username: ' GIT_USER
      git config --global user.name "$GIT_USER"
      read -p 'Enter email: ' GIT_EMAIL
      git config --global user.email $GIT_EMAIL
      git config --global core.editor vim
      git config --global color.ui true
      git config --global color.diff auto
      git config --global color.status auto
      git config --global color.branch auto
      git config --global init.defaultBranch main
    else
      echo "Git config already set up."
    fi
}

# Adds a symbolic link to files in ~/.dotfiles to your home directory.
function symlink_files() {
  ignoredfiles=(README.md install.bash update-zsh.sh)

  for f in $(ls -d *); do
    if [[ ${ignoredfiles[@]} =~ $f ]]; then
      echo "Skipping $f ..."
    elif [[ $f =~ 'zshrc' || $f =~ 'oh-my-zsh' ]]; then
      if [[ $LOGIN_SHELL == 'zsh' ]] ; then
        link_file $f
      fi
    elif [[ $f =~ 'oh-my-zsh' ]]; then
      if [[ $LOGIN_SHELL == 'zsh' ]] ; then
        link_file $f
      fi
    else
        link_file $f
    fi
  done
}

# symlink a file
# arguments: filename
function link_file(){
  echo "linking ~/.$1"
  if ! $(ln -s "$PWD/$1" "$HOME/.$1");  then
    echo "Replace file '~/.$1'?"
    read -p "[Y/n]?: " Q_REPLACE_FILE
    if [[ $Q_REPLACE_FILE == 'Y' ]]; then
      replace_file $1
    fi
  fi
}

# replace file
# arguments: filename
function replace_file() {
  echo "replacing ~/.$1"
  ln -sf "$PWD/$1" "$HOME/.$1"
}

set -e
(
  determine_package_manager
  # general package array
  declare -a packages=('vim' 'git' 'gh' 'tree' 'htop' 'wget' 'curl' 'rsync' 'speedtest' 'openssl@3' 'ssh-copy-id' 'node@22' 'pnpm')
  declare -a casks=('1password' 'firefox' 'google-chrome' 'obsidian' 'slack' 'visual-studio-code' 'warp')

  determine_shell
  if [[ $LOGIN_SHELL == 'zsh' ]] ; then
    packages=(${packages[@]} 'zsh')
  fi

  if [[ $OSPACKMAN == "homebrew" ]]; then
    echo "You are running homebrew."
    echo "Using Homebrew to install packages..."
    brew update
    for i in "${packages[@]}"
    do
      echo "Checking if $i is installed..."
      brew list --versions "$i" >/dev/null || brew install "$i"
    done
    echo "Installing casks"
    for i in "${casks[@]}"
    do
      echo "Checking if $i is installed..."
      brew list --versions --cask "$i" >/dev/null || brew install --cask "$i"
    done
    brew cleanup
  else
    echo "Could not determine OS. Exiting..."
    exit 1
  fi

  if [[ $LOGIN_SHELL == 'zsh' ]] ; then
    setup_zsh
  fi

  setup_git
  symlink_files
  setup_vim

  if [[ $LOGIN_SHELL == 'zsh' ]] ; then
    echo "Changing shells to ZSH"
    chsh -s /bin/zsh

    echo "Operating System setup complete."
    echo "Reloading session"
    exec zsh
  fi
)