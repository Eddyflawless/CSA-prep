#!/bin/bash
sudo su
yum update -y
yum install httpd  php php-mysql stress -y

echo " <!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Index page</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

    </head>
    <body >
        <h1>Hello Darkvadr</h1>
    </body>
</html> " > /var/www/html/index.html

service httpd start
chkconfig httpd on