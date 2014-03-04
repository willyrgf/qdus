#!/usr/bin/env bash

# QDUS -  QUICK DEPLOYMENT OF UNIX-LIKE SERVICES.

# Author:  Willy Romao Goncalves Franca -  (willyr.goncalves (a) gmail.com)
# Created: 2014-08-01
# License: GPLv2
# GitHub:  https://github.com/willyrgf/qdus

#############################################################################
# Nome do arquivo: verification.sh
# 
# Executa verificacoes primordiais para o funcionamento do programa.
#
#############################################################################

#############################################################################
# Nome da funcao: _checkUser()
# Verifica se o usuario que esta rodando o programa tem acesso root.
# Variaveis Globais:
# 	Nenhuma
# Argumentos:
# 	Nenhum
# Retornos:
# 	Nenhum
#############################################################################

_checkUser()
{
	if [[ $UID -ne 0 ]];then
		_err 'Voce precisa ter acesso root para executar este programa.\n'
		return 1
	fi
}

#############################################################################
# Nome da funcao: _checkOS()
# Verifica a distribuicao utilizada para rodar o programa.
# Variaveis Globais:
# 	Nenhuma
# Argumentos:
# 	Nenhum
# Retornos:
# 	$os
#############################################################################

_checkOS()
{
	os="$(cat /etc/issue |
		  head -n1 |
		  cut -f1 -d' ' |
		  tr A-Z a-z)"

	while read existingOS; do

		if [[ ${existingOS} = ${os} ]]; then
			export "$os"
			return 0
		fi

	done < <(ls $DIR_CONFIG)

	_err 'O sistema operacional/distribuicao utilizado nao eh suportado\n'
	_err 'pelo projeto QDUS.\n'
	return 1
}

#############################################################################
# Nome da funcao: _checkDependencies()
# Verifica as dependencias recebidas
# Variaveis Globais:
# 	nonPrograms
# Argumentos:
# 	As dependencias a serem checadas
# Retornos:
# 	$os
#############################################################################

_checkDependencies()
{

	# local programs=("dialog" "gcc" "grep")
	local programs=("$@")

	for program in ${programs[@]}; do
		_print "Verificando se o programa %s existe... " "$program"
		type -p $program 2>&1> /dev/null

		if [[ $? -ne 0 ]]; then
			_print "$COLOR_RED[NAO]$COLOR_RESET.\n"
			nonPrograms=("${nonPrograms[@]}" "$program")
		else
			_print "$COLOR_GREEN[SIM]$COLOR_RESET.\n"
		fi

	done

	export nonPrograms
}

#############################################################################
# Nome da funcao: _installDependencies()
# Tenta instalar as dependencias automaticamente
# Variaveis Globais:
# 	nonPrograms
#		packageManager
# Argumentos:
# 	Nenhum
# Retornos:
# 	0 ou 1
#############################################################################
_installDependencies()
{
	if [[ -e ${packageManager[0]} ]]; then
		trueOrFalse=0

		while [[ trueOrFalse -eq 0 ]]; do
			_print "Deseja instalar as dependencias automaticamente? (y/N): "
			read yN
			_print "\n"

			if [[ "${yN}" = "y" || "${yN}" = "N" ]]; then

				if [[ "${yN}" = "y" ]]; then

					for dependence in ${nonPrograms[@]}; do
						printf '%s %s %s\n' "${packageManager[@]}" "$dependence"
						"${packageManager[@]}" "$dependence"
						[[ $? -ne 0 ]] &&	_err "Nao foi possivel instalar $dependence.\n"; return 1
					done

				else
					_err "Resolva todas as dependecias para continuar a instalacao.\n"
					return 1
				fi

				trueOrFalse=1
			fi

		done
	else
		_err "Nao existe gerenciador de pacotes setado para sua distribuicao.\n"
		return 1
	fi
}
