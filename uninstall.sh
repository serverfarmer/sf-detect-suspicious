#!/bin/sh

if grep -q /opt/farm/ext/detect-suspicious/cron /etc/crontab; then
	sed -i -e "/\/opt\/farm\/ext\/detect-suspicious\/cron/d" /etc/crontab
fi
