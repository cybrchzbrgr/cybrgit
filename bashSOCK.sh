#!/bin/bash

exec 8<>/dev/tcp/localhost/22
procid=$(ps -ef | grep -v grep | grep "sshd:" | awk '{print $2}')
echo PROCESS ID: $procid
echo PROCSS DIR: /proc/"$procid"/fd
echo PROCESS PERM: $(stat -c'%a' /proc/"$procid"/fd/5)
echo $(stat -c'%a' /proc/"$procid"/fd/5 | md5sum | awk '{print $1}')
echo
echo
echo
journalctl _COMM=sshd | tail -50
echo
echo
echo
cat /var/log/syslog | tail -50
echo
echo
echo
cat /var/log/auth.log | tail -50
