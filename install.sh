#!/bin/bash

basedir=/root/openspace42 # Don't change! | No trailing slash!
installdir=$basedir/aenigma # Don't change! | No trailing slash!
configdir=$installdir/config # Don't change! | No trailing slash!

r=`tput setaf 1`
g=`tput setaf 2`
x=`tput sgr0`
b=`tput bold`

echo

# Detect old installation dir and move to new location
if [ -d "/root/os-aenigma" ]
then
	echo "${b}Detected old installation directory '/root/os-aenigma/'. Moving to new location: | $installdir/ |${x}"
	echo
	mkdir -p $configdir
	mv /root/os-aenigma/* $configdir/
	mv $configdir/beta $installdir/  &> /dev/null || true
	rm -r /root/os-aenigma/
fi

# specify version to be installed in the format "x.y"
installvers=0.44

if [ -f $installdir/beta ]
then
	installvers=0.45
	beta=y
else
	beta=n
fi

echo "${b}Initiating installer...${x}"
echo

if [ $beta = "y" ]
then
	echo "${r}${b}Using beta version v$installvers${x}"
	echo
	echo "${b}[delete the | $installdir/beta | file to cancel your opt-in to beta versions]${x}"
	echo
fi

if [[ $EUID -ne 0 ]]
then
	echo "${r}${b}This script must be run as root. Run it as:${x}"
	echo
	echo "sudo bash aenigma/install.sh"
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

if [ -f /root/os-dfbs/run-ok ]
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
apt-get update
apt-get -y install dnsutils ufw
echo
echo "${b}Finished installing dependencies.${x}"
echo

echo "${g}${b}Preflight check complete.${x}"
echo
echo "${b}Now proceeding with aenigma installation...${x}"
echo

sudo bash aenigma/aenigma/installer-v"$installvers"

echo "${b}Exiting installer.${x}"
echo

exit
