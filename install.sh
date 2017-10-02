#!/bin/bash

r=`tput setaf 1`
g=`tput setaf 2`
x=`tput sgr0`

echo

echo "Initiating installer..."
echo

if [ -f /root/.dfbs-run-ok ]; then
        echo "${g}Debian First Boot Setup was previously run successfully. Continuing...${x}"
        echo
else
	echo "${r}Debian First Boot Setup was NOT previously run successfully OR the system was not rebooted at the end.${x}"
	echo
	echo "Run it now [or re-run it and make sure you reboot at the end] by executing the following command:"
	echo
	echo "        wget -qO dfbs https://gh.nk.ai/dfbs && sudo bash dfbs"
	echo
	exit
fi

sudo bash aenigma-server/aenigma/installer-1708-v1.4

echo "Exiting installer."
echo
