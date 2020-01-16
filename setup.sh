#!/bin/sh

touch      /etc/local/.config/allowed.netstat /etc/local/.config/allowed.processes
chmod 0600 /etc/local/.config/allowed.netstat /etc/local/.config/allowed.processes

if [ -f /etc/image-id ] && grep -q ami-ecs /etc/image-id; then
	echo "skipping detect-suspicious configuration on Amazon ECS"
	exit 0
fi

if ! grep -q /opt/farm/ext/detect-suspicious/cron/check.sh /etc/crontab; then
	echo "setting up crontab entry"
	echo "*/5 * * * * root /opt/farm/ext/detect-suspicious/cron/check.sh" >>/etc/crontab
fi
