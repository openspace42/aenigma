# aenigma

**aenigma** provisions a **fully functional** and **secure** out of the box **XMPP server** you can get running today.

It does for XMPP what [Mail-in-a-Box](https://github.com/mail-in-a-box/mailinabox) has done for email, [Streisand](https://github.com/StreisandEffect/streisand) for VPNs, and [Easyengine](https://easyengine.io/) for wordpress.

The installation takes you on a three-minute, clearly worded, step-by-step setup and takes care of everything automagically.

As soon as you're up and running join our conference at os@xc.os.vu !

## Features

* **State of the art configuration** [work in progress ;]
* **Secure by default** [see [non-features](#non-features) for backwards compatibility exceptions]
* **One touch deployment**: install it in three minutes with two commands!
* Has a guided, **step-by-step install** that makes sure you get everything perfect on the first run
* Always based on the **latest version of ejabberd**, a modern, scalable, and robust XMPP server
* Passes all of the **compliance checks** performed by the Conversations client <sup>[1](#01)
* Passes all of the ejabberd-supported [XEP-0375 compliance checks](https://github.com/iNPUTmice/ComplianceTester) <sup>[2](#02)
* Allows you to and guides you through using your **top level domain as the xmpp domain [@example.im]** while hosting the server on a subdomain [xmpp.example.im] as its hostname by using SRV records without any XMPP client UI/UX or TLS conflicts.
* Works perfectly for both internet accessible and local network deployments
* **Supports IPv6** out of the box
* **Validates all required IPv4 and IPv6 DNS settings** [even those for specific modules such as `pubsub.`] and tells you exactly the correct values for every record
* Sets up **UFW rules** for all configured services
* Provisions **free and fully valid TLS [SSL] certificates** for everything [ejabberd and web] thanks to LetsEncrypt
* Installs nginx and makes the ejabberd **web admin interface securely available** at https://[hostname]
* Easily allows for the website for your top level domain to be hosted on the same server as well
* Listens for **XMPP c2s [aka client to server] and SSH connections *also* on port 443** [thanks to SSLH] to allow XMPP clients and administrative workstations behind restrictive firewalls to connect without the need to circumvent the firewall with VPNs or Tor
* Natively supports **Signal-level encrypted conversations** with all the required modules for **OMEMO E2EE**
* Configures ejabberd **Shared Roster Groups** to easily allow the desired users to see eachother on their own rosters

##### 01

Although Conversations says PEP [Avatars / OMEMO] is *not* supported, it actually is, and both work perfectly

##### 02

Not yet supported by ejabberd:

* XEP-0357: Push Notifications
* XEP-0368: SRV records for XMPP over TLS [should start working soon thanks to ejabberd v17.09]
* XEP-0384: OMEMO Encryption [even though OMEMO works perfectly]

## Non-features

* Keeps backwards compatibility with legacy XMPP servers by using a not very restrictive ciphersuite for s2s [aka server to server] connections, but you can enable the latest ciphers suggested by cipherli.st [although not recommended] by changing two lines in the config file.

## Install on Ubuntu 16

current version: v0.43 [2017-10-28]

```
apt update
apt install git
```

```
git clone https://github.com/openspace42/aenigma.git
sudo bash ./aenigma/install.sh
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

David Gultsch + Holger Weiß for their excellent work and for their very precious advice and opinions about XMPP at large and its future.

Also, anyone involved in the XMPP community.

Thanks to all of you. Let's make this happen. It's about time [finally].
