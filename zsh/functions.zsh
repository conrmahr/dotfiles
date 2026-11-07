# Find files by name (case-insensitive, partial match): ff <name> [dir]
ff() {
  if [[ -z "$1" ]]; then
    echo "usage: ff <name> [dir]"
    return 1
  fi
  find "${2:-.}" \( -name .git -o -name node_modules \) -prune -o -iname "*$1*" -print 2>/dev/null
}

# Find a string inside files (case-insensitive, recursive): fs <text> [dir]
fs() {
  if [[ -z "$1" ]]; then
    echo "usage: fs <text> [dir]"
    return 1
  fi
  grep -rniI --color=auto --exclude-dir={.git,node_modules} -- "$1" "${2:-.}"
}

# Search aliases by name or command (case-insensitive): fa <text>
fa() {
  if [[ -z "$1" ]]; then
    echo "usage: fa <text>"
    return 1
  fi
  alias | grep --color=auto -i -- "$1"
}

hs() {
  history 1 | grep --color=auto -i -- "$1"
}

brews() {
  local formulae="$(brew leaves | xargs brew deps --installed --for-each)"
  local casks="$(brew list --cask 2>/dev/null)"

  local blue="$(tput setaf 4)"
  local bold="$(tput bold)"
  local off="$(tput sgr0)"

  echo "${blue}==>${off} ${bold}Formulae${off}"
  echo "${formulae}" | sed "s/^\(.*\):\(.*\)$/\1${blue}\2${off}/"
  echo "\n${blue}==>${off} ${bold}Casks${off}\n${casks}"
}

