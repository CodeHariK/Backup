####----------------------------------------------------------------------------
code="/mnt/e/niagara"
alias cdoc="http-server -s $code"
alias proj="cd $code"
# doxyfile=$(wslpath -w $code/Doxy/Doxyfile)
alias doxygen="$code/Doxy/doxygen.exe"
doc() {
	cd $code;
	doxygen $doxyfile;
	cp $code/Doxy/search.css $code/Docs/html/search
}
alias doc=doc

#Firebase---------------------------------------------------------------------------------
alias femu='firebase emulators:start'
alias tbw="(cd functions && npm run build:watch)"
# alias buf="(cd proto && npx buf generate lib)"

kp() {
	lsof -ti tcp:$1 | xargs kill -9
}

#Docker-----------------------------------------------------------------------------------
alias drmi='docker image rm $(docker image ls -aq)'
alias drmc='docker container rm -f $(docker container ps -aq)'
alias drmv='docker volume rm $(docker volume ls -q)'

alias dcu="docker-compose up --build"

#Flutter & Deno & Node-----------------------------------------------------------------------------------
alias flwb="dart run build_runner watch --delete-conflicting-outputs"
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

hello(){
	read -p "Are you sure? " -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo hello
	elif [[ $REPLY =~ ^[Nn]$ ]]; then
		echo no	
	fi
}
alias hello=hello
