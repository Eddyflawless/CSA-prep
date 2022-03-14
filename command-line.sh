#!/bin/bash

command=unset
NAME="medusa"
readonly NAME

function info() {
  printf "$1\n"
}

function manual(){
    echo ""
    printf "Usage: $0 [ -r ] [ -h ]"
    echo ""
    exit 2
}

while getopts "r:h:" option;do 

    case ${option} in 

        r) 
            echo "display in red of $OPTARG"
            shift
        ;;
        -h)
            echo "display in hibernate $OPTARG"
            shift
        ;;
        \?)
            manual
        ;;

    esac


done

