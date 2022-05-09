#/bin/bash

exchangelist="API aspnet_client autodiscover ews MAPI Microsoft-Server-ActiveSync OAB OMA owa PowerShell rpc"

while getopts t:h-o flag
do
	case "$flag" in
	t) host=${OPTARG};;
	h) echo "usage: -t your.target.com. output is sent to file in this dir ending in .nmap.ntlm.txt" ;;
	esac
done

for i in $exchangelist; do
	touch $host.nmap.ntlm.txt
	exec >> $host.nmap.ntlm.txt 2>&1
	echo "checking... $i"
	nmap -p443 --script=http-ntlm-info --script-args=http-ntlm-info.root=/$i/ $host
done
