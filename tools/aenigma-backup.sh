#!/bin/bash

# All in One Bash Logger | v0.45 | 20171018 | 20171107 | Nk

logname=`basename "$0"`                                   # The name of this script
now="$(date +"%Y-%m-%d_%H-%M-%S")"                        # The current timestamp
logdir="/root/logs/$logname"                              # Don't store anything else than logs in here!
logfile="$logdir/$now"                                    # The new logfile
mkdir -p $logdir                                          # Touch the dir
touch $logfile                                            # Touch the file
rm $logdir/latest-log 2> /dev/null                        # Remove the old latest-log symlink
ln -s $logfile $logdir/latest-log                         # Recreate the symlink
( cd $logdir && rm `ls -t | awk 'NR>43'` ) 2> /dev/null   # Delete all logs older than the newest 42
exec >  >(tee -ia $logfile)                               # Log one output to logfile
exec 2> >(tee -ia $logfile >&2)                           # Log the other output to logfile

basedir=/root/openspace42 # Don't change! | No trailing slash!
installdir=$basedir/aenigma # Don't change! | No trailing slash!
backupsdir=$installdir/backups # Don't change! | No trailing slash!

mkdir -p $backupsdir

/usr/sbin/ejabberdctl backup /tmp/ejabberd-backup-$now
mv /tmp/ejabberd-backup-$now $backupsdir/
