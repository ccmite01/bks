#!/bin/bash
if [ ! -d /var/spool/cron/crontabs ]
    then
    mkdir -p /var/spool/cron/crontabs
    chown root:crontab /var/spool/cron/crontabs
    chmod 1730 /var/spool/cron/crontabs
fi

if [ ! -e /var/spool/cron/crontabs/root ]
    then
    touch /var/spool/cron/crontabs/root
    chown root:crontab /var/spool/cron/crontabs/root
    chmod 600 /var/spool/cron/crontabs/root
    echo '# Min Hour Day Month DayOfWeek Command' > /var/spool/cron/crontabs/root
    echo '59 5 * * * /var/spool/cron/stop.sh > /var/spool/cron/log/stop.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '10 6 * * * /var/spool/cron/tar.sh > /var/spool/cron/log/tar.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '0 7 * * * /var/spool/cron/start.sh > /var/spool/cron/log/start.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '30 7 * * * /var/spool/cron/purge.sh > /var/spool/cron/log/purge.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '* * * * * /var/spool/cron/test.sh > /var/spool/cron/log/test.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '#!/bin/sh' > /var/spool/cron/test.sh
    echo 'echo "test run."' >> /var/spool/cron/test.sh
fi

if [ ! -e /var/spool/cron/stop.sh ]
    then
    touch /var/spool/cron/stop.sh
    chmod 700 /var/spool/cron/stop.sh
fi

if [ ! -e /var/spool/cron/tar.sh ]
    then
    touch /var/spool/cron/tar.sh
    chmod 700 /var/spool/cron/tar.sh
fi

if [ ! -e /var/spool/cron/start.sh ]
    then
    touch /var/spool/cron/start.sh
    chmod 700 /var/spool/cron/start.sh
fi

if [ ! -e /var/spool/cron/purge.sh ]
    then
    touch /var/spool/cron/purge.sh
    chmod 700 /var/spool/cron/purge.sh
fi

if [ ! -d /var/spool/cron/.ssh ]
    then
    mkdir -p /var/spool/cron/.ssh
    chmod 700 /var/spool/cron/.ssh
    chown root:root /var/spool/cron/.ssh/known_hosts
    chown root:root /var/spool/cron/.ssh/id_rsa
    chmod 600 /var/spool/cron/.ssh/known_hosts
    chmod 600 /var/spool/cron/.ssh/id_rsa
fi

cron -l 2 -f

