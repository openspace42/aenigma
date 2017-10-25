#!/bin/bash

# specify version to be installed in the format "x.y"
installvers=0.42

r=`tput setaf 1`
g=`tput setaf 2`
x=`tput sgr0`

echo

echo "Initiating installer..."
echo

if [[ $EUID -ne 0 ]]; then
	echo "${r}This script must be run as root. Run it as:${x}"
	echo
	echo "sudo bash aenigma/install.sh"
	echo
	exit
fi

if [ -f /root/os-dfbs/run-ok ]; then
        echo "${g}Debian First Boot Setup was previously run successfully. Continuing...${x}"
        echo
else
	echo "${r}Debian First Boot Setup was NOT previously run successfully OR the system was not rebooted at the end.${x}"
	echo
	echo "Run it now [or re-run it and make sure you reboot at the end] by executing the following commands:"
	echo
	echo " | git clone https://github.com/openspace42/Debian-First-Boot-Setup |"
	echo
	echo " | bash Debian-First-Boot-Setup/script.sh |"
	echo
	exit
fi

echo "Now installing dependencies..."
echo
apt-get update
apt-get -y install dnsutils ufw
echo "Finished installing dependencies."
echo

echo "${g}Preflight check complete.${x}"
echo
echo "Now proceeding with aenigma installation..."
echo

sudo bash aenigma/aenigma/installer-v"$installvers"

echo "Exiting installer."
echo

exit
