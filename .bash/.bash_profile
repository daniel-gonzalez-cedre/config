# ALDUIN:
#PS1='\[\e[02m\]\w\[\e[m\] \[\e[38;5;88m\]λ\[\e[m\] '
# BLAQUEMAGICK:
PS1='\[\e[38;5;1m\]\w\[\e[m\] \[\e[38;5;6m\]λ\[\e[m\] '

export TERM=xterm-256color
export PATH=/usr/local/Cellar:/usr/local/bin:/usr/local/sbin:$PATH
export LIBRARY_PATH=/usr/local/lib:/usr/local/lib/opencv4/3rdparty:/usr/local/Cellar/opencv/4.1.0_2/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/Users/akira/Downloads/osm-bundler/software/bundler/bin:$LD_LIBRARY_PATH

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'     #   config config --local status.showUntrackedFiles no
alias cp="cp -v"
alias g++="g++ -std=c++11"
alias ghc="ghc -no-keep-hi-files -no-keep-o-files"
alias haskell="runhaskell"
alias latexmk="latexmk -pdf -pvc"
alias ls="tree -h -C -N -L 1 --dirsfirst"
alias matlab="/Applications/MATLAB_R2019a.app/bin/matlab -nodesktop -nosplash"
alias mpv="open -a /Applications/mpv.app/"
alias mv="mv -v"
alias rm="rm -v"
alias python="python3"
alias tree="tree -C -N"

clean(){
    rm -i .DS_Store *.aux *.bbl *.blg *.fdb_latexmk *.fls *.log *.out
}

cv(){
    g++ -std=c++11 $1 $(pkg-config --cflags --libs opencv4);
}

decrypt(){
    openssl enc -d -aes-256-cbc -in "$1" > "$2"
}

encrypt(){
    openssl enc -aes-256-cbc -salt -in "$1" -out "$2"
}

# flac_split example.cue example.flac
flac_split(){
    shnsplit -f "$1" -o flac -t "flac %n. %p - %a - %t" "$2"
}

flac_convert(){
    filename=$1
    ffmpeg -i "$1" -codec:a libmp3lame -b:a 320k "${filename//flac/mp3}"
}

flac_convert_all(){
    for f in ./*.flac
    do
        flac_convert "$f"
    done
}

noaudio(){
    for f in ./*
    do
        filename="$f"
        echo Removing audio from $f ...
        ffmpeg -i $filename -c copy -an "${filename:2:8}-noaudio.mov"
        echo done.
    done
}

preview(){
    qlmanage -p "$1"
}

# TO CONVERT ALL .HEIC IMAGES IN A DIRECTORY TO .png
# mogrify -monitor -format png *.HEIC
reformat(){
    if [[ $# -eq 2 ]]; then
        mogrify -monitor -format "$2" *."$1"
    else
        echo Input and output filetypes are required.
    fi
}

resize(){
    for f in ./*.png
    do
        echo Resizing $f...
        convert "$f" -resize "$1" "$f"
        echo done.
    done
}

update(){
    read -p "Are you sure? [y/n] " -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        if [ -d "./.cfg" ]; then
            config fetch --all && config reset --hard origin/master
        else
            git fetch --all && git reset --hard origin/master
        fi
    fi
}

weather(){
    curl wttr.in/$1
}

#color profiles
# ┏┓ ╻  ┏━┓┏━┓╻ ╻┏━╸█▓▒░┏┳┓┏━┓┏━╸╻┏━╸╻┏ 
# ┣┻┓┃  ┣━┫┃┓┃┃ ┃┣╸ █▓▒░┃┃┃┣━┫┃╺┓┃┃  ┣┻┓
# ┗━┛┗━╸╹ ╹┗┻┛┗━┛┗━╸█▓▒░╹ ╹╹ ╹┗━┛╹┗━╸╹ ╹
#-------------------------------------|-----------------------------------------
#   BASIC         HEX                 |     BASIC         HEX                  |
#-------------------------------------|-----------------------------------------
#   Foreground    #d7d7d7             |     Text          #585858              |
#   Background    #000000             |     Bold          #585858              |
#   Links         #005cbb             |     Selection     #5F8787              |
#-------------------------------------|-----------------------------------------
#
#-------------------------------------|-----------------------------------------
#   CURSOR         HEX                |                                        |
#-------------------------------------|-----------------------------------------
#   CursorColor   #90110F             |                                        |
#   CursorText    #000000             |                                        |
#-------------------------------------|-----------------------------------------
#
#-------------------------------------|-----------------------------------------
#   NORMAL        HEX          XTERM  |      BRIGHT        HEX          XTERM  |
#-------------------------------------|-----------------------------------------
#   Black         #222222      0      |      brBlack       #222222      8      |
#   Red           #5f8787      1      |      brRed         #5f8787      9      |
#   Green         #666666      2      |      brGreen       #666666      10     |
#   Yellow        #87875f      3      |      brYellow      #87875f      11     |
#   Blue          #875F5F      4      |      brBlue        #875F5F      12     |
#   Magenta       #4B5F69      5      |      brMagenta     #4B5F69      13     |
#   Cyan          #777777      6      |      brCyan        #777777      14     |
#   White         #c1c1c1      7      |      brWhite       #c1c1c1      15     |
#-------------------------------------|-----------------------------------------
#   ___                           
#  -   -_, ,,  |\                 
# (  ~/||  ||   \\         '      
# (  / ||  ||  / \\ \\ \\ \\ \\/\\
#  \/==||  || || || || || || || ||
#  /_ _||  || || || || || || || ||
# (  - \\, \\  \\/  \\/\\ \\ \\ \\
#-------------------------------------|-----------------------------------------
#   BASIC         HEX                 |     BASIC         HEX                  |
#-------------------------------------|-----------------------------------------
#   Foreground    #dfdfaf             |     Text          #dfdfaf              |
#   Background    #121212             |     Bold          #ffffff              |
#   Links         #005cbb             |     Selection     #875f5f  Opacity 50% |
#-------------------------------------|-----------------------------------------
#
#-------------------------------------|-----------------------------------------
#   CURSOR         HEX                |                                        |
#-------------------------------------|-----------------------------------------
#   CursorColor   #90110f             |                                        |
#   CursorText    #dfdfaf             |                                        |
#-------------------------------------|-----------------------------------------
#
#-------------------------------------|-----------------------------------------
#   NORMAL        HEX          XTERM  |      BRIGHT        HEX          XTERM  |
#-------------------------------------|-----------------------------------------
#   Black         #121212      0      |      brBlack       #878787      8      |
#   Red           #af5f5f      1      |      brRed         #af5f5f      9      |
#   Green         #87875f      2      |      brGreen       #87875f      10     |
#   Yellow        #af875f      3      |      brYellow      #af875f      11     |
#   Blue          #878787      4      |      brBlue        #878787      12     |
#   Magenta       #af8787      5      |      brMagenta     #af8787      13     |
#   Cyan          #87afaf      6      |      brCyan        #87afaf      14     |
#   White         #dfdfaf      7      |      brWhite       #dfdfaf      15     |
#-------------------------------------|-----------------------------------------
# ███████╗██╗███████╗██████╗ ██████╗  █████╗
# ██╔════╝██║██╔════╝██╔══██╗██╔══██╗██╔══██╗
# ███████╗██║█████╗  ██████╔╝██████╔╝███████║
# ╚════██║██║██╔══╝  ██╔══██╗██╔══██╗██╔══██║
# ███████║██║███████╗██║  ██║██║  ██║██║  ██║
# ╚══════╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
#-------------------------------------|-----------------------------------------
#   BASIC         HEX                 |      BASIC         HEX                 |
#-------------------------------------|-----------------------------------------
#   Foreground    #dfdfaf             |      Text          #dfdfaf             |
#   Background    #121212             |      Bold          #ffffff             |
#   Links         #005cbb             |     Selection     #875F5F  Opacity 50% |
#-------------------------------------|-----------------------------------------
#
#-------------------------------------|-----------------------------------------
#   CURSOR        HEX                 |                                        |
#-------------------------------------|-----------------------------------------
#   CursorColor   #dfdfaf             |                                        |
#   CursorText    #303030             |                                        |
#-------------------------------------|-----------------------------------------
#
#-------------------------------------|-----------------------------------------
#   NORMAL        HEX          XTERM  |      BRIGHT       HEX          XTERM   |
#-------------------------------------|-----------------------------------------
#   Black         #121212      0      |      brBlack      #303030      8       |
#   Red           #af5f5f      1      |      brRed        #af5f5f      9       |
#   Green         #d75f5f      2      |      brGreen      #d75f5f      10      |
#   Yellow        #afd7d7      3      |      brYellow     #afd7d7      11      |
#   Blue          #af8787      4      |      brBlue       #af8787      12      |
#   Magenta       #dfaf87      5      |      brMagenta    #dfaf87      13      |
#   Cyan          #ffafaf      6      |      brCyan       #ffafaf      14      |
#   White         #dfdfaf      7      |      brWhite      #dfdfaf      15      |
#-------------------------------------|-----------------------------------------