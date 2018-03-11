#!/bin/bash

set -e
set -u

r=$(tput setaf 1)
g=$(tput setaf 2)
l=$(tput setaf 4)
m=$(tput setaf 5)
x=$(tput sgr0)
b=$(tput bold)

basedir=/root/openspace42 # Don't change! | No trailing slash!
installdir=$basedir/aenigma # Don't change! | No trailing slash!
configdir=$installdir/config # Don't change! | No trailing slash!

echo

echo "${b}Initiating restore script...${x}"
echo



SESSION_TYPE=local

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE=ssh
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) SESSION_TYPE=ssh;;
    esac
fi

if [ $SESSION_TYPE = "ssh" ]
then

    sshconnectionstatus="$(echo "$SSH_CLIENT" | grep "::1" | wc -l)"

    if [ ! $sshconnectionstatus = 0 ]
    then
        echo "${r}${b}You appear to be connected via SSH on port 443 thanks to SSLH.${x}"
        echo
        echo "${b}This is usually perfectly fine, but not during installation, as we will be terminating SSLH during one of the steps.${x}"
        echo
        echo "${b}Please connect via your normal SSH port until you're finished re-installing aenigma${x}"
        echo
        echo "${b}Exiting...${x}"
        echo
        exit
    fi

fi



if [[ $EUID -ne 0 ]]
then
    echo "${r}${b}This script must be run as root. Run it as:${x}"
    echo
    echo "sudo bash aenigma/install.sh"
    echo
    echo "${b}Exiting...${x}"
    echo
    exit
fi



if [ "`lsb_release -d | sed 's/.*:\s*//' | sed 's/16\.04\.[0-9]/16.04/' `" != "Ubuntu 16.04 LTS" ]
then
    echo "${r}${b}aenigma only runs on Ubuntu 16.04. You are running:${x}"
    echo
    lsb_release -d | sed 's/.*:\s*//'
    echo
    exit
fi



if [ -f $basedir/DFBS/run-ok ]
then
    echo "${g}${b}Debian First Boot Setup was previously run successfully. Continuing...${x}"
    echo
else
    echo "${r}${b}Debian First Boot Setup was NOT previously run successfully OR the system was not rebooted at the end.${x}"
    echo
    read -p "${b}Run it now? (Y/n): ${x}" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
        echo "${b}Ok, running DFBS now...${x}"
        echo
        echo "${b}After you're done running DFBS [make sure you reboot this machine at the end], simply run the aenigma installer again.${x}"
        echo
        sleep 3
        if [ -d "/root/Debian-First-Boot-Setup" ]
        then
            rm -r "/root/Debian-First-Boot-Setup"
        fi
        git clone https://github.com/openspace42/Debian-First-Boot-Setup
        clear
        bash Debian-First-Boot-Setup/script.sh
        exit
    else
        echo "${b}No problem, you can run it [make sure you reboot this machine at the end] by executing the following commands:${x}"
        echo
        echo "${b} | git clone https://github.com/openspace42/Debian-First-Boot-Setup |${x}"
        echo
        echo "${b} | bash Debian-First-Boot-Setup/script.sh |${x}"
        echo
        echo "${b}Exiting...${x}"
        echo
        exit
    fi
fi



echo "${b}Now installing dependencies...${x}"
echo
hostname="$(cat /etc/hostname)"
apt-add-repository ppa:duplicity-team/ppa -y
apt-get update
apt-get -y install dnsutils ufw bc duplicity python-pip pwgen
pip install --upgrade pip
pip install boto
debconf-set-selections <<< "postfix postfix/mailname string $hostname"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt-get install -y mailutils
/etc/init.d/postfix reload
echo
echo "${b}Finished installing dependencies.${x}"
echo



echo "${g}${b}Preflight check complete.${x}"
echo
echo "${b}Now proceeding with aenigma restore...${x}"
echo

sudo bash aenigma/tools/aenigma-restore

echo "${b}Exiting restore script.${x}"
echo



exit
