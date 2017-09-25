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
ip="$(curl ipinfo.io/ip)"

read -p "Now set your domain [the part after the @ in your usernames - not your server hostname] " domain
echo
read -p "Is | $domain | correct? (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1
echo

echo $hostname #debug
echo $domain #debug

wget -O ejabberd_17.08-0_amd64.deb https://www.process-one.net/downloads/downloads-action.php?file=/ejabberd/17.08/ejabberd_17.08-0_amd64.deb

dpkg -i ejabberd_17.08-0_amd64.deb

echo "Finished installing ejabberd"
echo
sleep 1

ufw allow 5222
ufw allow 5269
ufw allow 5444
ufw allow 80
ufw allow 443

echo "Finished setting UFW rules"
echo
sleep 1

wget -qO ee rt.cx/ee && sudo bash ee

echo "Finished installing easyengine"
echo
sleep 1

ee site create $hostname --le

wget -qO nginx.conf https://raw.githubusercontent.com/openspace42/aenigma/master/nginx.conf

sed -i "s/example.im/${hostname}/g" nginx.conf

cp nginx.conf /etc/nginx/sites-available/$hostname

service nginx reload

echo "Finished creating easyengine site"
echo
sleep 1

wget -qO index.html https://raw.githubusercontent.com/openspace42/aenigma/master/index.html

mv index.html /var/www/$hostname/htdocs/

echo "Finished setting index.html in docroot"
echo
sleep 1

touch /opt/ejabberd-17.08/conf/le.pem

cat /etc/letsencrypt/live/$hostname/privkey.pem > /opt/ejabberd-17.08/conf/le.pem
cat /etc/letsencrypt/live/$hostname/fullchain.pem >> /opt/ejabberd-17.08/conf/le.pem

openssl dhparam -out /opt/ejabberd-17.08/conf/dh.pem 4096

echo "Finished creating all-in-one TLS file for ejabberd"
echo
sleep 1

wget -O aenigma-ejabberd.yml https://raw.githubusercontent.com/openspace42/aenigma/master/ejabberd-new.yml

sed -i "s/example.im/${domain}/g" aenigma-ejabberd.yml

cp aenigma-ejabberd.yml /opt/ejabberd/conf/ejabberd.yml
cp aenigma-ejabberd.yml /opt/ejabberd-17.08/conf/ejabberd.yml

echo "Finished setting custom ejabberd.yml config file"
echo
sleep 1

/opt/ejabberd-17.08/bin/ejabberdctl start

sleep 8

/opt/ejabberd-17.08/bin/ejabberdctl status

sleep 1

echo "Finished starting ejabberd"
echo
sleep 1

ejbdadminpw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 24 | head -n 1)

echo /opt/ejabberd-17.08/bin/ejabberdctl register admin $domain $ejbdadminpw #debug

/opt/ejabberd-17.08/bin/ejabberdctl register admin $domain $ejbdadminpw

echo "Finished registering ejabberd admin user"
echo
sleep 1

echo "Now log in:"
echo
echo "https://$hostname/admin"
echo
echo "admin@$domain"
echo $ejbdadminpw
echo

echo "Make sure your DNS settings are as follows:"
echo
echo "$hostname                    A      $ip"
echo "xc.$domain                   A      $ip"
echo "xu.$domain                   A      $ip"
echo
echo "_jabber._tcp.$domain         SRV    0 0 5269 $hostname."
echo "_xmpp-server._tcp.$domain    SRV    0 0 5269 $hostname."
echo "_xmpp-client._tcp.$domain    SRV    0 0 5222 $hostname."
echo

echo "All done!"
echo

exit
