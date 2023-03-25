autoload -Uz add-zsh-hook
setopt prompt_subst
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# !!! git integration, but this is slow !!!
# autoload -Uz add-zsh-hook vcs_info
# function precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# add-zsh-hook precmd vcs_info
# # zstyle ':vcs_info:git:*' formats '%b'
# # use %b for the branch
# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:*' formats "%F{12}%c%u%b%f"
# zstyle ':vcs_info:*' actionformats "%F{4}%c%u%b%f %a"
# zstyle ':vcs_info:*' stagedstr "%F{2}"
# zstyle ':vcs_info:*' unstagedstr "%F{9}"
# zstyle ':vcs_info:*' check-for-changes true
# 
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

function promptwidth() { echo $(( ${COLUMNS} - 15 - 10 - 10)) }
function dirwidth() { echo $(( ${COLUMNS} - 15 - 10 - 10)) }
function hostwidth() { echo $(( ${COLUMNS} - 15 - 10 - 3)) }
width='$(promptwidth)'
dwidth='$(dirwidth)'
hwidth='$(hostwidth)'
# PROMPT=' ${vcs_info_msg_0_} %F{11}λ%f '
PROMPT=' %F{11}λ%f '
RPROMPT="%F{0}[%D{%L:%M:%S}]%F{0}%${width}<...< %F{9}%~%F{0} %<<%F{3}%m%f"
# RPROMPT='[%0F%D{%m-%d-%y %L:%M:%S}%f] %9F%1~%0F:%3F%m%f'

function schedprompt() {
    emulate -L zsh
    zmodload -i zsh/sched
    integer i=${"${(@)zsh_scheduled_events#*:*:}"[(I)schedprompt]}
    (( i )) && sched -$i
    zle && zle reset-prompt
    sched +30 schedprompt
}
schedprompt


export EDITOR='vim'
export VISUAL='vim'
export GREP_OPTIONS="--color=always"  # --line-buffered

export TERM=xterm-256color
export PATH=/opt/homebrew/bin:/usr/local/Cellar:/usr/local/bin:/usr/local/sbin:/Users/danielgonzalez/Library/Python/3.8/bin:$PATH

alias gitfig="/usr/bin/git --git-dir=$HOME/.gitfig/ --work-tree=$HOME"     #   gitfig config --local status.showUntrackedFiles no

alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias rsync="rsync -v --progress"

alias ls="tree -h -C -N -L 1 --dirsfirst"
alias tree="tree -C -N -h --dirsfirst"
function tree_ascii() { tree --dirsfirst -C -N -h "$1" | sed 's/├/\+/g; s/─/-/g; s/└/\\/g' }

alias g++="g++ -std=c++11"
alias ghc="ghc -no-keep-hi-files -no-keep-o-files"
alias haskell="runhaskell"
alias matlab="/Applications/MATLAB_R2019a.app/bin/matlab -nodesktop -nosplash"
# alias minicondactivate="source ~/miniconda3/bin/activate"
alias python="python3"
function minicondactivate() {
    source ~/miniconda3/bin/activate
    PROMPT=" ${vcs_info_msg_0_} %11Fλ%f "
    RPROMPT="%0F$CONDA_PROMPT_MODIFIER%f$RPROMPT"
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
function clean(){
    rm "${1:-}" .DS_Store *.aux *.brf *.blg *.bst *.fdb_latexmk *.fls *.log *.out *.bcf *.run.xml *.xdv *.toc *.lol _minted* __pycache__/
}
# function clean(){
#     [ -e .DS_Store ] && rm -v .DS_Store
#     [ -e *.aux ] && rm -v *.aux
#     [ -e *.bcf ] && rm -v *.bcf
#     [ -e *.blg ] && rm -v *.blg
#     [ -e *.brf ] && rm -v *.brf
#     [ -e *.bst ] && rm -v *.bst
#     [ -e *.fdb_latexmk ] && rm -v *.fdb_latexmk
#     [ -e *.fls ] && rm -v *.fls
#     [ -e *.log ] && rm -v *.log
#     [ -e *.out ] && rm -v *.out
#     [ -e *.run.xml ] && rm -v *.run.xml
#     [ -e *.xdv ] && rm -v *.xdv
#     [ -e *.toc ] && rm -v *.toc
#     [ -e *.lol ] && rm -v *.lol
#     [ -e _minted* ] && rm -v _minted*
#     [ -e __pycache__ ] && rm -rf __pycache__
#     [ -e *.bbl ] && rm -v -i *.bbl
# }

function cleanswp(){ .*.swp .*.swo }

# computer vision
function cv(){ g++ -std=c++11 $1 $(pkg-config --cflags --libs opencv4); }

# $1 : <input_file>
# $2 : <output_file>
function decrypt(){ openssl enc -d -aes-256-cbc -in "$1" > "$2" }

# $1 : <input_file>
# $2 : <output_file>
function encrypt(){ openssl enc -aes-256-cbc -salt -in "$1" -out "$2" }

# $1 : <input>.cue
# $2 : <input>.flac
function flac_split(){ shnsplit -f "$1" -o flac -t "flac %n. %p - %a - %t" "$2" }

# $1 : <input_file>
function flac_convert(){
    filename=$1
    ffmpeg -i "$1" -codec:a libmp3lame -b:a 320k "${filename//flac/mp3}"
}

# converts all flac files in the current directory to mp3
function flac_convert_all(){
    for f in ./*.flac
    do
        flac_convert "$f"
    done
}

# removes audio from all files in current directory
function noaudio(){
    for f in ./*
    do
        filename="$f"
        echo Removing audio from $f ...
        ffmpeg -i $filename -c copy -an "${filename:2:8}-noaudio.mov"
        echo done.
    done
}

# $1 : <input_file>
function preview(){ qlmanage -p "$1" }

# to convert all .HEIC images in a directory to .png
# mogrify -monitor -format png *.HEIC
function reformat(){
    if [[ $# -eq 2 ]]; then
        mogrify -monitor -format "$2" *."$1"
    else
        echo Input and output filetypes are required.
    fi
}

# $1 : ???
function resize(){
    for f in ./*.png
    do
        echo Resizing $f...
        convert "$f" -resize "$1" "$f"
        echo done.
    done
}
