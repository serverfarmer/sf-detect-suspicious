#!/bin/sh
. /etc/farmconfig
. /opt/farm/scripts/functions.custom

file=`mktemp`
netstat -ap 2>/dev/null |grep ESTABLISHED |grep -v "ESTABLISHED -" |grep https |grep ec2 |egrep -v "(apache2|nginx)" |grep -vFf /etc/local/.config/allowed.netstat >$file
netstat -ap 2>/dev/null |grep ngrok |grep -vFf /etc/local/.config/allowed.netstat >>$file

ps aux |egrep -i "(btc|carbon|coin|devfee|ether|miner|mining|torrent|xmr|yam)" |grep -v "grep " |grep -vFf /etc/local/.config/allowed.processes >>$file

if [ -s $file ]; then
	cat $file |mail -s "Suspicious activity on host $HOST" unwanted-activities@`external_domain`
fi

rm -f $file
