#!/bin/bash

## Funcao
# Executar o projeto em todos os servidores de teste.

_execute()
{
	ip="$1"
	comando="$2"

	ssh root@${ip} "$comando"
}

_update()
{
	ip="$1"

	scp -r /home/willy/Projetos/qdus/* root@${ip}:/root/qdus
}

ips=("192.168.7.211" "192.168.7.212")
comando="cd ~/qdus/; bash qdus.sh"

for (( i = 0; i < ${#ips[@]}; i++ ))
do
	_update "${ips[$i]}"
	_execute "${ips[$i]}" "$comando"
done
