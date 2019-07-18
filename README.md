# aenigma

![aenigma logo full](logo/aenigma_logo-full-blue-blue-blck-nobg-4x.png?raw=true)

**aenigma** provisions a **fully functional** and **secure-out-of-the-box** **XMPP server** you can get running today.

It does for XMPP what [Mail-in-a-Box](https://github.com/mail-in-a-box/mailinabox) has done for email, [Streisand](https://github.com/StreisandEffect/streisand) for VPNs, and [Easyengine](https://easyengine.io/) for wordpress / nginx sites hosting.

The installation takes you on a 15 minute, clearly worded, step-by-step setup and takes care of everything automagically.

All of the features offered by our project and the related installation instructions are detailed below.

## The official instance of aenigma

Take a look at our actual running instance of aenigma - a fully functional XMPP server cluster operated by our hackerspace [openspace](https://openspace.xxx) - by registering a forever free account **@aenigma.xyz**.

You can register your account right now by specifying a `your-user@aenigma.xyz` JID [jabber user ID] during the new account creation phase [offered by virtually all XMPP apps] and dive right into this amazing world!

If you're finding XMPP to your liking, then deploy your own server following the very simple instructions below! As soon as you're up and running join our group chat at [aenigma@xc.aenigma.xyz](xmpp:aenigma@xc.aenigma.xyz) !

<a href='https://compliance.conversations.im/server/aenigma.xyz'><img src='https://compliance.conversations.im/badge/aenigma.xyz'></a>

## Features

* **state of the art configuration** always updated with the latest functionalities and best practices for every ejabberd version
* **latest and most robust security by default** in addition to a built-in first-boot system-wide hardening script
* **one touch deployment**: just clone and run the setup script on one or multiple freshly installed machines
* features a **simple, clear, step-by-step installer** that makes sure you get everything perfect on the first run
* always based on the **latest version of ejabberd**, a modern, scalable, and robust XMPP server
* provisions **100% compliant servers** by passing all of the [2018 XEP-0387 compliance checks](https://compliance.conversations.im/about/) and therefore those performed by the Conversations client
* natively supports **[almost] signal-level encrypted conversations** with all the required modules for **OMEMO E2EE**
* allows you to and guides you through using your **top level domain as the xmpp domain [@domain.xyz]** while hosting the server on a subdomain [xmpp.domain.xyz] as its hostname by using SRV records [without any XMPP client UI/UX complications or TLS conflicts]
* easily handles multiple XMPP domains on the same server / cluster with automatic ejabberd, LetsEncrypt, and SSLH provisioning + DNS tests
* **fully supports IPv6** out of the box, meaning your client applications could hypothetically work on IPv6-only networks
* listens for all of the required **XMPP c2s [client to server], HTTP_uploads, and SSH connections *also* on port 443** [thanks to SSLH] to allow XMPP clients and administrative workstations behind restrictive firewalls to connect without the need to circumvent the firewall with VPNs or Tor [and sets SRV records for XMPP over TLS (XEP-0368) so that clients can find this server capability autonomously and automatically]
* **validates all required IPv4 and IPv6 DNS settings including SRV records** [even those for specific modules such as pubsub] and tells you exactly the correct values for each record [work in progress: automatic DNS provisioning via API]
* sets up the **system firewall and UFW rules** for all configured services
* installs nginx and makes the ejabberd **web admin interface securely available** at `https://[hostname]`
* provisions and automatically renews **free and fully valid LetsEncrypt wildcard TLS [SSL] certificates** and correctly configures all deployed services [ejabberd, nginx, etc...] accordingly
* provisions a **PostgreSQL database instance** [and clusters it if necessary with etcd, Patroni, and HAProxy] to provide a robust and high performance backend to ejabberd and movim
* creates ejabberd **Shared Roster Groups** to easily allow admins to see all users registered on their own rosters and all users online at any given time
* uses nginx-based XMPP uploads rather than ejabberd's built-in module for higher robustness.
* automatically **backups up** all configuration, the ejabberd database, and XMPP data storage **locally and [optionally] to S3 with strong encryption** via duplicity and includes a script for a **guided, consistent, and complete restore**
* allows you to easily run your aenigma instance on **multiple servers [a cluster]** for **robustness, load distribution / balancing, and failover**
* is **idempotent and self-versioning** to allow for easy re-installs, re-configurations, and upgrades
* also provisions a **Tor hidden service** [optional] to make your server [or cluster] reachable entirely inside the Tor network via a .onion address for all services [XMPP, web, SSH, etc...].
* also provisions an instance of **the Converse.js XMPP web client** [optional] to give you a fast and easy way to access your client account from anywhere!
* also provisions an instance of a **Movim** pod [optional] to turn your XMPP experience into a social one! [work in progress]
* has a **logelevel zero** mode where no user connection / disconnection traffic data are logged in order to limit the amount of information left over should the server be compromised or seized in the future

## Non-features

* Keeps backwards compatibility with other, older, not 100% compliant, XMPP servers out there by using a not very restrictive ciphersuite for s2s [aka server to server] connections, but you can break all bridges with the rest of the world and enable the latest ciphers suggested by cipherli.st [although really not recommended] by changing two lines in the config file

## Support the project

You can now become a Patreon supporter of the project starting at only $1/month, and access our priority support, custom features rapid development requests [then made available for eveyone of course], and help ensure that aenigma is always on the bleeding edge of features offered by ejabberd and the XMPP world. Help us out and join our Patreon community [here](https://www.patreon.com/aenigma_xmpp). Thank you in advance!

## News and official chatroom

Follow our development updates together with the aenigma community on our chatroom at [aenigma@xc.aenigma.xyz](xmpp:aenigma@xc.aenigma.xyz).

If you have an operational aenigma server, definitely subscribe for new release notifications and other important heads-up alerts.

### Latest post: 2019-07-18 | v0.7.2-beta.1 release

```
Hi all, aenigma with working backups is almost out, and will ship with what is now synthia v4, with an entirely re-curated codebase

Making every function faster and easier to read, and standardized spacing and commenting. Some DNA functions have been improved, and, most importantly for you guys, every action previously performed by a script like a aenigma-clusterize has now been made into a function of itself that can be ran standalone from aenigma-env

The installer will now handle user denial conditions more gracefully asking them to re-specify parameters rather then exit the script entirely.

Also, side note, a new project was born called nimbo, it will completely automate the installation of a nextcloud server, with dedicated database, redis caching, and one day even clustering capabilities, of course with our stable and now super stable S3 backup/restore capabilities.

A nice addition to your project team, school, or workplace, if you like aenigma and are looking to host your own cloud. If you like the idea, give it a test when the first beta is out.

As always, you can test out this specific beta with:

aenigma-upgrade -dt -pt

or try out the latest bleeding_edge version up to HEAD with:

aenigma-upgrade -db -pb

or simply wait for this stable release to be published - after which you'll be able to upgrade normally with:

aenigma-upgrade

Thanks for following our project and please consider becoming a supporter if you're finding it interesting, useful, or both!

Nz
```

you can find older news items on our archive page [here](/News.md)

## Future features

* New and improved backup / restore logic that is cluster-aware and more robust when handling unusual user-level situations [[Patreon $16/month goal](https://www.patreon.com/aenigma_xmpp)]

* Automated DNS record provisioning on any nameserver backend that has an API access [CloudFlare, mail-in-a-box, etc...] [[Patreon $24/month goal](https://www.patreon.com/aenigma_xmpp)]

* Complete and total re-write of our synthia+dna framework [currently entirely in bash] into a fully modern and professional codebase designed with a modular and innovative approach and consisting of a nodejs core with an extensible and cross-language package and automation platform [[Patreon $48/month goal](https://www.patreon.com/aenigma_xmpp)]

Add your feature requests in the issues section and consider becoming a Patreon supporter for access to rapid development and fast-tracking of your feature requests!

## Donate to keep the project running

**aenigma** takes a bunch of time to research, develop, maintain, and keep up to date with the latest features offered by everything in the XMPP world [ejabberd, OMEMO, and so on].

Let's not make this project fall into deprecation-land like so many other great ones out there!

**Help make aenigma always stable and state-of-the-art by donating a small amount towards its development.**

You can become a [Patreon supporter](https://www.patreon.com/aenigma_xmpp) right now starting at only $1/month and help us make a difference!

Otherwise you can also make a one-time donation via the following channels:

**BTC:** [3L6rgbypntMxpbz2Yrzf6iZsFWvE1AgMSU](bitcoin:3L6rgbypntMxpbz2Yrzf6iZsFWvE1AgMSU) | **PayPal:** []

Thank you very much in advance and don't forget to spread the word with your fellow friends, family, activists, and geeks!

## Install

The only supported distros are **Ubuntu 18 [bionic beaver]** and **Debian 9 [stretch]**.

Any distro NOT based on Debian / Ubuntu will NOT currently work because - at the moment - our framework is entirely and fundamentally designed to work with these distros only. In the future this will change with the new nodejs core.

aenigma is only intended to be installed on **brand new fresh machines** with absolutely no previously installed services, as it makes changes to system and widely used package / services settings [such as SSH, UFW, NGINX, Postfix, etc...] which are absolutely aenigma-specific and could render either the existing services or the aenigma installation itself non-functional.

Therefore **only install aenigma on fresh servers** [physical or virtual] with only the base operating system installed and nothing else! During install it will automatically take care of running you through a first-boot machine-hardening script called [inception](https://github.com/openspace42/inception) - without ever leaving the aenigma installer itself - that will guide you through all of the security and basic setup operations that every new server should have performed onto it before going ahead and doing anything else.

That said, let's get started!

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
bash aenigma/tools/aenigma-restore
```

## Recommended clients:

### For Android:

**Conversations** [[github](https://github.com/siacs/Conversations)] [[f-droid](https://f-droid.org/packages/eu.siacs.conversations/)] [[website](https://conversations.im/)]

### For iOS:

**ChatSecure** [[github](https://github.com/chatsecure)] [[app store](https://itunes.apple.com/us/app/chatsecure/id464200063)] [[website](https://chatsecure.org/)]

### For Linux:

**Dino** [still in beta | OMEMO only partially working] [[github](https://github.com/dino/dino)]

### For web

**Converse.JS** [[website](https://conversejs.org)] [also automatically provisioned by your aenigma instance if you choose to do so]

## Talks and keynotes

* [Linux day 2018 @ unixMIB Milano](https://docs.google.com/presentation/d/1p6nkmWOBJ7xcWOE6tZIKmgsmYoW353SCv27TAvqDRH8/edit?usp=sharing) [in italian]

* [35C3 @ ChaosZone stage](https://docs.google.com/presentation/d/1pkJ25XLQRr4dGqM7SpMwBXrXmlU8cv0Ip-yGEoucXRw/edit?usp=sharing) [in english]

## Credits

Very special thankyous to:

The [ProcessOne](https://process-one.net) team [and the community] for **[ejabberd](https://ejabberd.im)**

The [Tor project](https://torproject.org) team [and the community] for **[Tor](https://torproject.org)**

[JC Brand](https://github.com/jcbrand) [and the community] for **[Converse.js](https://github.com/conversejs/converse.js)**

**Torn [autistici.org]** for inspiring in me the idea of a federated messaging network.

**Gio [eigenlab / LibreMesh]** for leading me towards XMPP instead after talking about related projects.

**Palinuro + MiBoFra [frozenbox.org / parrotsec.org]** for actually getting me started on XMPP.

**Daniel Gultsch + Holger Weiß** for their excellent work and for their very precious advice and opinions about XMPP at large and its future.

The LUG **unixMIB** [Milano Bicocca university] for hosting my presentation on Linux Day 2018.

The hackerspace assembly **ChaosZone** for hosting my presentation at 35C3.

Also, anyone involved in the XMPP community, plus aenigma supporters, users, beta testers, and contributors of course!

Thanks to all of you. Let's make this happen. It's about time [finally].
