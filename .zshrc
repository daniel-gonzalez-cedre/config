# clear the screen
printf '\33c\e[3J'
# fpath+=~/.zfunc

autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit
# # source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# # source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

setopt promptsubst
setopt promptpercent
_comp_options+=(globdots)
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' menu select
# setopt menu_complete
bindkey -e

# precmd_conda_info() {
  # if [[ -n $CONDA_PREFIX ]]; then
    # if [[ $(basename $CONDA_PREFIX) == "miniconda3" ]]; then
      # # Without this, it would display conda version
      # CONDA_ENV="(base) "
    # else
      # # For all environments that aren't (base)
      # CONDA_ENV="($(basename $CONDA_PREFIX)) "
    # fi
  # # When no conda environment is active, don't show anything
  # else
    # CONDA_ENV=""
  # fi
# }
# # precmd_functions+=( precmd_conda_info )

function git_info() {
  # local BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null) || return
  # if [[ -n $BRANCH ]]; then
    # print -P "%{${fg_coaqua}%}$BRANCH %{${fg_dark}%}:: %{${color_clear}%}"
  # else
    # print -P ""
    # # echo "%F{14}$BRANCH%F{237}::%f"
  # fi
  # local STATUS=''
  # local FLAGS
  # FLAGS=('--porcelain')
  # if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
  #   if [[ $POST_1_7_2_GIT -gt 0 ]]; then
  #   FLAGS+='--ignore-submodules=dirty'
  #   fi
  #   if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
  #   FLAGS+='--untracked-files=no'
  #   fi
  #   STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  # fi
  # if [[ -n $STATUS ]]; then
  #   GIT_PROMPT_COLOR="%F{7}"
  #   GIT_STAR=""
  # else
  #   GIT_PROMPT_COLOR="%F{6}"
  #   unset GIT_STAR
  # fi
  # echo "$BRANCH$GIT_STAR"
}

function path_info() {
  # if [ ${#${PWD:h}} -eq ${#${str}} ]; then
  # if [[ $PWD:h == $str_root ]]; then
  if [[ $PWD:h == "/" ]]; then
    echo ""
  else
    if [[ $PWD == $HOME ]]; then
      echo ""
    else
      print -P '${${PWD:h}/$HOME/~} '
    fi
  fi
}

fg_black="%F{0}"
fg_red="%F{1}"
fg_green="%F{2}"
fg_yellow="%F{3}"
fg_blue="%F{4}"
fg_purple="%F{5}"
fg_aqua="%F{6}"
fg_white="%F{7}"

fg_coblack="%F{8}"
fg_cored="%F{9}"
fg_cogreen="%F{10}"
fg_coyellow="%F{11}"
fg_coblue="%F{12}"
fg_copurple="%F{13}"
fg_coaqua="%F{14}"
fg_cowhite="%F{15}"

fg_bg="%F{0}"
fg_fg="%F{15}"
fg_text="%F{15}"

fg_silver="%F{7}"
fg_grey="%F{8}"
fg_shade="%F{239}"
fg_dark="%F{238}"
fg_darker="%F{236}"
fg_darkest="%F{235}"

fg_clear="%f"
bg_clear="%k"
color_clear="%f%k"
markup_clear="%b%u%s"

function strlen() {
  foo=$1
  local invisible='%([BSUbfksu]|([FB]|){*})' # (1)
  bar=${#${(S%%)foo//$~invisible/}}
  echo $bar
}

function max() {
  echo $(( $1 > $2 ? $1 : $2 ))
}

function min() {
  echo $(( $1 < $2 ? $1 : $2 ))
}

(){ # local scope
  local UL="${fg_darker}┏╸${color_clear}"
  local BL="${fg_darker}┗━━╸${color_clear}"
  local UR="${fg_darker}╺┓${color_clear}"
  local BR="${fg_darker}╺┛${color_clear}"
  # local UL="${fg_shade}┌╴${color_clear}"
  # local BL="${fg_shade}└──╴${color_clear}"
  # local UL="${fg_shade}╭╴${color_clear}"
  # local BL="${fg_shade}╰╴${color_clear}"
  # local UR="${fg_shade}╶╮${color_clear}"
  # local BR="${fg_shade}╶╯${color_clear}"
  # local UL="${fg_dark}┏╸${color_clear}"
  # local BL="${fg_dark}┗━━┫${color_clear}"
  # local UR="${fg_dark}╺┓${color_clear}"
  # local BR="${fg_dark}╺┛${color_clear}"

  # fourth
  local function userlimiter() { echo $(( $COLUMNS - $(strlen ${HOST}) - $(strlen " ┏╸ ⋅⋅⋅ ⋅⋅⋅⋅⋅⋅ ╺┓ ⋅⋅⋅ ") )) }
  local userlimit='$(max $(userlimiter) 1)'
  local user="${fg_coyellow}%${userlimit}<⋅⋅⋅<%n%<<${color_clear}"

  # fifth
  local function machinelimiter() { echo $(( $COLUMNS - $(strlen " ┏╸ ⋅⋅⋅⋅⋅⋅ ⋅⋅⋅⋅⋅⋅ ╺┓ ⋅⋅⋅ ") )) }
  local machinelimit='$(max $(machinelimiter) 1)'
  local machine="${fg_cored}%${machinelimit}<⋅⋅⋅<%m%<<${color_clear}"

  local linefeed="${fg_coyellow}λ${color_clear}"
  local timestamp="${fg_dark}%D{%K:%M:%S}${color_clear}"

  # third
  local function gitlimiter() { echo $(( $COLUMNS - $(strlen ${USER}) - $(strlen ${HOST}) - $(strlen " ┏╸ ⋅⋅⋅ ╺┓ ⋅⋅⋅ ") )) }
  local gitlimit='$(max $(gitlimiter) 1)'
  local gitbranch='$(git symbolic-ref --short HEAD 2> /dev/null)'
  # local gitsuffix=" ::"
  # local git="${fg_coaqua}%${gitlimit}<⋅⋅⋅<${gitbranch}%<<${fg_dark}${gitsuffix}${color_clear}"
  local git="${fg_coaqua}%${gitlimit}<⋅⋅⋅<${gitbranch}%<<${color_clear}"

  # first
  local function prefixlimiter() { echo $(( $COLUMNS - $(strlen ${${PWD:t}/$HOME/~}) - $(strlen ${USER}) - $(strlen ${HOST}) - $(strlen " ┏╸ ⋅⋅⋅ ╺┓ master") )) }
  local prefixlimit='$(max $(prefixlimiter) 1)'
  local pathprefix='$(path_info)'

  # second
  local function suffixlimiter() { echo $(( $COLUMNS - $(strlen ${USER}) - $(strlen ${HOST}) - $(strlen " ┏╸ ⋅⋅⋅⋅⋅⋅ ╺┓ master") )) }
  local suffixlimit='$(max $(suffixlimiter) 1)'
  local pathsuffix='%B%1~%b'

  local path="${fg_shade}%${prefixlimit}<⋅⋅⋅<${pathprefix}%<<${fg_coblue}%${suffixlimit}<⋅⋅⋅<${pathsuffix}%<<${color_clear}"

  # local gitbranch gitsuffix
  # local gitcheck=$(git symbolic-ref --short HEAD 2> /dev/null)
  # if [[ -n $(git symbolic-ref --short HEAD 2> /dev/null) ]]; then
    # gitbranch+='$(git symbolic-ref --short HEAD 2> /dev/null)'
    # gitsuffix+=" ::"
  # fi
  local left="${UL} ${path}"
  # left+=" ${git}"

  local right="${git} ${user} ${machine} ${UR}"
    # Virtualenv.
    # right+='${VIRTUAL_ENV:+venv }'

    # Editing mode. $ZLE_MODE shouldn't contain %, no need to escape
    # ZLE_MODE=insert
    # right+='%K{green} $ZLE_MODE'

  # Combine left and right prompt with spacing in between.
  local pattern='%([BSUbfksu]|([FBK]|){*})'
  local zero='%([BSUbfksu]|([FK]|){*})'

  local leftspace=${(S)left//${~pattern}}
  local rightspace=${(S)right//${~pattern}}
  local spacing="\${(l,COLUMNS-2-\${#\${(%):-${leftspace}${rightspace}}},)}"

  local function toplinelimiter() { echo $(( $COLUMNS - 20 )) }
  local toplinelimit='$(max $(toplinelimiter) 1)'
  local topline="%${toplinelimit}>> ${left}${spacing}${right} %>>%{"$'\n'"%}"

  local botline=" ${BL} ${linefeed} "

  PROMPT="${topline}${botline}"
  RPROMPT="${timestamp} ${BR}"
}

# autoload vcs_info
# precmd() vcs_info

# update-mode() {
  # case $KEYMAP in
    # (main)
      # case $ZLE_STATE in
        # (*insert*) ZLE_MODE=insert;;
        # (*) ZLE_MODE=overwrite
      # esac;;
    # (*) ZLE_MODE=$KEYMAP
  # esac
  # [[ $ZLE_MODE = $oldmode ]] || zle reset-prompt
# }

# overwrite-mode() {
   # zle ".$WIDGET"
   # update-mode
# }
# zle -N overwrite-mode
# zle -N zle-keymap-select update-mode


function schedprompt() {
  emulate -L zsh
  zmodload -i zsh/sched
  integer i=${"${(@)zsh_scheduled_events#*:*:}"[(I)schedprompt]}
  (( i )) && sched -$i
  zle && zle reset-prompt
  sched +30 schedprompt
}
schedprompt


export CLICOLOR=1
export EDITOR='vim'
# export VISUAL='vim'
export GREP_OPTIONS="--color=always"  # --line-buffered

export CONFIG=${HOME}/config
export TERM=xterm-256color

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/Cellar:$PATH
export PATH=/usr/local/Cellar:$PATH
export PATH=~/.local/bin:$PATH
# export PATH="$PYENV_ROOT/bin:$PATH"

# export PYENV_ROOT="$HOME/.pyenv"
export VIRTUAL_ENV_DISABLE_PROMPT=1

export FFDIR=${HOME}/Library/Application\ Support/Firefox
for FILE in ${FFDIR}/Profiles/*
do
    # PATTERN=".*.........default-release"
    PATTERN=".*.default-release"
    [[ $FILE =~ $PATTERN ]] && export FFPROFILE=$FILE
done

export LWDIR=${HOME}/Library/Application\ Support/librewolf
for FILE in ${LWDIR}/Profiles/*
do
    # PATTERN=".*.........default-release"
    PATTERN=".*.default-default"
    [[ $FILE =~ $PATTERN ]] && export LWPROFILE=$FILE
done

alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias diff="grc diff"
alias rsync="rsync -v --progress"

alias ls="tree -L 1 --dirsfirst --noreport"
alias tree="tree -N --dirsfirst --noreport"
# function tree_ascii() {
  # tree --dirsfirst -C -N -h "$1" | sed 's/├/\+/g; s/─/-/g; s/└/\\/g'
# }

alias g++="g++ -std=c++11"
alias ghc="ghc -no-keep-hi-files -no-keep-o-files"
alias haskell="runhaskell"
alias lisp="sbcl"
alias lisps="sbcl --script"
alias matlab="/Applications/MATLAB_R2019a.app/bin/matlab -nodesktop -nosplash"
# alias minicondactivate="source ~/miniconda3/bin/activate"
alias python="python3"

alias pdfcrop="/Library/TeX/texbin/pdfcrop"
alias mpv="open -a /Applications/mpv.app/"
alias istats="watch -n 0 --color istats"
alias storage="watch -n 1 --color df -h"

alias latexmk="latexmk -pdf -pvc"
# function latex() {
  # latexmk -pdf -pvc "$1" | grep -i -A7 '^!.*\|^.*error.*$\|^.*warning.*$'
# }
function latex() {
  latexmk -pdf -pvc "$1" | grep -i -A7 '^!.*\|^.*error.*$'
}
function xelatex() {
  latexmk -pdf -pvc -xelatex "$1" | grep -i -A7 '^!.*\|^.*error.*$\|^.*warning.*$'
}
function lualatex() {
  latexmk -pdf -pvc -lualatex "$1" | grep -i -A7 '^!.*\|^.*error.*$\|^.*warning.*$'
}
function latexsh() {
  latexmk -pdf -pvc -shell-escape "$1" | grep -i -A7 '^!.*\|^.*error.*$\|^.*warning.*$'
}

function minicondactivate() {
# source ~/miniconda3/bin/activate  # commented out by conda initialize
  PROMPT=" %11Fλ%f "
  RPROMPT="%0F%10<(...<$CONDA_PROMPT_MODIFIER%<<$RPROMPT"
  # ask_conda="$(PROMPT="${PROMPT:-}" __conda_exe shell.posix activate)" || \return
  # echo "$ask_conda"

  # ask_conda="$(PS1="${PS1:-}" __conda_exe shell.posix "$@")" || \return
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

# $1: <options>
#   pass "-i" as an argument to ask on every rm
function clean() {
  rm -rf __pycache__/
  rm -f .DS_Store
  rm -f *.aux(N)
  rm -f *.bbl(N)
  rm -f *.bcf(N)
  rm -f *.blg(N)
  rm -f *.brf(N)
  rm -f *.fdb_latexmk(N)
  rm -f *.fls(N)
  rm -f *.idx(N)
  rm -f *.ilg(N)
  rm -f *.ind(N)
  rm -f *.lof(N)
  rm -f *.log(N)
  rm -f *.lol(N)
  rm -f *.lot(N)
  rm -f *.nav(N)
  rm -f *.out(N)
  rm -f *.run.xml(N)
  rm -f *.snm(N)
  rm -f *.toc(N)
  rm -f *.xdv(N)
  # rm -if .*.swp(N)
  # rm -if .*.swo(N)
  rm -f _minted*(N)
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


# ===
# we should stop using conda
function condactivate() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
      . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="$HOME/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
  conda activate
  conda config --set changeps1 false
}

# launch tmux at login
# if [ "$TMUX" = "" ]; then
  # # tmux new -A -s 新;
  # tmux;
# fi
