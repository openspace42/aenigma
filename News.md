# News posts archive

Follow our development updates together with the aenigma community on our chatroom at [aenigma@xc.aenigma.xyz](xmpp:aenigma@xc.aenigma.xyz).

If you have an operational aenigma server, definitely subscribe for new release notifications and other important heads-up alerts.

### 2019-06-11 | v0.7.1 beta release

```
Hi there!

aenigma v0.7.1-beta.1 is out with the following improvements:

- NGINX-handled ejabberd uploads. This is another feature [after the PostgreSQL database integration in the previous release] that is highly recommended by the ejabberd team and which brings the robustness of this feature to a new level.
- the new set_mam_disabled function, which - especially when combined with set_loglevel_zero - further turns your server's "stealth mode" on, limiting the amount of user data stored onto it, which is a good idea if you believe your server might be compromised or seized in the future.
- removed mod_echo as it's deprecated
- refined nginx websocket revproxy config for .onion version of converse.js
- enable mod_proxy65 for continued 100% compliance with caas
- enabled an option in synthia+dna to install the project from a custom git branch on origin
- stability and notable speed improvements when reclustering PostgreSQL
- very many bugfixes and general retouches

aenigma v0.7.1 will also ship with dna v0.3.14 which fixes a couple of small issues.

As always, you can test out this specific beta with:

aenigma-upgrade -dt -pt

or try out the latest bleeding_edge version up to HEAD with:

aenigma-upgrade -db -pb

or simply wait for this stable release to be published - after which you'll be able to upgrade normally with:

aenigma-upgrade

Thanks for following our project and please consider becoming a supporter if you're finding it interesting, useful, or both!

Nz
```

### 2019-06-05 | v0.7.0 stable release

```
Hi all!

aenigma v0.7.0 is out with full postgresql single / cluster support

you can finally upgrade with "aenigma-upgrade". there are also several improvements:

- every aenigma node can now resolve .onion domains and route them correctly through tor so that aurora@abcd01.onion can speak to ilena@abcd02.onion on completely separate servers, entirely via Tor [c2s, s2s, c2s].
- the new loglevel_zero function will make your server not store any user connection / disconnection traffic data to limit the amount of data leaked in the event the server were compromised or seized in the future
- converse.js now uses websocket connection to ejabberd rather than bosh, for a very notable speed improvement. converse.js accessed via .onion domain from tor will now use .onion websocket endpoint to conceal the clearnet domain used on that machine.

This release also ships with dna v0.3.13 with a bunch of fixes and improvements, and the following new functions:

- provision_self_signed_wildcard_cert
- nginx_increase_names_hash_bucket_size_128
- check_s3_connection

Locale setting was also completely re-written.

A release of v0.7.1 will bring ejabberd uploads handled by nginx, improvements in loglevel_zero function, and more small improvements, and that should come out in about a week.

Nz
```
