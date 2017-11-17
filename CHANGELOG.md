# aenigma changelog

## v0.45

1. Changed installation directory to /root/openspace42/aenigma/
2. Build SSLH from source to use v1.18 [for ALPN functionality]
3. Added c2s listener on port 5223
4. Added LetsEncrypt TLS certificate generation for xu.$domain
5. Tunneled HTTP Uploads via SSLH on port 443 [at least until a better solution]
6. New "tools" directory with automated ejabberd backup/restore scripts with S3 options.
7. Nightly backup to local machine / S3 with backup script cron job.
8. Added admin email address setting for error notifications [backup failures, etc...]
9. Added incomplete install checker
