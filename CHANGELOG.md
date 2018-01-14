# aenigma changelog

## v0.47 [currently in beta]

1. Added testing mode for Ubuntu 17.04 [and therefore - currently - ejabberd 17.12 as per the repo we use] to prepare for Ubuntu 18.04 and ejabberd 18.xx:
1.1: Re-introduced per-ejabberd-version ejabberd.yml config files [falls back to v17.08 config file if ejabberd version being installed doesn't have a version-specific aenigma config file]
1.2: Enabled mod_push in ejabberd.yml for versions 17.12 and later
1.3: Requires user to place any external TLS certificate for $domain inside the aenigma /etc/ssl/aenigma TLS certificates folder as other arbitrary directories are blocked in newer versions.
1.4: [under developement...]

2. Allow APT to fail during installation up to the last step in the installation, where instead any errors are catched by the script.
This way the installation can proceed until the end and possibly fix any errors causing APT to previously fail, and - if not - at least the user can attempt to fix things manually once the installation is actually complete, before running it again and making everything go back to normal.


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
