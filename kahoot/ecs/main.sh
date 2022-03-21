#!/bin/bash
#sudo su

source ./constants.sh #very important inclustion

function log(){

    #log into console
    log_output=$1
    echo $log_output

    print_line

    #log into file
    echo -e "$1" >> $output_file

}


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

function preCheck(){

    #check for bin commands

    command -v ssh || (
        warn "Ensure ssh is installed on your linux distributtion"
    )

    command -v curl || (
        warn "Ensure ssh is installed on your linux distributtion"
    )

    #check for constants
}

function getDefaultRegion(){
    exit
}


function getEcsParams(){
    exit
}


function createCluster(){
    exit
}


function tearDownECSCluster(){
    exit
}


command_str=unset



