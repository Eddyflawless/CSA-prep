#!/bin/bash

pem_path=$1
ssh_server=$2

usage(){
    printf "Usage: $? <path-to-pem> <ssh-server> eg: $? bad-boy.pem ec2-user@10.0.0.1 \n"
}

if [[ ! -f $pem_path ]]; then

    printf "$pem_path path is wrong or doesnot exist \n"
    exit

fi

ssh -i $pem_path $ssh_server -y