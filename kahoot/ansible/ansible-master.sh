#!/bin/bash
sudo su

yum install -y

#Extra Packages for Enterprise Linux (EPEL) is a special interest group (SIG) from the Fedora Project 
#that provides a set of additional packages for RHEL (and CentOS, and others) from the Fedora sources.

yum install epel-release -y

yum install ansible -v