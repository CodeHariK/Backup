# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

####--------------------------------------------------------
Blue='\[\033[38;5;39m\]'
PurpleBack='\[\033[48;5;135m\]'
Pink='\[\033[38;5;210m\]'
Yellow='\[\033[38;5;11m\]'
Green='\[\033[38;5;76m\]'
Reset='\[$(tput sgr0)\]'
if [ "$color_prompt" = yes ]; then
	#PS1="\n${PurpleBack} 🍕 \w 👻 ${Reset} "
	#PS1="\n${PurpleBack} 👻 -> 🍕 ${Reset} "
	PS1="\n${Blue}🐌 \W ${Yellow}$(git branch 2>/dev/null | grep '^*' | colrm 1 2) ${Pink}$(git commit | grep modified | wc -l | xargs),$(git ls-files --others --exclude-standard | wc -l | xargs) 🦢 ${Reset}"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

####--------------------------------------------------------
#eval "$(dircolors ~/.dircolors)"

#export DISPLAY=:0.0
#export LIBGL_ALWAYS_INDIRECT=1o

####--------------------------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

####--------------------------------------------------------

export GOPATH="/Users/Shared/go-cache"
export GOCACHE="/Users/Shared/go-build-cache"
export GOBIN="$GOPATH/bin"

export BUN_INSTALL="/Users/Shared/.bun/bin"

export UV_CACHE_DIR="/Users/Shared/uv-cache"

export PUB_CACHE="/Users/Shared/flutter-cache"

export ANDROID_HOME=/Users/Shared/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/ndk/29.0.13113456

export GRADLE_USER_HOME="/Users/Shared/gradle-cache"
export ANDROID_AVD_HOME="/Users/Shared/android-avd-cache"

export PATH="/opt/homebrew/bin:$PATH"

export PATH=$PATH:$GOBIN:$BUN_INSTALL:$UV_CACHE_DIR


#Management-----------------------------------------------------------------------------------------------------

alias lol='ls -alshFUAL'
alias lor='ls -alshFUARL'
alias sss='history | grep'

alias ip='ifconfig | grep 192'

alias dtp="cd /mnt/c/Users/Hari/Desktop"

alias fsizes="du -hsc * | sort -h" #List all files
alias fsize="du -hsc *"

alias se="du -ha . | grep -i"
alias grs="grep -ri" #Recursive String Search

alias tx="tar -xf"

alias lib="cd /mnt/e/files/Library"
alias sl="du -ha /mnt/e/files/Library | grep -i"

alias n3="nano -l --tabsize=3"

alias cpByName="echo find . -name "'*Name*'" -exec cp {} ../Name \;"

alias treevideo="tree -vJH . > content.html"

#Bashrc-----------------------------------------------------------------------------------------------------

tmpbackup(){
	mkdir -p /Users/Shared/Backup
	cp ~/.bashrc /Users/Shared/Backup
}
alias tmpbackup="tmpbackup"

tmpload(){
	if [ -f /Users/Shared/Backup/.bashrc ]; then
		cp /Users/Shared/Backup/.bashrc ~/.bashrc
	fi
	source ~/.bashrc
}
alias tmpload="tmpload"

alias reload="source ~/.bashrc"

#Encrypt-----------------------------------------------------------------------------------------------------

function crabUpdate {
    cd /Users/Shared/Documents/

    ENCRYPTED_FILE="crab.txt"
    DECRYPTED_FILE="crab.tmp.txt"

    gpg -d $ENCRYPTED_FILE > $DECRYPTED_FILE

    cursor "$DECRYPTED_FILE"

    sleep 1

    while lsof | grep -q "$DECRYPTED_FILE"; do
        sleep 1
    done

    crabEncrypt $DECRYPTED_FILE

    rm $DECRYPTED_FILE
}
alias crabUpdate="crabUpdate"

alias crabDecrypt="gpg -d /Users/Shared/Documents/crab.txt"
alias crabFetch="gpg -d /Users/Shared/Documents/crab.txt | grep -i "

alias crabFly="pbpaste | gpg -d | grep -i"

gpg-agent --default-cache-ttl 30

function crabEncrypt() {
    cd /Users/Shared/Documents/ || return 1

    local file_path="$1"

    # Check if file path is provided
    if [ -z "$file_path" ]; then
        echo "Usage: crabEncrypt <file_path>"
        return 1
    fi

    # Check if file exists
    if [ ! -f "$file_path" ]; then
        echo "File not found: $file_path"
        return 1
    fi

    local temp_encrypted="temp_encrypted.gpg"

    # Encrypt the file
    gpg -cav --compress-algo=bzip2 --cipher-algo=AES256 -o "$temp_encrypted" "$file_path"
    
    if [ $? -ne 0 ]; then
        echo "Encryption failed"
        return 1
    fi

    # Compute MD5 hash of the encrypted file
    local md5_hash
    md5_hash=$(md5 -q "$temp_encrypted")

    local current_date
    current_date=$(date +"%Y%m%d")

    local new_filename="${current_date}_${md5_hash}.gpg"

    # Rename the encrypted file
    mv "$temp_encrypted" "$new_filename"
    
    # Copy the new encrypted file to "crab.txt"
    cp "$new_filename" "crab.txt"

    echo "File encrypted successfully: $new_filename"
}
alias crabEncrypt="crabEncrypt"

#Process-------------------------------------------------------------
alias proc="ps -aux"
alias kil="kill %%"

alias killport="lsof -ti:\$1 | xargs kill -9"

#Shared
alias shared777="sudo chmod -R 777 /Users/Shared/"
alias brewown="sudo chown -R $(whoami):admin /opt/homebrew"

#Git-----------------------------------------------------------------
alias gitstatus='(git diff --numstat | awk '\''{total=$1+$2; printf "%6d %6d %6d %s\n", total, $1, $2, $3}'\''; git status --porcelain --untracked-files=all | grep '\''^??'\'' | awk '\''{printf "%6d U %s\n", 999999, $2}'\'') | sort -rn | awk '\''{if ($2 == "U") printf "      U %s\n", $3; else printf "%6d+ %6d- %s\n", $2, $3, $4}'\'''

#Firebase---------------------------------------------------------------------------------
alias femu='firebase emulators:start'
alias tbw="(cd functions && npm run build:watch)"
alias bufgen="buf dep update && buf lint && buf generate --include-imports --include-wkt"

#Docker-----------------------------------------------------------------------------------
alias drmi='docker image rm $(docker image ls -aq)'
alias drmc='docker container rm -f $(docker container ps -aq)'
alias drmv='docker volume rm $(docker volume ls -q)'

alias dcu="docker-compose up --build"

#Flutter & Deno & Node-----------------------------------------------------------------------------------

alias sdkm='sdkmanager --sdk_root=$ANDROID_HOME'

alias dartbr="dart run build_runner watch --delete-conflicting-outputs"
alias splash="dart run flutter_native_splash:create"
alias licon="dart run flutter_launcher_icons"

function adbcon() {
    # addr=`adb.exe shell netcfg | grep rmnet0 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
    addr=`adb shell ip addr | grep inet | grep wlan0 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | grep -m 1 192`
    echo $addr &&
    adb connect $addr:5555 &&
	adb devices -l
}

alias adb="/Applications/adb"
alias adbcon="adbcon"
alias adev="adb devices"
alias akill="adb kill-server"
alias a5="adb tcpip 5555"
alias aaa="a5 && adbcon"

alias gbuild="./gradlew build"
alias ginstall="./gradlew installDebug"
alias gclean="./gradlew clean"

#Ios----------------------------------------------------------------------------------------

alias ipod="cd ios && rm -rf Pods Podfile.lock && pod deintegrate && pod install && cd .."

alias ilist="xcodebuild -list"

alias idevices="xcrun simctl list devices"
alias idevicetypes="xcrun simctl list devicetypes"
alias ishutdown="xcrun simctl shutdown iPhone_17_Pro"
alias ierase="xcrun simctl erase iPhone_17_Pro"
alias idelete="xcrun simctl delete iPhone_17_Pro"

alias icreate="xcrun simctl create iPhone_17_Pro iPhone 17 Pro"
alias iboot="xcrun simctl boot iPhone_17_Pro"

alias ibuild="xcodebuild -scheme swiftales -destination 'platform=iOS Simulator,name=iPhone_17_Pro' build"

alias imac="xcodebuild -scheme swiftales -destination 'platform=macOS' build"

alias iinstall="xcrun simctl install 'iPhone_17_Pro' '/Users/a24/Library/Developer/Xcode/DerivedData/swiftales-dfblcdpqkauavvayuxpfokhuykaf/Build/Products/Debug-iphonesimulator/swiftales.app'"

alias ilaunch="xcrun simctl launch 'iPhone_17_Pro' run.shark.swiftales"

#Code Analysis-----------------------------------------------------------------------------
function list_directories_recursive() {
    if [ -z "$1" ]; then
        echo "Usage: list_directories_recursive <directory> [maxdepth]"
        return 1
    fi

    local target_directory="$1"
    local maxdepth="$2"
    local maxdepth_option=""

    if [ -n "$maxdepth" ]; then
        maxdepth_option="-maxdepth $maxdepth"
    fi

    # Use find command to list directories recursively
    find "$target_directory" $maxdepth_option -type d -print
}

function run_command_on_directories() {
    local command_to_run="$1"
    local target_directory="$2"
    local maxdepth="$3"

    # List directories recursively
    local directories=($(list_directories_recursive "$target_directory" "$maxdepth"))

    # Run command on each directory
    for dir in "${directories[@]}"; do
        echo "Running command on directory: $dir"
        # Add your command here using $dir as the directory variable
        # Example: 
        # Your command might look like: `echo "Processing files in $dir"`
        # Replace the above example with the actual command you want to run
        $command_to_run "$dir"
        result=$?
        if [ $result -ne 0 ]; then
            echo "Command failed for directory: $dir (Exit Code: $result)"
        fi
    done
}

alias run_command_on_directories='run_command_on_directories'
alias list_directories_recursive='list_directories_recursive'

alias tok="tokei"
alias tokl="tokei -f"
alias toki='run_command_on_directories tokei . 1'
alias toker='run_command_on_directories tokei .'


# Update PS1-----------------------------------------------------------------------------
function psupdate(){
    # Check if we're in a git repository without throwing errors
    if git rev-parse --git-dir &>/dev/null; then
        uptodate="💔"
        # Check if upstream exists and compare with HEAD
        if git rev-parse @{u} &>/dev/null 2>&1; then
            if [ "$(git rev-parse HEAD 2>/dev/null)" == "$(git rev-parse @{u} 2>/dev/null)" ]; then
                uptodate="🦋"
            fi
        fi
        branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
        modified=$(git diff --shortstat 2>/dev/null | awk '{print $1" +"$4" -"$6""}')
        untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | xargs)

        export PS1="\n${Blue}\W ${Yellow}$branch ${Pink}$modified *$untracked $uptodate ${Reset}"
    else
        export PS1="\n${Blue}🐌 \W 🦢 ${Reset}"
    fi
}
trap psupdate DEBUG
