#!/bin/bash

set -e

mysql_uid=$(grep ^mysql /etc/passwd|cut -d: -f3)
mysql_gid=$(grep ^mysql /etc/group|cut -d: -f3)
read host_uid host_gid <<< $(ls -ndH /docker-entrypoint-initdb.d|awk '{print $3 " " $4}')
switch=0
[ "${host_uid}" -ne "${mysql_uid}" ] && switch=1
[ "${host_gid}" -ne "${mysql_gid}" ] && switch=1
if [ "${switch}" -eq 1 ]; then
    usermod -u "${host_uid}" mysql
    groupmod -g "${host_gid}" mysql
    find / -xdev -user "${mysql_uid}" -exec chown "${host_uid}" {} ';'
    find / -xdev -group "${mysql_uid}" -exec chgrp "${host_gid}" {} ';'
fi

exec docker-entrypoint.sh "$@"
