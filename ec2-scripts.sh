#!/bin/bash

config(){
    #Note:  the  values  you  provide  for the AWS Access Key ID and the AWS
    #Secret Access Key will  be  written  to  the  shared  credentials  file
    #(~/.aws/credentials).
    aws configure set aws_access_key_id $1
    aws configure set aws_secret_access_key $2
    aws configure set default.region $3

}

get_aws_configuration(){

    config=""
    command="aws configure get"

    case "$1" in
        "aws_access_key_id")
        config=$($command aws_access_key_id) 
        ;;
        "aws_secret_access_key")
        config=$($command aws_secret_access_key) 
        ;;
        "region")
        config=$($command region) 
        ;;
        *)
        exit
        ;;
    esac

    echo $config

}

list_profiles(){
    aws configure list
}

hibernate(){

    if [[  -z "$1" ]];then
        printf "Provide an instance-id to start-up eg. i-0d91a3xxxxxxxx"
        printf "Actual usage: $0 start_instance i-0d91a3xxxxxxx"
        exit
    fi

    aws ec2 stop-instances \
    --instance-ids $1 \
    --hibernate 

}

start_instances(){

    if [[  -z "$1" ]];then
        printf "Provide an instance-id to start-up eg. i-0d91a3xxxxxxxx"
        printf "Actual usage: $0 start_instance i-0d91a3c43c8e88855"
        exit
    fi

    aws ec2 start-instances  \
    --instance-ids $1
}


command -v aws ||  printf "aws cli not installed. follow https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html to install it first \n"


command=""

for x in "$@"; do
    command=$command" $x"
done

eval "$command" 
