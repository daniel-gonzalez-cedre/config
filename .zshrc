# clear the screen
printf '\33c\e[3J'
# fpath+=~/.zfunc

autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit
# # source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# # source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

setopt histignoredups
setopt promptsubst
setopt promptpercent
_comp_options+=(globdots)
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' menu select
# setopt menu_complete
bindkey -e

# FIX $terminfo KEY BINDINGS

# CREATE A zkbd COMPATIBLE HASH; man 5 terminfo
typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# SETUP key ACCORDINGLY
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# FINALLY, MAKE SURE THE TERMINAL IS IN APPLICATION MODE, WHEN zle IS ACTIVE.
# ONLY THEN ARE THE VALUES FROM $terminfo VALID.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx }
  function zle_application_mode_stop { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

typeset -A fgcode
fgcode=(
  black      "%F{0}"
  red        "%F{1}"
  green      "%F{2}"
  yellow     "%F{3}"
  blue       "%F{4}"
  purple     "%F{5}"
  aqua       "%F{6}"
  white      "%F{7}"
  coblack    "%F{8}"
  cored      "%F{9}"
  cogreen    "%F{10}"
  coyellow   "%F{11}"
  coblue     "%F{12}"
  copurple   "%F{13}"
  coaqua     "%F{14}"
  cowhite    "%F{15}"
  grey       "%F{239}"
  dark       "%F{238}"
  darker     "%F{236}"
  darkest    "%F{235}"
  background "%F{234}"
  foreground "%F{15}"
  clear      "%f"
)
typeset -A bgcode
bgcode=(
  black      "%K{0}"
  red        "%K{1}"
  green      "%K{2}"
  yellow     "%K{3}"
  blue       "%K{4}"
  purple     "%K{5}"
  aqua       "%K{6}"
  white      "%K{7}"
  coblack    "%K{8}"
  cored      "%K{9}"
  cogreen    "%K{10}"
  coyellow   "%K{11}"
  coblue     "%K{12}"
  copurple   "%K{13}"
  coaqua     "%K{14}"
  cowhite    "%K{15}"
  grey       "%K{239}"
  dark       "%K{238}"
  darker     "%K{236}"
  darkest    "%K{235}"
  background "%K{234}"
  foreground "%K{15}"
  clear      "%k"
)
typeset -A clearcode
clearcode=(
  color "%{$(tput sgr0)"
  style "${reset}"
  all   "%f%k%b%u%s"
)

function strlen() {
  foo=$1
  local invisible='%([BSUbfksu]|([FB]|){*})' # (1)
  bar=${#${(S%%)foo//$~invisible/}}
  echo $bar
}

function max() { echo $(( $1 > $2 ? $1 : $2 )) }
function min() { echo $(( $1 < $2 ? $1 : $2 )) }

function path_info() {
  if [[ $PWD:h == "/" || $PWD == $HOME ]]; then
    echo ""
  else
    print -P '${${PWD:h}/$HOME/~} '
  fi
}

function prompt_path() {
  if [[ $PWD:h == "/" || $PWD == $HOME ]]; then
    echo "${fgcode[blue]}${bgcode[clear]}"
  else
    print -P "${fgcode[blue]}${bgcode[clear]}${fgcode[background]}${bgcode[blue]}"'${${PWD:h}/$HOME/~}'"${fgcode[blue]}${bgcode[blue]}"
  fi
}
function prompt_git() {
  local BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [[ -z "$BRANCH" ]]; then
    echo ""
  else
    echo "主"
  fi
}
function prompt_git_pre() {
  local BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [[ -z "$BRANCH" ]]; then
    echo ""
  else
    echo "${fgcode[$1]}${bgcode[$2]} "
  fi
}
function prompt_git_post() {
  local BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [[ -z "$BRANCH" ]]; then
    if [[ -z $VIRTUAL_ENV ]]; then
      echo "${fgcode[$1]}${bgcode[$4]} "
    else
      echo "${fgcode[$1]}${bgcode[$3]} "
    fi
  else
    if [[ -z $VIRTUAL_ENV ]]; then
      echo "${fgcode[$2]}${bgcode[$4]} "
    else
      echo "${fgcode[$2]}${bgcode[$3]} "
    fi
  fi
}
function prompt_venv() {
  if [[ -z "$VIRTUAL_ENV" ]]; then
    echo ""
  else
    # echo " "
    # echo "$VIRTUAL_ENV:t"
    # echo "蟒"
    echo "蛇"
  fi
}
function prompt_venv_post() {
  if [[ -z "$VIRTUAL_ENV" ]]; then
    echo ""
  else
    echo "${fgcode[$1]}${bgcode[$2]} "
  fi
}

# PROMPT SETUP
#     █▓▒░ ░▒▓█    
(){
  USERCOLOR="red"
  PATHCOLOR="blue"
  GITCOLOR="aqua"
  VENVCOLOR="green"
  MACHINECOLOR="grey"
  TIMECOLOR="clear"
  LAMBDACOLOR="purple"

  local USER="%n"
  local MACHINE="%m"
  local VENV='$(prompt_venv)'

  # local GIT='$(git symbolic-ref --short HEAD 2> /dev/null)'
  local GIT='$(prompt_git)'

  local TIME="%D{%K:%M}"

  # local PATH_PREFIX='$(prompt_path)'
  # local PATH_SUFFIX='%B%1~%b'
  # local PATH_SUFFIX='%1~'
  local width='$(($COLUMNS/5))'
  local PATHSTR="%${width}<...<%1~%<<"

  TOPLINE="${fgcode[$USERCOLOR]}${bgcode[clear]}"
  TOPLINE+="${fgcode[background]}${bgcode[$USERCOLOR]}${USER}"
  TOPLINE+="${fgcode[$USERCOLOR]}${bgcode[$PATHCOLOR]} "
  # TOPLINE+="${fgcode[$PATHCOLOR]}${bgcode[$USERCOLOR]} "
  TOPLINE+="${fgcode[background]}${bgcode[$PATHCOLOR]}${PATHSTR}"
  # TOPLINE+="${fgcode[background]}${bgcode[blue]}${PATH_SUFFIX}"
  TOPLINE+='$(prompt_git_pre $PATHCOLOR $GITCOLOR $LAMBDACOLOR)'
  TOPLINE+="${fgcode[background]}${bgcode[$GITCOLOR]}${GIT}"
  TOPLINE+='$(prompt_git_post $PATHCOLOR $GITCOLOR $VENVCOLOR $LAMBDACOLOR)'
  TOPLINE+="${fgcode[background]}${bgcode[$VENVCOLOR]}${VENV}"
  # TOPLINE+='$(prompt_venv_post $VENVCOLOR $TIMECOLOR)'
  TOPLINE+='$(prompt_venv_post $VENVCOLOR $LAMBDACOLOR)'
  # TOPLINE+="${fgcode[background]}${bgcode[$MACHINECOLOR]}${MACHINE}"
  # TOPLINE+="${fgcode[$MACHINECOLOR]}${bgcode[$TIMECOLOR]} "
  # TOPLINE+="${fgcode[background]}${bgcode[$TIMECOLOR]}${TIME}"
  # TOPLINE+="${fgcode[$TIMECOLOR]}${bgcode[clear]}"
  TOPLINE+="${fgcode[clear]}${bgcode[clear]}"

  BOTLINE="${fgcode[$LAMBDACOLOR]}${bgcode[background]}${fgcode[background]}${bgcode[$LAMBDACOLOR]}%Bλ%b${fgcode[$LAMBDACOLOR]}${bgcode[background]}${fgcode[clear]}${bgcode[clear]} "
  ENDLINE="${fgcode[background]}${bgcode[$LAMBDACOLOR]}%Bλ%b${fgcode[$LAMBDACOLOR]}${bgcode[background]}${fgcode[clear]}${bgcode[clear]} "

  # precmd() { print -P "${TOPLINE}" }
  # PROMPT="${BOTLINE}"
  PROMPT="${TOPLINE}${ENDLINE}"
}

command mkdir -p "$HOME/.config"
command mkdir -p "$HOME/.cache"
command mkdir -p "$HOME/.local/share"
command mkdir -p "$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export EDITOR='vim'
# export VISUAL='vim'

export CLICOLOR=1
# export GREP_COLORS='sl=49;39:cx=49;39:mt=49;31;1:fn=49;32:ln=49;33:bn=49;33:se=1;36'
export GREP_OPTIONS="--color=auto"  # --line-buffered

export CONFIG=${HOME}/config

if [ "$TERM_PROGRAM" != "Apple_Terminal" ] && [ "$TERM_PROGRAM" != "WezTerm" ] && [ "$TERM_PROGRAM" != "iTerm.app" ]; then
  # export TERM=alacritty
  export TERM=xterm-256color
else
  export TERM=xterm-256color
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=$PATH:~/.scripts:~/.cargo/bin
# export PATH="$PYENV_ROOT/bin:$PATH"

export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_AUTO_UPDATE_SECS="86400"
export VIRTUAL_ENV_DISABLE_PROMPT=1
# export PYENV_ROOT="$HOME/.pyenv"

# ALIASES
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias diff='grc diff'
alias rsync='rsync -v --progress'
alias view='chafa'
# alias viu='viu'

alias pbcopy="tr -d '\n' | pbcopy"

function open_window() {
  osascript -e "tell application \"$1\" to activate" -e 'tell application "System Events" to keystroke "n" using command down';
}

function ls() {
  args=("$@")
  excl=()
  opts=()
  for arg in $args; do
    case $arg in
      -([a-zA-Z0-9]*[a-zA-Z0-9]) )
        for char in ${(s::)arg}; do
          if [[ $char != "-" ]]; then
            args+=(-${char})
          fi
        done
        excl+=($arg)
        ;;
      * ) ;;
    esac
  done
  for arg in ${args:|excl}; do
    case $arg in
      -1 | -l ) opts+=('-1' '--show-symlinks') ;;
      -a ) opts+=('-a') ;;
      -L ) opts+=('-l') ;;
      -i ) opts+=('--icons') ;;
      -q ) opts+=('--no-quotes') ;;
      -t ) opts+=('--tree') ;;
      -f ) opts+=('-f' '--show-symlinks') ;;
      -d | -D ) opts+=('-D' '--show-symlinks') ;;
      --list ) opts+=('-1' '--show-symlinks') ;;
      --long ) opts+=('-l') ;;
      * ) opts+=($arg) ;;
    esac
  done
  command eza $opts[@]
}

# alias ls='eza --icons --no-quotes'
# alias ls='tree -L 1 -N --dirsfirst --noreport'
# alias ls='tree -C -L 1 -N --dirsfirst --noreport | tail -n +2'
# alias gls='gls --color --group-directories-first -h'
alias tree='tree -N --dirsfirst --noreport'
# function tree_ascii() {
  # tree --dirsfirst -C -N -h "$1" | sed 's/├/\+/g; s/─/-/g; s/└/\\/g'
# }

# alias g++="g++ -std=c++11"
alias ghc='ghc -no-keep-hi-files -no-keep-o-files'
alias haskell='runhaskell'
alias lisp='sbcl'
alias lisps='sbcl --script'
alias python='python3'

alias pdfcrop='/Library/TeX/texbin/pdfcrop'
alias mpv='open -a /Applications/mpv.app/'
# alias istats='watch -n 0 --color istats'
alias storage='watch -n 1 --color df -h'
alias hhkb='open -a hhkb-keymap-tool'

# $1: <options>
#   pass "-i" as an argument to ask on every rm
(){
  function cleantex() {
    # local LATEXDIR="/tmp/latexmk/"
    # mkdir -p $LATEXDIR
    if [ -z "$2" ]; then
      local NAME="${1%.*}"
      local LATEXDIR="./"
    else
      local NAME="${1%.*}"
      local LATEXDIR="{$2}"
    fi

    find $LATEXDIR -depth 1 -name "_minted*${NAME}*" -exec rm -r '{}' \; 2>/dev/null
    find $LATEXDIR -depth 1 -name "${NAME}*.aux" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.bbl" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.bcf" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.bcf-SAVE-ERROR*" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.blg" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.brf" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.fdb_latexmk" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.fls" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.idx" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.ilg" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.ind" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.listings" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.listing" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.lof" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.log" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.lol" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.lot" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.nav" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.out" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.pyg" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.run.xml" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.snm" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.toc" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.xdv" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*.xdv" -exec rm -v '{}' \;
  }
  function cleanlatex() { cleantex "$@" }

  function cleanvim() {
    mkdir -p /tmp/vim/
    find . -depth 1 -name ".*.swo" -exec mv '{}' /tmp/vim/'{}' \;
    find . -depth 1 -name ".*.swp" -exec mv '{}' /tmp/vim/'{}' \;
  }

  function clean() {
    mkdir -p /tmp/Finder/
    mkdir -p /tmp/python/
    mkdir -p /tmp/latexmk/
    mkdir -p /tmp/vim/

    find . -depth 1 -name ".DS_Store" -exec mv '{}' /tmp/Finder/'{}' \;
    find . -depth 1 -name "__pycache__/" -exec mv '{}' /tmp/python/'{}' \;
  }
}

(){
  alias latexmk='latexmk -pvc -pdf'
  function latex() {
    local engine_option="--pdf"
    local shell_escape=""
    local file
    local verbose="no"

    # parse arguments
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --pdf)
          engine_option="-pdf"
          shift
          ;;
        --lua)
          engine_option="-pdflua"
          shift
          ;;
        --xe)
          engine_option="-pdfxe"
          shift
          ;;
        --shell)
          shell_escape="--shell-escape"
          shift
          ;;
        -v)
          verbose="yes"
          shift
          ;;
        *)
          if [[ -z "$file" ]]; then
            file="$1"
          else
            echo "Unknown argument: $1"
            echo "Usage: myfunc [<engine_option>] [--shell] [-v] <file>"
            echo "Engine options: --pdf, --lua, --xe"
            return 1
          fi
          shift
          ;;
      esac
    done

    # check for file
    if [[ -z "$file" ]]; then
      echo "File argument is required."
      echo "Usage: myfunc [<engine_option>] [--shell] [-v] <file>"
      echo "Engine options: --pdf, --lua, --xe"
      return 1
    fi

    # run latexmk
    if [[ "$verbose" == "yes" ]]; then
      command latexmk -pvc "$engine_option" $shell_escape "$file" 2>&1 | awk '
        /LaTeX Warning: Marginpar on page [0-9]+ moved\./ {
          printf "\033[30m%s\033[0m\n", $0
          next
        }
        tolower($0) ~ /warning/ { printf "\033[33m%s\033[0m\n", $0; next }
        /^.*:[0-9]+:/ { printf "\033[31m%s\033[0m\n", $0; next }
        { printf "\033[37m%s\033[0m\n", $0; next }
      '
    else
      command latexmk -pvc "$engine_option" $shell_escape "$file" 2>&1 | awk '
        /LaTeX Warning: Marginpar on page [0-9]+ moved\./ {
          printf "\033[30m%s\033[0m\n", $0
          next
        }
        tolower($0) ~ /warning/ { printf "\033[33m%s\033[0m\n", $0; next }
        /^.*:[0-9]+:/ { printf "\033[31m%s\033[0m\n", $0; next }
        /Output written on/ { printf "\033[32m%s\033[0m\n", $0; next }
      '
    fi
    # /^=== / { printf "\033[32m%s\033[0m\n", $0; next }
  }
  function lualatex() { latex --lua "$@" }
  function luatex() { latex --lua "$@" }
  function xelatex() { latex --xe "$@" }
  function xetex() { latex --xe "$@" }
}

(){
  _tex_complete() {
    local -a files
    files=(*.tex)
    _files -g '*.tex'
  }

  _add_latex_completion() {
  local -a cmds
  cmds=(lualatex luatex xelatex xetex cleanlatex cleantex) # Add other commands here
    for cmd in $cmds; do
      compdef _tex_complete $cmd
    done
  }

  _add_latex_completion
}

function hex2rgb() {
  hex="${1}"
  printf "%d %d %d\n" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2}
}

function rgb2hex() {
  red="${1}"
  green="${2}"
  blue="${3}"
  printf "#%x%x%x\n" "${red}" "${green}" "${blue}"
}

function ris2bib() {
  ris2xml "$1" | xml2bib > "${1/%.ris/.bib}"
}

# $1 : <port_number>
# $2 : <username>@<remote_server>
function ssh_tunnel() {
  ssh -N -L "$1":localhost:"$1" "$2"
}

# $1 : <port_number>
function ssh_jupyter() {
  jupyter notebook --no-browser --port="$1"
}

# $1 : <input_file>
# $2 : <output_file>
function compress_pdf() {
  gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/${3:-"screen"} -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
}

function qmk_flash_atreus() {
  avrdude -p atmega32u4 -c avr109 -U flash:w:"$@" -P /dev/cu.usbmodematreus1
}

function size() {
  du -h -d 0 "$@"
}

function temperature() {
  watch 'sudo powermetrics --samplers smc -i1 -n1 | tail'
}

# computer vision
function gcv() {
  g++ -std=c++11 $1 $(pkg-config --cflags --libs opencv4);
}

# $1 : <input_file>
# $2 : <output_file>
function decrypt() {
  openssl enc -d -aes-256-cbc -in "$1" > "$2"
}

# $1 : <input_file>
# $2 : <output_file>
function encrypt() {
  openssl enc -aes-256-cbc -salt -in "$1" -out "$2"
}

# $1 : <input>.cue
# $2 : <input>.flac
function flacsplit() {
  shnsplit -f "$1" -o flac -t "flac %n. %p - %a - %t" "$2"
}

# $1 : <input_file>
function flacconvert() {
  filename=$1
  ffmpeg -i "$1" -codec:a libmp3lame -b:a 320k "${filename//flac/mp3}"
}

# converts all flac files in the current directory to mp3
function flacall() {
  for f in ./*.flac
  do
      flacconvert "$f"
  done
}

# removes audio from all files in current directory
function removeaudio() {
  for f in ./*
  do
    filename="$f"
    echo Removing audio from $f ...
    ffmpeg -i $filename -c copy -an "${filename:2:8}-noaudio.mov"
    echo done.
  done
}

# $1 : <input_file>
function preview() {
  qlmanage -p "$1"
}

# to convert all .HEIC images in a directory to .png
# mogrify -monitor -format png *.HEIC
function reformat() {
  if [[ $# -eq 2 ]]; then
    mogrify -monitor -format "$2" *."$1"
  else
    echo Input and output filetypes are required.
  fi
}

# $1 : ???
function resize() {
  for f in ./*.png
  do
      echo Resizing $f...
      convert "$f" -resize "$1" "$f"
      echo done.
  done
}

# packages
case `uname` in
  Darwin) # commands for OS X go here
    if ! command -v brew &> /dev/null; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    if ! command -v tmux &> /dev/null; then
      brew install tmux
    fi
    if ! command -v grc &> /dev/null; then
      brew install grc
    fi
    if ! command -v tree &> /dev/null; then
      brew install tree
    fi
    # if ! command -v pyenv &> /dev/null; then
      # brew install pyenv
    # fi
    # if ! command -v poetry &> /dev/null; then
      # #brew install poetry
      # curl -sSL https://install.python-poetry.org | python3 -
    # fi
  ;;
  Linux) # commands for Linux go here
    # if ! command -v pyenv &> /dev/null; then
        # curl https://pyenv.run | bash
    # fi
    # if ! command -v poetry &> /dev/null; then
        # curl -sSL https://install.python-poetry.org | python3 -
    # fi
  ;;
  FreeBSD) # commands for FreeBSD go here
  ;;
esac

# if command -v pyenv > /dev/null; then
  # #export PYENV_ROOT="$HOME/.pyenv"
  # #export PATH="$PYENV_ROOT/bin:$PATH"
  # eval "$(pyenv init -)"
# fi

# if command -v poetry > /dev/null; then
  # export POETRY_CONFIG_DIR="$HOME/.config/pypoetry"
# fi


# launch tmux at login
# if [ "$TMUX" = "" ]; then
  # # tmux new -A -s 新;
  # tmux;
# fi
