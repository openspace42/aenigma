# aenigma

![aenigma logo](logo/aenigma_logo.png?raw=true)

**aenigma** provisions a **fully functional** and **secure** out of the box **XMPP server** you can get running today.

It does for XMPP what [Mail-in-a-Box](https://github.com/mail-in-a-box/mailinabox) has done for email, [Streisand](https://github.com/StreisandEffect/streisand) for VPNs, and [Easyengine](https://easyengine.io/) for wordpress.

The installation takes you on a four-minute, clearly worded, step-by-step setup and takes care of everything automagically.

As soon as you're up and running join our conference at os@xc.os.vu !

## Help us test out the upcoming version

We'd love you to help us test aenigma on Ubuntu 18.04 [bionic beaver] beta and make sure we're ready for when the LTS release comes out on April 26th 2018.

If you happen to have the time [and have a known-to-work aenigma backup in case you're an existing user], simply:

1. Log in as root on your Ubuntu 16.04 server
1. Upgrade to Ubuntu 18.04 beta with `do-release-upgrade -d` and confirm with `lsb_release -a` that you're indeed on 18.04
2. Run [or re-run] the aenigma installer

You will notice some errors, namely with EasyEngine, which doesn't support 18.04 yet, but everything other than the aenigma web interface [which relies on nginx] should work perfectly. If you require the use of the web interface, don't upgrade for now, or open up the correct port on your server's UFW and access the ejabberd web interface directly, keeping in mind that it's not secured in any way!

Thanks in advance for your help!

## Features

* **State of the art configuration**
* **Secure by default** [see [non-features](#non-features) for the one and only backwards compatibility exception]
* **One touch deployment**: install it in three minutes with two commands!
* Has a guided, **step-by-step install** that makes sure you get everything perfect on the first run
* Always based on the **latest version of ejabberd**, a modern, scalable, and robust XMPP server
* Passes all of the **compliance checks** performed by the Conversations client
* Passes all of the ejabberd-supported [XEP-0375 compliance checks](https://github.com/iNPUTmice/ComplianceTester)
* Allows you to and guides you through using your **top level domain as the xmpp domain [@example.im]** while hosting the server on a subdomain [xmpp.example.im] as its hostname by using SRV records without any XMPP client UI/UX or TLS conflicts.
* **Supports IPv6** out of the box
* **Validates all required IPv4 and IPv6 DNS settings** [even those for specific modules such as `pubsub.`] and tells you exactly the correct values for every record
* Sets up **UFW rules** for all configured services
* Provisions **free and fully valid TLS [SSL] certificates** for everything [ejabberd and web] thanks to LetsEncrypt
* Installs nginx and makes the ejabberd **web admin interface securely available** at https://[hostname]
* Easily allows for the website for your top level domain to be hosted on the same server as well
* Listens for **XMPP c2s [aka client to server], HTTP_upload, and SSH connections *also* on port 443** [thanks to SSLH] to allow XMPP clients and administrative workstations behind restrictive firewalls to connect without the need to circumvent the firewall with VPNs or Tor
* Natively supports **Signal-level encrypted conversations** with all the required modules for **OMEMO E2EE**
* Configures ejabberd **Shared Roster Groups** to easily allow the desired users to see eachother on their own rosters
* Automaticaly **backups up** all ejabberd files and database **locally and to S3** and includes a script for a **guided, three step restore process**.

## Non-features

* Keeps backwards compatibility with legacy XMPP servers by using a not very restrictive ciphersuite for s2s [aka server to server] connections, but you can enable the latest ciphers suggested by cipherli.st [although not recommended] by changing two lines in the config file.

## New features

###  v0.5x

* Full XEP-0375 thanks to ejabberd 18.0x
* Ubuntu 18.04 [bionic beaver] support [and requirement]
* Newly implemented openspace [bash_functions](https://github.com/openspace42/bash_functions)

## Install on Ubuntu 16.04 LTS / Ubuntu 18.04 LTS beta

```
apt update
apt install git
```

```
git clone https://github.com/openspace42/aenigma
sudo bash aenigma/setup
```

## Restore a previous install on a fresh new machine:
### [either from S3 or another standalone backup from your old instance]

```
apt update
apt install git
```

```
git clone https://github.com/openspace42/aenigma
sudo bash aenigma/tools/aenigma-restore
```

## Recommended clients:

### For Android:

**Conversations** [[github](https://github.com/siacs/Conversations)] [[f-droid](https://f-droid.org/packages/eu.siacs.conversations/)] [[website](https://conversations.im/)]

### For iOS:

**ChatSecure** [[github](https://github.com/chatsecure)] [[app store](https://itunes.apple.com/us/app/chatsecure/id464200063)] [[website](https://chatsecure.org/)]

## Credits

Very special thankyous to:

Torn [autistici.org] for inspiring in me the idea of a federated messaging network

Gio [eigenlab / LibreMesh] for leading me towards XMPP instead after talking about related projects.

Palinuro + MiBoFra [frozenbox.org / parrotsec.org] for actually getting me started on XMPP.

Daniel Gultsch + Holger Weiß for their excellent work and for their very precious advice and opinions about XMPP at large and its future.

Also, anyone involved in the XMPP community.

Thanks to all of you. Let's make this happen. It's about time [finally].
