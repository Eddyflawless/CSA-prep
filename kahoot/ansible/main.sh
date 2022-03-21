#!/bin/bash
#sudo su

source ./constants.sh #very important inclustion

time=$(date '+%H:%M:%S')
output_file="reports/report-$(date '+%Y-%m-%d').txt"

function print_line(){
    echo -e "------------------------------------------------- \n"
}

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

function execute_command(){

    arguments=""

    for t in $@; do
        arguments="$arguments $t"
    done

    echo "execute ==> $arguments"

    
}

function ping_host(){

    arguments=$(echo "$1" | sed 's/,/ /g')

    for arg in ${arguments[@]}; do 
        eval "ping -t 2 ${arg}"
    done
    
}


function create_new_playbook(){

    play_book_template="""
#!/bin/bash

echo '$0 executing script play....'

pem_file='pems/sample.pem'

if [[ -f $pem_file ]]; then

    exit

fi

#update os

#update specific security patch for software(s)

#reload a service(s)

    """
    host_template="""
#eg. 45.56.72.153
    """
    
    count=$( expr $(ls -l $PLAY_DIR | wc -l)  + 1 )

    new_dir="$PLAY_DIR/play.$count"

    #create folder
    echo "Creating parent folder...."
    mkdir -p "$new_dir"

    echo "Creating necessary files..."
    #add files
    echo "$play_book_template" >> "$new_dir/play.sh"
    echo "$host_template" >> "$new_dir/host.cfg"

    #change permissions
    chmod +x "$new_dir/play.sh"

}

function run_play_suite(){

    for play_folder in $(ls ./plays); do 

        current_folder="plays/$play_folder"
        
        play_book="$current_folder/play.sh"

        file_permissions=$( stat -f "%OLp" $play_book) #expecting 755

        if [[ -f  $play_book ]] ; then

            if [[ -x $play_book ]]; then
                chmod +x $play_book
            fi

            echo "executing $play_book"

            log "[playbook:$play_book $time]: Executing...."
            
            eval "$play_book >> $output_file"

            log "[playbook:$play_book $time]: Done! \n"

        fi

    done

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


command_str=unset

while getopts "m:c:ba" option;do 

    case ${option} in 

        a) 
            echo "Execute play suite.... "
            command_str="run_play_suite"
            shift
        ;;
        m)
            echo "Excute module name $OPTARG"
            command_str="ping_host $OPTARG"
            shift
        ;;
        c)
            echo "Excute module name $OPTARG"
            command_str="execute_command $OPTARG"
        ;;
        p)
            echo "Excute module name $OPTARG"
            command_str=""
            shift
        ;;
        b)
            echo "Create new playbook $OPTARG"
            command_str="create_new_playbook"
            shift
        ;;
        \?)
            manual
        ;;

    esac


done

preCheck

if [[ ! -z "$command_str" ]]; then 
    eval "$command_str"
fi

#run_play_suite

