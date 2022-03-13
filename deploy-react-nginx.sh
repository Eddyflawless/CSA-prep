#!/bin/bash

if [[ -z "$1" ]]; then

    echo ""
    echo "Pass a valid github repo link"
    echo "....."
    exit

fi

work_dir=$2


sudo apt-get update
sudo apt-get upgrade

echo ""
echo "Installing node...."
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt-get install -y nodejs  curl
nginx -v
sudo systemctl restart nginx

#clone repo
echo ""
echo "Cloning react repo"

dir=$(echo $1 | cut -d "/" -f 5 | cut -d "." -f1)

git clone $1 && cd $dir


if [[ -n "$work_dir" ]]; then

    cd $work_dir

fi

#install node modules
npm install

#run build command
npm run build

#remove existing files
rm -rf /var/www/html/*

#copy build optimized files to /var/www/html directory
sudo cp -r build/* /var/www/html/

