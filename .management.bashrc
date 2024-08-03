####-----------------------------------------------------------------------------------
alias lol='ls -alshFUAL'
alias lor='ls -alshFUARL'
alias sss='history | grep'

alias ip='ifconfig | grep 192'

#Graphics-----------------------------------------------------------------------------------------------------
alias glslang="glslangValidator.exe"

#Kubernetes---------------------------------------------------------------------------------------------------
alias k=kubectl

export KUBE_EDITOR='code --wait'

#Management-----------------------------------------------------------------------------------------------------
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
alias credit="code ~/.bashrc && code ~/.management.bashrc && code ~/.projects.bashrc"

function reload(){
    source ~/.bashrc
    tmpbackup
}
alias reload="reload"

#Encrypt-----------------------------------------------------------------------------------------------------
alias dacc="gpg -d"
alias crab="dacc /Users/Shared/Documents/crab.txt | grep -i "
gpg-agent --default-cache-ttl 30

function encc() {
    local file_path="$1"

    # Check if file path is provided
    if [ -z "$file_path" ]; then
        echo "Usage: encrypt_file_with_gpg <file_path>"
        return 1
    fi

    # Check if file exists
    if [ ! -f "$file_path" ]; then
        echo "File not found: $file_path"
        return 1
    fi

    local md5_hash
    md5_hash=$(md5 -q "$file_path") 

    local current_date
    current_date=$(date +"%Y%m%d")

    local new_filename="${current_date}_${md5_hash}.txt"

    gpg -cav --compress-algo=bzip2 --cipher-algo=AES256 -o "$new_filename" "$file_path"
    cp "$new_filename" "crab.txt"

    if [ $? -eq 0 ]; then
        echo "File encrypted successfully: $new_filename"
    else
        echo "Encryption failed"
    fi
}
alias encc="encc"

#Process-------------------------------------------------------------
alias proc="ps -aux"
alias kil="kill %%"
