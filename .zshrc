autoload -Uz add-zsh-hook
setopt prompt_subst
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
# setopt menu_complete
bindkey -e

precmd_conda_info() {
    if [[ -n $CONDA_PREFIX ]]; then
        if [[ $(basename $CONDA_PREFIX) == "miniconda3" ]]; then
            # Without this, it would display conda version
            CONDA_ENV="(base) "
        else
            # For all environments that aren't (base)
            CONDA_ENV="($(basename $CONDA_PREFIX)) "
        fi
    # When no conda environment is active, don't show anything
    else
        CONDA_ENV=""
    fi
}
precmd_functions+=( precmd_conda_info )

function git_info()
{
    local BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null) || return
    if [[ $BRANCH == "" ]];
    then
        :
    else
        echo "%F{3}$BRANCH -> %f"
    fi
    # local STATUS=''
    # local FLAGS
    # FLAGS=('--porcelain')
    # if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    #     if [[ $POST_1_7_2_GIT -gt 0 ]]; then
    #     FLAGS+='--ignore-submodules=dirty'
    #     fi
    #     if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
    #     FLAGS+='--untracked-files=no'
    #     fi
    #     STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
    # fi
    # if [[ -n $STATUS ]]; then
    #     GIT_PROMPT_COLOR="%F{7}"
    #     GIT_STAR=""
    # else
    #     GIT_PROMPT_COLOR="%F{6}"
    #     unset GIT_STAR
    # fi
    # echo "$BRANCH$GIT_STAR"
}

function promptwidth() { echo $(( ${COLUMNS} - 25 - 10)) }
width='$(promptwidth)'
git_branch='$(git_info)'
# PROMPT=' %F{0}%D{%K:%M:%S} %F{11}λ%f '
# PROMPT=' %F{3}λ%f '
PROMPT=''' %F{3}⟩%f '
# RPROMPT='%F{0}${CONDA_ENV}'"%F{0}%D{%K:%M:%S} %${width}<...<%F{9}%2~%F{0} %15<...<%F{3}%m%f"
RPROMPT='%F{0}${CONDA_ENV}'"%F{0}%D{%K:%M:%S} ${git_branch}%${width}<...<%F{9}%1~%F{0}%f"

function schedprompt() {
    emulate -L zsh
    zmodload -i zsh/sched
    integer i=${"${(@)zsh_scheduled_events#*:*:}"[(I)schedprompt]}
    (( i )) && sched -$i
    zle && zle reset-prompt
    sched +30 schedprompt
}
schedprompt


# export EDITOR='vim'
# export VISUAL='vim'
export GREP_OPTIONS="--color=always"  # --line-buffered

export TERM=xterm-256color
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/opt/homebrew/bin:/usr/local/Cellar:$PATH
export FFPROFILE=${HOME}/Library/Application\ Support/Firefox/Profiles/4wxlb3i6.default-release

alias gitfig="/usr/bin/git --git-dir=$HOME/.gitfig/ --work-tree=$HOME"     #   gitfig config --local status.showUntrackedFiles no

alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias rsync="rsync -v --progress"

alias tree="tree -C -N --dirsfirst"
alias ls="tree -L 1"
function tree_ascii() { tree --dirsfirst -C -N -h "$1" | sed 's/├/\+/g; s/─/-/g; s/└/\\/g' }

alias g++="g++ -std=c++11"
alias ghc="ghc -no-keep-hi-files -no-keep-o-files"
alias haskell="runhaskell"
alias matlab="/Applications/MATLAB_R2019a.app/bin/matlab -nodesktop -nosplash"
# alias minicondactivate="source ~/miniconda3/bin/activate"
alias python="python3"
function minicondactivate() {
# source ~/miniconda3/bin/activate  # commented out by conda initialize
    PROMPT=" %11Fλ%f "
    RPROMPT="%0F%10<(...<$CONDA_PROMPT_MODIFIER%<<$RPROMPT"
    # ask_conda="$(PROMPT="${PROMPT:-}" __conda_exe shell.posix activate)" || \return
    # echo "$ask_conda"

    # ask_conda="$(PS1="${PS1:-}" __conda_exe shell.posix "$@")" || \return
}

alias pdfcrop="/Library/TeX/texbin/pdfcrop"
alias mpv="open -a /Applications/mpv.app/"
alias istats="watch -n 0 --color istats"
alias storage="watch -n 1 --color df -h"

alias latexmk="latexmk -pdf -pvc"
function latex() { latexmk -pdf -pvc "$1" | grep -i -A7 '^!.*\|^.*error.*$\|^.*warning.*$' }
function xelatex() { latexmk -pdf -pvc -xelatex "$1" | grep -i -A7 '^!.*\|^.*error.*$\|^.*warning.*$' }
function lualatex() { latexmk -pdf -pvc -lualatex "$1" | grep -i -A7 '^!.*\|^.*error.*$\|^.*warning.*$' }
function latexsh() { latexmk -pdf -pvc -shell-escape "$1" | grep -i -A7 '^!.*\|^.*error.*$\|^.*warning.*$' }

function ris2bib() { ris2xml "$1" | xml2bib > "${1/%.ris/.bib}" }

# $1 : <port_number>
# $2 : <username>@<remote_server>
function ssh_tunnel() { ssh -N -L "$1":localhost:"$1" "$2" }

# $1 : <port_number>
function ssh_jupyter() { jupyter notebook --no-browser --port="$1" }

# $1 : <input_file>
# $2 : <output_file>
function compress_pdf() {
    gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/${3:-"screen"} -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
}

function qmk_flash_atreus() { avrdude -p atmega32u4 -c avr109 -U flash:w:"$@" -P /dev/cu.usbmodematreus1 }

function size() { du -h -d 0 "$@" }

function temperature() { watch 'sudo powermetrics --samplers smc -i1 -n1 | tail' }

# $1: <options>
#   pass "-i" as an argument to ask on every rm
function clean() {
    rm -rf __pycache__/
    rm -f .DS_Store
    rm -f *.aux(N)
    rm -f *.bcf(N)
    rm -f *.blg(N)
    rm -f *.brf(N)
    rm -f *.fdb_latexmk(N)
    rm -f *.fls(N)
    rm -f *.lof(N)
    rm -f *.log(N)
    rm -f *.lol(N)
    rm -f *.lot(N)
    rm -f *.out(N)
    rm -f *.run.xml(N)
    rm -f *.toc(N)
    rm -f *.xdv(N)
    # rm -if .*.swp(N)
    # rm -if .*.swo(N)
    rm -f _minted*(N)
}

# computer vision
function cv() { g++ -std=c++11 $1 $(pkg-config --cflags --libs opencv4); }

# $1 : <input_file>
# $2 : <output_file>
function decrypt() { openssl enc -d -aes-256-cbc -in "$1" > "$2" }

# $1 : <input_file>
# $2 : <output_file>
function encrypt() { openssl enc -aes-256-cbc -salt -in "$1" -out "$2" }

# $1 : <input>.cue
# $2 : <input>.flac
function flac_split() { shnsplit -f "$1" -o flac -t "flac %n. %p - %a - %t" "$2" }

# $1 : <input_file>
function flac_convert() {
    filename=$1
    ffmpeg -i "$1" -codec:a libmp3lame -b:a 320k "${filename//flac/mp3}"
}

# converts all flac files in the current directory to mp3
function flac_convert_all() {
    for f in ./*.flac
    do
        flac_convert "$f"
    done
}

# removes audio from all files in current directory
function noaudio() {
    for f in ./*
    do
        filename="$f"
        echo Removing audio from $f ...
        ffmpeg -i $filename -c copy -an "${filename:2:8}-noaudio.mov"
        echo done.
    done
}

# $1 : <input_file>
function preview() { qlmanage -p "$1" }

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