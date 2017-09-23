#!/bin/bash

echo

echo "aenigma.xyz ejabberd installer  by nikksno [https://github.com/openspace42/aenigma]"
echo

echo "Run this once logged into your newly creater server via ssh as the root user"
echo
read -p "Are you currently root in your target machine (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1
echo
echo "Confirmed. Now continuing..."
echo

if [ -f /root/.dfbs-run-ok ]; then
        echo "Debian First Boot Script was previously run successfully. Continuing..."
        echo
else
	echo "Debian First Boot Script was NOT previously run successfully."
	echo "Do this now by running:"
	echo
	echo "wget -qO dfbs https://gh.nk.ai/dfbs && sudo bash dfbs"
	echo
	exit
fi

hostname="$(cat /etc/hostname)"

read -p "Now set your domain [the part after the @ in your usernames - not your server hostname] " domain
echo
read -p "Is | $domain | correct? (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1
echo

wget -O ejabberd_17.08-0_amd64.deb https://www.process-one.net/downloads/downloads-action.php?file=/ejabberd/17.08/ejabberd_17.08-0_amd64.deb

dpkg -i ejabberd_17.08-0_amd64.deb

echo "Finished installing ejabberd"
echo
sleep 4

ufw allow 5222
ufw allow 5269
ufw allow 5280
ufw allow 80
ufw allow 443

echo "Finished setting UFW rules"
echo
sleep 4

wget -qO ee rt.cx/ee && sudo bash ee

echo "Finished installing easyengine"
echo
sleep 4

ee site create $hostname --proxy=127.0.0.1:5280 --le

echo "Finished creating easyengine site"
echo
sleep 4

wget -O aenigma-ejabberd.yml https://raw.githubusercontent.com/openspace42/aenigma/master/ejabberd.yml

sed -i 's/example.im/$domain/g' aenigma-ejabberd.yml

cp aenigma-ejabberd.yml /opt/ejabberd-17.08/conf/ejabberd.yml

echo "Finished setting custom ejabberd.yml config file"
echo
sleep 4

service ejabberd restart

echo "Finished starting ejabberd"
echo
sleep 4

ejbdadminpw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 24 | head -n 1)

ejabberdctl register admin localhost $ejbdadminpw

echo "Finished registering ejabberd admin user"
echo
sleep 4

echo "Now log in:"
echo
echo "https://$hostname"
echo
echo "admin@localhost"
echo $ejbdadminpw
echo

echo "All done!"
echo

exit
