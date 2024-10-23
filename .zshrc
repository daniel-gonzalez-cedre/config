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

# prompt parameters
# PROMPTTYPE="complex"  # "simple", "complex"
PROMPTTYPE=1  # 0, 1
NEWLINE=0  # 0, 1
PIPES=1  # 0, 1

if [[ ${NEWLINE} -eq 0 ]]; then
  NEWLINE_CHAR=''
else
  NEWLINE_CHAR="%{"$'\n'"%}"
fi

if [[ ${PIPES} -eq 0 ]]; then
  UL=''
  BL=''
  UR=''
  BR=''
else
  UL="${fg_dark}╭╴${color_clear} "
  BL="${fg_dark}╰╴${color_clear} "
  UR=" ${fg_dark}╶╮${color_clear}"
  BR=" ${fg_dark}╶╯${color_clear}"
  # UL="${fg_shade}┌╴${color_clear} "
  # BL="${fg_shade}└──╴${color_clear} "
  # UL="${fg_shade}╭╴${color_clear} "
  # BL="${fg_shade}╰╴${color_clear} "
  # UR=" ${fg_shade}╶╮${color_clear}"
  # BR=" ${fg_shade}╶╯${color_clear}"
  # UL="${fg_dark}┏╸${color_clear} "
  # BL="${fg_dark}┗━━┫${color_clear} "
  # UR=" ${fg_dark}╺┓${color_clear}"
  # BR=" ${fg_dark}╺┛${color_clear}"
fi

# prompt setup
if [[ ${PROMPTTYPE} -eq 0 ]]; then
  # PROMPT="${topline}${botline}"
  # RPROMPT="${timestamp} ${BR}"
  (){ # local scope
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

    local left="${path}"
    # left+=" ${git}"

    local right="${git} ${user} ${machine}"
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

    local botline=" ${linefeed} "

    PROMPT="${NEWLINE_CHAR}%${toplinelimit}>> ${left} ${linefeed} "
    RPROMPT="${right}"
  }
else
  (){ # local scope
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
    local left="${UL}${path}"
    # left+=" ${git}"

    local right="${git} ${user} ${machine}${UR}"
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
    local topline=" %${toplinelimit}>>${left}${spacing}${right} %>>%{"$'\n'"%}"

    local botline=" ${BL}${linefeed} "

    PROMPT="${NEWLINE_CHAR}${topline}${botline}"
    RPROMPT="${timestamp}${BR}"
  }
fi


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

# if [ "$TMUX" = "" ]; then
  # # tmux new -A -s 新;
  # tmux;
# fi
if [ "$TERM_PROGRAM" != "Apple_Terminal" ] && [ "$TERM_PROGRAM" != "WezTerm" ] && [ "$TERM_PROGRAM" != "iTerm.app" ]; then
  export TERM=alacritty
else
  export TERM=xterm-256color
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export PATH=~/.local/bin:$PATH
# export PATH="$PYENV_ROOT/bin:$PATH"

export HOMEBREW_AUTO_UPDATE_SECS="86400"
export VIRTUAL_ENV_DISABLE_PROMPT=1
# export PYENV_ROOT="$HOME/.pyenv"

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
  # PATTERN='.*.........default-release'
  PATTERN='.*.default-default'
  [[ $FILE =~ $PATTERN ]] && export LWPROFILE=$FILE
done

# ALIASES
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias diff='grc diff'
alias rsync='rsync -v --progress'

alias ls='tree -L 1 -N --dirsfirst --noreport'
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
alias istats='watch -n 0 --color istats'
alias storage='watch -n 1 --color df -h'

# $1: <options>
#   pass "-i" as an argument to ask on every rm
(){
  function cleantex() {
    # local LATEXDIR="/tmp/latexmk/"
    local LATEXDIR="./"
    mkdir -p $LATEXDIR
    NAME="${1%.*}"
    find $LATEXDIR -depth 1 -name "_minted*${NAME}*" -exec rm -r '{}' \; 2>/dev/null
    find $LATEXDIR -depth 1 -name "${NAME}*aux" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*bbl" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*bcf" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*blg" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*brf" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*fdb_latexmk" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*fls" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*idx" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*ilg" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*ind" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*listings" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*lof" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*log" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*lol" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*lot" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*nav" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*out" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*pyg" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*run.xml" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*snm" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*toc" -exec rm -v '{}' \;
    find $LATEXDIR -depth 1 -name "${NAME}*xdv" -exec rm -v '{}' \;
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
