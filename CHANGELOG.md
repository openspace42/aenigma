# aenigma changelog


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
