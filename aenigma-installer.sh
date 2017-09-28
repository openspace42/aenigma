#!/bin/bash

echo

echo "aenigma.xyz ejabberd installer by nikksno [https://github.com/openspace42/aenigma]"
echo

echo "Run this once logged into your newly creater server via ssh as the root user"
echo
read -p "Are you currently root in your target machine (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1
echo
echo "Confirmed. Now continuing..."
echo

echo "! ! ! ! ! ! ! !"
echo
echo "WARNING: This script is NOT meant to be re-run. If you have previously run it, ONLY run it again if you whish to either:"
echo
echo "1] Fix an incomplete deployment that happened on the first run"
echo
echo "2] Start fresh with a brand new server"
echo
echo "Running this script again WILL completely obliterate any existing conigurations and data."
echo
read -p "Have you read and understood the above, and do you whish to continue now? (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1
echo
echo "Confirmed. Now continuing..."
echo

if [ -f /root/.dfbs-run-ok ]; then
        echo "Debian First Boot Setup was previously run successfully. Continuing..."
        echo
else
	echo "Debian First Boot Setup was NOT previously run successfully OR the system was not rebooted at the end."
	echo
	echo "Run it now [or re-run it and make sure you reboot at the end] by executing the following command:"
	echo
	echo "        wget -qO dfbs https://gh.nk.ai/dfbs && sudo bash dfbs"
	echo
	exit
fi

echo "----------------"
echo
echo "0] First of all, a little introduction on how XMPP actually works"
echo
echo "XMPP works a little bit like email. You can have a domain [amsterdamhacklab.xyz] and receive email for that domain on a server located at mx01.amsterdamhacklab.xyz, by using the appropriate DNS configuration, and also have other servers [webserver, mapserver, etc...] on other subdomains. In that case, a DNS "MX" record tells sending servers to direct mail intended for amsterdamhacklab.xyz to mx01.amsterdamhacklab.xyz."
echo
echo "In the same way, the XMPP server for amsterdamhacklab.xyz can be located at xmpp.amsterdamhacklab.xyz and a DNS "SRV" record tells any sending servers that XMPP for that domain [i.e. a message directed to mark@amsterdamhacklab.xyz] is handled by the server located at xmpp.amsterdamhacklab.xyz."
echo
read -p "[press enter to continue reading...]"
echo
echo "1] Now, if the domain for which you're setting up your new aenigma server is a domain connected to a bigger project, for which XMPP is just another way of getting in touch with you, definitely set things up like this by using the first option."
echo
echo "This will give you working @domain.tld xmpp account addresses, but the aenigma server will reside at subdomain.domain.tld, as in the following example."
echo
echo "Main domain:          amsterdamhacklab.xyz."
echo "Website:              amsterdamhacklab.xyz / www.amsterdamhacklab.xyz [hosted by another server]."
echo "Your XMPP address:    mark@amsterdamhacklab.xyz."
echo "XMPP server:          xmpp.amsterdamhacklab.xyz"
echo
echo "PROs:                 a] clean addresses [no mark@xmpp.amsterdamhacklab.xyz stuff]"
echo "                      b] more logical setup."
echo "CONs:                 a] requires TLS [SSL] certificate for the top level domain [amsterdamhacklab.xyz]"
echo "                         to be copied over to your new aenigma server [not hard at all, can be automated, see below]"
echo
read -p "[press enter to continue reading...]"
echo
echo "2] If instead your domain [i.e. aenigmapod42.im] is only intended to be used for your shiny new aenigma server, and you don't need other, different servers [a webserver for instance] managing different aspects of your project, you can do as so:"
echo
echo "Set your aenigma server to be located directly at your top level domain, therefore responding directly to amsterdamhacklab.xyz."
echo
echo "Your server hostname:  aenigmapod42.im"
echo "Your addresses:        mark@aenigmapod42.im."
echo
echo "PROs:                  a] clean addresses"
echo "                       b] no separate TLS certificate needed."
echo "CONs:                  a] your domain must be logically dedicated to your aenigma server"
echo "                          and not to a wider project."
echo
read -p "[press enter to continue reading...]"
echo
echo "3] In a third, although NOT suggested case, if you have a domain tied to a wider project [i.e. amsterdamhacklab.xyz] but you don't mind having longer and more complex XMPP account addresses [like mark@xmpp.amsterdamhacklab.xyz], you can choose the third option."
echo
echo "Your server hostname:  subdomain.domain.tld"
echo "Your addresses:        mark@subdomain.domain.tld."
echo
echo "PROs:                  a] domain can be logically connected to other stuff and different servers"
echo "                          with no separate TLS certificate needed."
echo "CONs:                  a] longer and more complex addresses"
echo "                       b] not logically 'clean'."
echo
read -p "[press enter to continue reading...]"
echo
echo "Now that you know how XMPP works, make your choice and let's get your brand new aenigma server up and running!"
echo
echo "----------------"
echo

choice='Please enter your choice: '
options=("configuration 1" "configuration 2" "configuration 3" "exit")
select opt in "${options[@]}"
do
    echo
    case $opt in
	"configuration 1")
	    echo "you chose configuration 1"
	    echo
	    configoption=1
	    break
	    ;;
	"configuration 2")
	    echo "you chose configuration 2"
	    echo
	    configoption=2
	    break
	    ;;
	"configuration 3")
	    echo "you chose configuration 3"
	    echo
	    configoption=3
	    break
	    ;;
	"exit")
	    echo "Exiting..."
	    echo
	    exit
	    ;;
	*)  echo "Invalid option. Retry..."
	    echo
	    ;;
    esac
done

hostname="$(cat /etc/hostname)"
ip="$(dig +short myip.opendns.com @resolver1.opendns.com)"

echo $configoption
echo $hostname
echo $ip

if [ $configoption = "1" ]

then
	echo "Ok, you've chosen option 1."
	echo
	read -p "Now set your top level domain, which will also be the part after the @ in your XMPP account addresses: " domain
	echo
	read -p "Is | $domain | correct? (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1
	echo
	echo "Your hostname must be a third level domain [subdomain] of either $domain or another domain."
	echo
	echo "Your current hostname is | $hostname |"
	echo
	read -p "Do you want to change it? (Y/n): " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Nn]$ ]]
	then
		read -p "Ok, now set your new hostname: " newhostname
		echo
		read -p "Is | $newhostname | correct? (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1
		echo
		echo $newhostname > /etc/hostname
		echo "New hostname set to | $newhostname |"
		echo
		hostname="$(cat /etc/hostname)"
	else
		echo "Leaving hostname set to | $hostname |"
		echo
	fi

elif [ $configoption = 2 ]

then
	echo "Ok, you've chosen option 2."
	echo
	read -p "Now set your top level domain, the part after the @ in your XMPP account addresses: " domain
	echo
	read -p "Is | $domain | correct? (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1
	echo
	echo "Your hostname must be identical to your domain: $domain."
	echo
	echo "Your current hostname is | $hostname |"
	echo
	if [ $hostname = $domain ]
	then
		echo "Your hostname matches your domain, all good!"
		echo
	else
		echo "Your hostname doesn't match the domain you've specified."
		echo
		echo "Having chosen option 2, they must be identical."
		echo
		read -p "Do you want to set your hostname to match your domain? (Y/n): " -n 1 -r
		echo
		if [[ ! $REPLY =~ ^[Nn]$ ]]
		then
			echo "Ok, setting hostname to match domain."
			echo
			echo $domain > /etc/hostname
			echo "New hostname set to | $domain |"
			echo
			hostname="$(cat /etc/hostname)"
		else
			echo "Not changing hostname. Exiting..."
			echo
			exit
		fi
	fi

elif [ $configoption = 3 ]

then
	echo "Ok, you've chosen option 3."
	echo
	echo "The part after the @ in your XMPP account addresses will match your server hostname."
	echo
	echo "Your hostname will be a third level domain [subdomain] of your main domain."
	echo
	echo "Your current hostname is | $hostname |"
	echo
	echo "Make sure it is a subdomain of your main domain, and is it what you want it to be."
	echo
	read -p "That said, do you want to change it? (Y/n): " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Nn]$ ]]
	then
		echo "Ok, now we'll be setting your new hostname."
		echo
		echo "Make sure it is a subdomain [third level domain] of your main domain, and keep in mind it will also become the part after the @ in your XMPP account addresses."
		echo
		read -p "Now specify your new new hostname: " newhostname
		echo
		read -p "Is | $newhostname | correct? (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1
		echo
		echo $newhostname > /etc/hostname
		echo "New hostname set to | $newhostname |"
		echo
		hostname="$(cat /etc/hostname)"
	else
		echo "Leaving hostname set to | $hostname |"
		echo
	fi
		domain=$hostname
fi

sleep 1

echo "----------------"
echo
echo "To make sure everything is correct:"
echo
echo "1] Your XMPP domain [the part after the @ in your XMPP account addresses] will be:"
echo
echo "| $domain |"
echo
echo "2] And therefore an XMPP account address will look as follows:"
echo
echo "| mark@$domain|"
echo
echo "3] Your hostname, the location on the internet of this server, will be:"
echo
echo "| $hostname |"
echo
echo "4] And therefore your aenigma admin panel will be located at:"
echo
echo "| https://$hostname |"
echo
echo "----------------"
echo

read -p "Does everything look all right? (Y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
	echo "Ok, continuing."
	echo
else
	echo "Ok, no worries. You can re-run this script right now and make the correct choices. Exiting..."
	echo
	exit
fi

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
