#!/bin/bash

ipandserv=$(for i in $(cat NMAP_all_hosts.txt | grep -e "open" -e "Nmap scan" | grep -v Warning)
	do echo $i; done | egrep -v "tcp|open|Nmap|scan|report|for")

for x in $ipandserv; do
	if [[  "$x" =~ ^[0-9]{1,3} ]]; then
		printf '\n%s\t' $x;
	else printf '%s+' $x;
	fi
done > ip2serv.txt

echo "SERVICES SUMMARY"
echo "================"
cat NMAP_all_hosts.txt | grep -e "open" | grep -v Warning | awk '{print $3}' | sort | uniq -c
echo

servs=$(cat NMAP_all_hosts.txt | grep -e "open" | grep -v Warning | awk '{print $3}' | sort | uniq)
#echo $servs
#sleep 20

for s in $servs; do
	c=$(grep "$s+" ip2serv.txt | wc -l | awk '{print $1}')
	echo "$c IP(s) running $s"
	echo "================"
	grep "$s+" ip2serv.txt | awk '{print $1}'
	echo
done

rm -f ip2serv.txt
