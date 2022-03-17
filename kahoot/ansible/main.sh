#!/bin/bash
sudo su
source ./constants.sh


function manual(){
    echo ""
    printf "Usage: $0 [ -a ] [ -m ]"
    echo ""
    exit 2
}


function info(){
    printf "$1\n"
}

function warn (){
    info $1
}

function generateObjectJson(){

    shell=$1
    change_state=$2

    obj= "
        {

            'ansible_facts': {
                'shell': ${shell}
            },
            'changed': ${change_state},
            'ping': 'pong'

        }
    "
}

function reportMsg(){

    host_ip=$1
    status_msg=$2
    shell=$3
    change_state=$4

    generateObjectJson $shell $change_state

    echo "
        $host_ip | $status_msg => ${obj}
    "
}

function preCheck(){

    #check for bin commands

    command -V ssh || (

    )

    command -V curl || (

    )

    #check for constants
}



while getopts "a:m:" option;do 

    case ${option} in 

        a) 
            echo "Execute this command $OPTARG instead "
            shift
        ;;
        -h)
            echo "Excute module name $OPTARG"
            shift
        ;;
        \?)
            manual
        ;;

    esac


done

