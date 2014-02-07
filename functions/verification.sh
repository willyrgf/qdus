#!/usr/bin/env bash

_verifyUser()
{
	if test $UID -ne 0
	then
		printf '\nYou need access root for execute program.'
	fi
}

_verifyOS()
{
	local os="`cat /etc/issue | head -n1 | cut -f1 -d' ' | tr A-Z a-z`"
	case "$os" in
		debian )
			printf 'debian\n';;
		centos )
			printf 'centos\n';;

	esac
}