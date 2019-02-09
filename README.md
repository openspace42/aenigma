# aenigma

![aenigma logo](logo/aenigma_logo.png?raw=true)

**aenigma** provisions a **fully functional** and **secure-out-of-the-box** **XMPP server** you can get running today.

It does for XMPP what [Mail-in-a-Box](https://github.com/mail-in-a-box/mailinabox) has done for email, [Streisand](https://github.com/StreisandEffect/streisand) for VPNs, and [Easyengine](https://easyengine.io/) for wordpress / nginx sites hosting.

The installation takes you on a 15 minute, clearly worded, step-by-step setup and takes care of everything automagically.

All of the features offered by our project and the related installation instructions are detailed below.

## The openspace instance of aenigma

Take a look at our actual running instance of aenigma - operated by our hackerspace [openspace](https://openspace.xxx) - by registering a forever free account **@os.vu**.

You can register your account right now by specifying a `your-user@os.vu` JID [jabber user ID] during the new account creation fase [offered by virtually all XMPP apps] and dive right into this amazing world!

As soon as you're up and running join our group chat at xmpp:aenigma@xc.os.vu !

<a href='https://compliance.conversations.im/server/os.vu'><img src='https://compliance.conversations.im/badge/os.vu'></a>

## News and official chatroom

Follow our development updates together with the aenigma community on our chatroom at xmpp:aenigma@xc.os.vu.

If you have an operational aenigma server, definitely subscribe for new release notifications and other important heads-up alerts.

## Support the project

You can now become a Patreon supporter of the project starting at only $1/month, and access our priority support, custom features rapid development requests [then made available for eveyone of course], and help ensure that aenigma is always on the bleeding edge of features offered by ejabberd and the XMPP world. Help us out and join our Patreon community [here](https://www.patreon.com/aenigma_xmpp). Thank you in advance!

## Features

* **state of the art configuration** always updated with the latest functionalities and best practices for every ejabberd version
* **latest and most robust security by default** in addition to a built-in first-boot system-wide hardening script
* **one touch deployment**: just clone and run the setup script on one or multiple freshly installed machines
* features a **simple, clear, step-by-step installer** that makes sure you get everything perfect on the first run
* always based on the **latest version of ejabberd**, a modern, scalable, and robust XMPP server [thanks to the jabber.at APT repository that allows your system to keep ejabberd up to date independently of aenigma]
* provisions **100% compliant servers** by passing all of the [2018 XEP-0387 compliance checks](https://compliance.conversations.im/about/) and therefore those performed by the Conversations client
* natively supports **[almost] signal-level encrypted conversations** with all the required modules for **OMEMO E2EE**
* allows you to and guides you through using your **top level domain as the xmpp domain [@domain.xyz]** while hosting the server on a subdomain [xmpp.domain.xyz] as its hostname by using SRV records [without any XMPP client UI/UX complications or TLS conflicts]
* **fully supports IPv6** out of the box meaning your client applications could hypothetically work on IPv6-only networks
* listens for all of the required **XMPP c2s [client to server], HTTP_uploads, and SSH connections *also* on port 443** [thanks to SSLH] to allow XMPP clients and administrative workstations behind restrictive firewalls to connect without the need to circumvent the firewall with VPNs or Tor [and sets SRV records for XMPP over TLS (XEP-0368) so that clients can find this server capability autonomously and automatically]
* **validates all required IPv4 and IPv6 DNS settings including SRV records** [even those for specific modules such as pubsub] and tells you exactly the correct values for each record [work in progress: automatic DNS provisioning via API]
* sets up the **system firewall and UFW rules** for all configured services
* installs nginx and makes the ejabberd **web admin interface securely available** at `https://[hostname]`
* provisions and automatically renews **free and fully valid LetsEncrypt wildcard TLS [SSL] certificates** and correctly configures all deployed services [ejabberd, nginx, etc...] accordingly
* creates ejabberd **Shared Roster Groups** to easily allow admins to see all users registered on their own rosters and all users online at any given time
* automatically **backups up** all configuration, the ejabberd database, and XMPP data storage **locally and [optionally] to S3 with strong encryption** via duplicity and includes a script for a **guided, consistent, and complete restore**
* allows you to easily run your aenigma instance on **multiple servers [a cluster]** for **robustness, load distribution / balancing, and failover**
* **idempotent and self-versioning** to allow for easy re-installs, re-configurations, and upgrades

## Non-features

* Keeps backwards compatibility with other, older, not 100% compliant, XMPP servers out there by using a not very restrictive ciphersuite for s2s [aka server to server] connections, but you can break all bridges with the rest of the world and enable the latest ciphers suggested by cipherli.st [although really not recommended] by changing two lines in the config file

## Future features

* New and improved backup / restore logic that is cluster-aware and more robust when handling unusual user-level situations [[Patreon $16/month goal](https://www.patreon.com/aenigma_xmpp)]

* Automated DNS record provisioning on any nameserver backend that has an API access [CloudFlare, mail-in-a-box, etc...] [[Patreon $24/month goal](https://www.patreon.com/aenigma_xmpp)]

* Complete and total re-write of our synthia+dna framework [currently entirely in bash] into a fully modern and professional codebase designed with a modular and innovative approach and consisting of a nodejs core with an extensible and cross-language package and automation platform [Patreon $32/month goal](https://www.patreon.com/aenigma_xmpp)]

Add your feature requests in the issues section and consider becoming a Patreon supporter for access to rapid development and fast-tracking of your feature requests!

## Donate to keep the project running

**aenigma** takes a bunch of time to research, develop, maintain, and keep up to date with the latest features offered by everything in the XMPP world [ejabberd, OMEMO, and so on].

Let's not make this project fall into deprecation-land like so many other great ones out there!

**Help make aenigma always stable and state-of-the-art by donating a small amount every month towards its development.**

You can become a [Patreon supporter](https://www.patreon.com/aenigma_xmpp) right now starting at only $1/month and help us make a difference!

Otherwise you can also make a one-time donation via the following channels:

**BTC:** [3L6rgbypntMxpbz2Yrzf6iZsFWvE1AgMSU](bitcoin:3L6rgbypntMxpbz2Yrzf6iZsFWvE1AgMSU) | **PayPal:** []

Thank you very much in advance and don't forget to spread the word with your fellow friends, family, activists, and geeks!

## Install

The only supported distros are **Ubuntu 18 [bionic beaver]** and **Debian 9 [stretch]**.

Any distro NOT based on Debian / Ubuntu will currently never work because our framework is entirely and fundamentally designed to work with these distros only. In the future this will change.

```
[log in as root on your target machine]
```

```
apt update
apt install git
```

```
git clone https://github.com/openspace42/aenigma
bash aenigma/setup
```

## Restore a previous install on a fresh new machine:
### [either from S3 or another standalone backup from your old instance]

```
[log in as root on your target machine]
```

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

### For Linux:

**Dino** [still in beta | OMEMO only partially working] [[github](https://github.com/dino/dino)]

### For web

**Converse.JS** [[website](https://conversejs.org)] [either as simply a web client to use for yourself or to integrate into your website]

## Talks and keynotes

* [Linux day 2018 @ unixMIB Milano](https://docs.google.com/presentation/d/1p6nkmWOBJ7xcWOE6tZIKmgsmYoW353SCv27TAvqDRH8/edit?usp=sharing) [in italian]

* [35C3 @ ChaosZone stage](https://docs.google.com/presentation/d/1pkJ25XLQRr4dGqM7SpMwBXrXmlU8cv0Ip-yGEoucXRw/edit?usp=sharing) [in english]

## Credits

Very special thankyous to:

**Torn [autistici.org]** for inspiring in me the idea of a federated messaging network.

**Gio [eigenlab / LibreMesh]** for leading me towards XMPP instead after talking about related projects.

**Palinuro + MiBoFra [frozenbox.org / parrotsec.org]** for actually getting me started on XMPP.

**Daniel Gultsch + Holger Weiß** for their excellent work and for their very precious advice and opinions about XMPP at large and its future.

The LUG **unixMIB** [Milano Bicocca university] for hosting my presentation on Linux Day 2018.

The hackerspace assembly **ChaosZone** for hosting my presentation at 35C3.

Also, anyone involved in the XMPP community, and aenigma users, beta testers, and contributors of course!

Thanks to all of you. Let's make this happen. It's about time [finally].
