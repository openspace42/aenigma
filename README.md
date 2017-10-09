# aenigma-server

current version: v0.4 [2017-10-06 ~ ]

[for older versions edit the install.sh file before running `sudo bash [...]`]

## Features

* State of the art configuration
* Secure by default [see "non-features" for backwards compatibility exceptions]
* One touch deployment: install it in three minutes with two commands!
* Has a guided, step-by-step install that makes sure you get everything perfect on the first run
* Always based on the latest version of ejabberd, a modern, scalable, and robust XMPP server
* Passes all of the compliance checks performed by the Conversations client<sup>[1](###01)
* Passes all of the ejabberd-supported [XEP-0375 compliance checks](https://github.com/iNPUTmice/ComplianceTester)<sup>[2](###02)
* Automatically makes the ejabberd web admin interface available at https://[hostname]
* Easily allows for the website for your top level domain to be hosted on the same server as well
* Listens for c2s [aka client to server] connections *also* on port 443 [thanks to SSLH] to allow clients behind restrictive firewalls to connect without the need to circumvent the firewall with VPNs or Tor
* Natively supports Signal-level encrypted conversations with all the required modules for OMEMO E2EE

###### 01

Although Conversations says PEP [Avatars / OMEMO] is *not* supported, it actually is, and both work perfectly

###### 02



## Install on Debian 8 / Ubuntu 16

```git clone https://github.com/openspace42/aenigma-server.git```

```sudo bash ./aenigma-server/install.sh```

## Recommended client:

The one and only **conversations** [[github](https://github.com/siacs/Conversations)] [[f-droid](https://f-droid.org/packages/eu.siacs.conversations/)] [[website](https://conversations.im/)]

## Credits

Very special thankyous to:

Torn [autistici.org] for inspiring in me the idea of a federated messaging network

Gio [eigenlab / LibreMesh] for leading me towards XMPP instead after talking about related projects.

Palinuro + MiBoFra [frozenbox.org / parrotsec.org] for actually getting me started on XMPP.

David Gultsch + Holger Weiß for their excellent work and for their very precious advice and opinions about XMPP at large and its future.

Also, anyone involved in the XMPP community.

Thanks to all of you. Let's make this happen. It's about time [finally].
