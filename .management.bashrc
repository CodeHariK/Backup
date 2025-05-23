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

function crabUpdate {
    cd /Users/Shared/Documents/

    ENCRYPTED_FILE="crab.txt"
    DECRYPTED_FILE="crab.tmp.txt"

    gpg -d $ENCRYPTED_FILE > $DECRYPTED_FILE

    code "$DECRYPTED_FILE"

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
