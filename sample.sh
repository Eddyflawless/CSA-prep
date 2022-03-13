#!/bin/bash

set +x

downloadDir="/Users/$USER/Downloads"

if [[ ! -d "$downloadDir" ]]; then
    echo ""
    echo "creating $downloadDir"
    mkdir -p "$downloadDir"

fi

strip_trailing_slashes() {
  printf "$1" | sed 's/[/]*$//'
}

show_manual(){
    printf "$0 Usage: \n"
}

attach_file(){

    return "@$1"
}

ftp_download(){ 

    credentials=$1

    #curl -u "username:password" ftp://ftp.slackware.com/
    curl -O --progress-bar -u "$credentials" $2
}



post_data_urlencoded(){ 

    if [[ -z "$1" ]];then
        printf "file url cannotbe null \n"
        exit

    fi

    attachFile=""

    if [[ -n "$3"  ]]; then

        attachFile=$(attach_file $3) 
        attachFile= "-d $attachFile"

    fi

    echo "Posting data to $1...."

    # data example "param1=value1&param2=value2"

    curl -d $2  $attachFile --progress-bar  -H "Content-Type: application/x-www-form-urlencoded" -X POST $1

}

post_data_json(){ 

    if [[ -z "$1" ]];then
        printf "Endpoint cannotbe null \n"
        exit
    fi

    if [[ -z "$2" ]];then
        printf "Post data wasnot specified  \n"
        exit
    fi


    echo "Posting data to $1...."

    # data eg: '{"key1":"value1", "key2":"value2"}'
    curl -L -d $2 $attachFile --progress-bar  -H "Content-Type: application/json" -X POST $1


}

download_file(){

    if [[ -z "$1" ]];then
        printf "File url cannot be null \n"
        exit

    fi

    #downlaod https://unsplash.com/photos/V4wfJsjHwhs/download?ixid=MnwxMjA3fDB8MXxhbGx8NHx8fHx8fDJ8fDE2NDcwOTU0NTk&force=true
    echo "downloadind $1 ...."
    cwd=$(pwd)

    cd $downloadDir
    curl -Lkf --remote-name  $1

    cd $cwd
}


if [[ $# -eq 0 ]]; then
    show_manual
    exit
fi

if [[  "$1" == "-h" || "$1" == "--help" || -z "$1" ]]; then

    show_manual
    exit
fi


command=""

for x in "$@"; do
    command=$command" $x"
done

echo ""
printf "command is $command \n"

eval "$command" 

