#!/bin/bash

# specify version to be installed in the format "x.y"
installvers=0.42

r=`tput setaf 1`
g=`tput setaf 2`
x=`tput sgr0`
b=`tput bold`

echo

echo "${b}Initiating installer...${x}"
echo

if [[ $EUID -ne 0 ]]; then
	echo "${r}This script must be run as root. Run it as:${x}"
	echo
	echo "sudo bash aenigma/install.sh"
	echo
	exit
fi

if [ -f /root/os-dfbs/run-ok ]; then
        echo "${g}${b}Debian First Boot Setup was previously run successfully. Continuing...${x}"
        echo
else
	echo "${r}${b}Debian First Boot Setup was NOT previously run successfully OR the system was not rebooted at the end.${x}"
	echo
	echo "${b}Run it now [or re-run it and make sure you reboot at the end] by executing the following commands:${x}"
	echo
	echo "${b} | git clone https://github.com/openspace42/Debian-First-Boot-Setup |${x}"
	echo
	echo "${b} | bash Debian-First-Boot-Setup/script.sh |${x}"
	echo
	exit
fi

echo "${b}Now installing dependencies...${x}"
echo
apt-get update
apt-get -y install dnsutils ufw
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
