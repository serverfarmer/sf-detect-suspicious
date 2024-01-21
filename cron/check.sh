#!/bin/sh
. /etc/farmconfig

file=`mktemp`
netstat -ap 2>/dev/null |grep ESTABLISHED |grep -v "ESTABLISHED -" |grep https |grep ec2 |egrep -v "(apache2|nginx)" |grep -vFf /etc/local/.config/allowed.netstat >$file
netstat -ap 2>/dev/null |grep ngrok |grep -vFf /etc/local/.config/allowed.netstat >>$file

ps aux |egrep -i "(btc|carbon|coin|devfee|ether|miner|mining|torrent|xmr|yam|kinsing|kdevtmpfsi|libsystem)" |grep -v "grep " |grep -v ttyAMA0 |grep -vFf /etc/local/.config/allowed.processes >>$file

if [ -s $file ]; then
	cat $file |mail -s "Suspicious activity on host $HOST" unwanted-activities@`/opt/farm/config/get-external-domain.sh`
fi

rm -f $file
