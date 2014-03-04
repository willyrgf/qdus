#!/bin/bash

## Funcao
# Executar o projeto em todos os servidores de teste.

ips=("192.168.7.211" "192.168.7.212")
# comando="ps aux | grep -v grep | grep qdus | awk '{ print $2 }' | xargs kill -9; cd ~/qdus/; bash qdus"
comando="cd ~/qdus/; bash qdus"
reme="rm -rf /root/qdus"

_execute()
{
	ip="$1"
	local execute="$2"

	ssh root@${ip} "$execute"
}

_update()
{
	ip="$1"
	scp -r /home/willy/Projetos/qdus/ root@${ip}:/root/  >> /dev/null
}

# comando="cd ~/qdus/; cat /etc/issue | grep [0-9]"

for (( i = 0; i < ${#ips[@]}; i++ ))
do
	_execute "${ips[$i]}" "$reme"
	_update "${ips[$i]}"
	echo -e "\nExecutando no ip: ${ips[$i]}"
	_execute "${ips[$i]}" "$comando"
done
