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
# PS1 is set on every prompt by psupdate() via PROMPT_COMMAND (see bottom of
# file), so no static PS1 is assigned here. (The old block ran `git commit` in a
# command substitution at shell startup — a hang/commit hazard — and was dead
# code anyway since PROMPT_COMMAND overwrites PS1 before the first prompt.)
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

export GOPATH="/Users/Shared/go-cache"
export GOCACHE="/Users/Shared/go-build-cache"
export GOBIN="$GOPATH/bin"

export BUN_INSTALL="/Users/Shared/.bun"

export UV_CACHE_DIR="/Users/Shared/uv-cache"

# Node / CocoaPods / Homebrew caches consolidated under /Users/Shared
export npm_config_cache="/Users/Shared/npm-cache"
export CP_HOME_DIR="/Users/Shared/cocoapods"
export HOMEBREW_CACHE="/Users/Shared/homebrew-cache"

export PATH="$PATH:/Users/Shared/flutter/bin:/Users/Shared/flutter-cache/bin"
export PUB_CACHE="/Users/Shared/flutter-cache"

export JAVA_HOME="$(/usr/libexec/java_home -v 17 2>/dev/null)"

export ANDROID_HOME=/Users/Shared/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/ndk/28.2.13676358

export GRADLE_USER_HOME="/Users/Shared/gradle-cache"
export ANDROID_AVD_HOME="/Users/Shared/android-avd-cache"

export PATH="/opt/homebrew/bin:$PATH"

export PATH="$PATH:$GOBIN:$BUN_INSTALL/bin:$JAVA_HOME/bin"

# De-duplicate PATH (keep first occurrence) so re-sourcing this file doesn't
# keep appending the same entries and bloating PATH.
PATH="$(printf '%s' "$PATH" | awk -v RS=: -v ORS=: '!seen[$0]++' | sed 's/:$//')"
export PATH

#Management-----------------------------------------------------------------------------------------------------

alias lol='ls -alshFUAL'
alias sss='history | grep'

#Bashrc-----------------------------------------------------------------------------------------------------

tmpbackup(){
	mkdir -p /Users/Shared/Code/Backup
	cp ~/.bashrc /Users/Shared/Code/Backup
}
alias tmpbackup="tmpbackup"

tmpload(){
	if [ -f /Users/Shared/Code/Backup/.bashrc ]; then
		cp /Users/Shared/Code/Backup/.bashrc ~/.bashrc
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

    while lsof "$DECRYPTED_FILE" >/dev/null 2>&1; do
        sleep 1
    done

    crabEncrypt "$DECRYPTED_FILE"

    rm -P "$DECRYPTED_FILE"
}
alias crabUpdate="crabUpdate"

alias crabDecrypt="gpg -d /Users/Shared/Documents/crab.txt"
alias crabFetch="gpg -d /Users/Shared/Documents/crab.txt | grep -i "

alias crabFly="pbpaste | gpg -d | grep -i"

# gpg-agent cache TTL is set in ~/.gnupg/gpg-agent.conf (default-cache-ttl 1800).
# It launches on demand, so there's no need to start it from .bashrc.

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
alias kil="kill %%"

function killport() {
    local port="$1"
    if [ -z "$port" ]; then
        echo "Usage: killport <port>"
        return 1
    fi
    # Use -ti :port for broad compatibility
    local pid=$(lsof -ti :"$port")
    if [ -n "$pid" ]; then
        echo "Killing process(es) $pid on port $port"
        echo "$pid" | xargs kill -9
    else
        echo "Nothing found listening on port $port"
    fi
}

#Shared
alias ownfolder="sudo chown -R $(whoami):staff ."
alias brewown="sudo chown -R $(whoami):admin /opt/homebrew"

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
alias tokl="tokei -s code -f"
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
        branch=$(git symbolic-ref --short -q HEAD 2>/dev/null)
        modified=$(git diff --shortstat 2>/dev/null | awk '{print $1" +"$4" -"$6""}')
        untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | xargs)

        export PS1="\n${Blue}\W ${Yellow}$branch ${Pink}$modified *$untracked $uptodate ${Reset}"
    else
        export PS1="\n${Blue}🐌 \W 🦢 ${Reset}"
    fi
}
# Update PS1 using PROMPT_COMMAND (safer than trap DEBUG)
PROMPT_COMMAND=psupdate

#Git-----------------------------------------------------------------
alias gitstatus='repo_root=$(git rev-parse --show-toplevel 2>/dev/null); (git diff --numstat 2>/dev/null; git status --porcelain --untracked-files=all 2>/dev/null | grep '\''^??'\'' | while read -r line; do file="${line#?? }"; lines=$(wc -l < "$repo_root/$file" 2>/dev/null | xargs); echo "$lines 0 $file"; done) | awk '\''{total=$1+$2; printf "%6d %6d %6d %s\n", total, $1, $2, $3}'\'' | sort -rn | awk '\''{printf "%6d+ %6d- %s\n", $2, $3, $4}'\'''

# --- git identity / remote summary for the CURRENT repo ---
gitwho() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "Not inside a git repository."; return 1; }
  printf "name   : %s\n" "$(git config user.name)"
  printf "email  : %s\n" "$(git config user.email)"
  printf "sshkey : %s\n" "$(git config --get core.sshCommand)"
  echo   "remote :"
  git remote -v | sed "s/^/         /"
}
