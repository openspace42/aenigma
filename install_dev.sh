#!/bin/bash

echo

echo "Initiating installer..."
echo
git clone https://github.com/openspace42/aenigma-server.git aenigma-server
sudo bash aenigma-server/aenigma/installer-1708-v1.4
echo "Exiting installer."
