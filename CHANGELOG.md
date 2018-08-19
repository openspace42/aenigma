# aenigma changelog

## v6.0.0

1. Completely restructured code. More neatly organized aenigma functions. More functions integrated into or sourced from dna.
2. Removed the 3 installation options in favour of a single option [formerly #1] that works for everyone.
2. Leverage the use of LetsEncrypt's new wildcard TLS certificates that works for every service we need.
3. Entirely new DNS checks now part of dna.
4. New DNS provider functionality [also part of dna] for automated DNS record configuration from the aforementioned DNS checks function.
5. aenigma is now clusterizable in a simple and straightforward fashion. Every new instance installed is ready to clusterized in the future from now on.

## [...]

## v0.47 [currently in beta - 2018-01-16]

1. Added testing mode for Ubuntu 17.10 [artful] [and therefore - currently - ejabberd 18.01 as per the repo we use] to prepare for Ubuntu 18.04 and ejabberd 18.xx:
1.1: Re-introduced per-ejabberd-version ejabberd.yml config files [falls back to v17.08 config file if ejabberd version being installed doesn't have a version-specific aenigma config file]
1.2: Enabled mod_push in ejabberd.yml for versions 18.01 and later
1.3: Requires user to place any external TLS certificate for $domain inside the aenigma /etc/ssl/aenigma TLS certificates folder as other arbitrary directories are blocked in newer versions.

2. Added use of git versioning following [EasyEngine-Backup-Restore](https://github.com/openspace42/EasyEngine-Backup-Restore). The old installer.sh is now called "setup" and the old installer-vx.yz is now simply called "install".

3. Added use of the "functions" file and [openspace Bash Functions](https://github.com/openspace42/bash-functions) to modularize and standardize everything we do across openspace projects.

4. Allowed APT to fail during installation up to the last step, where instead any errors are caught by the script as usual.
This way the installation can proceed until the end and possibly fix any errors causing APT to previously fail, and - if that doesn't work - at least the user can attempt to fix things manually once the installation is actually complete, before running it again and making everything go back to normal.


## v0.46 [2017-12-19]

1. Validate S3 connection details
2. Allow "bootstrap mode" to restore aenigma [and therefore source all previous settings] before running the installation on a new machine
3. Alert in case of reinstall and prompt for backup
4. Suggest adding CNAMES instead of A/AAAA records
5. Added error in case of LetsEncrypt failure
6. Added DPKG lock detection / waiting
7. Fixed and improved SRV records DNS checks
8. All bash code audited with ShellCheck
9. Improved backup / restore functionality by pulling the newest code from [easyengine-backup-restore](https://github.com/openspace42/easyengine-backup-restore)


## v0.45 [2017-11-18]

1. Changed installation directory to /root/openspace42/aenigma/
2. Build SSLH from source to use v1.18 [for ALPN functionality]
3. Added c2s listener on port 5223
4. Added LetsEncrypt TLS certificate generation for xu.$domain
5. Tunneled HTTP Uploads via SSLH on port 443 [at least until a better solution]
6. New "tools" directory with automated ejabberd backup/restore scripts with S3 options.
7. Nightly backup to local machine / S3 with backup script cron job.
8. Added admin email address setting for error notifications [backup failures, etc...]
9. Added incomplete install checker
