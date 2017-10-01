#!/bin/bash

echo "Initiating installer..."
echo
wget -qO  aenigma-installer-1708 https://raw.githubusercontent.com/openspace42/aenigma-server/master/aenigma/installer-1708
sudo bash aenigma-installer-1708
echo "Exiting installer."
echo
