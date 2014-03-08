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
# Verifica o sistema operacional utilizada para rodar o programa.
# Variaveis Globais:
# 	Nenhuma
# Argumentos:
# 	Nenhum
# Retornos:
# 	$os
#############################################################################

_checkOS()
{
	os="$(uname | tr A-Z a-z)"

	if [[ "$os" = "freebsd" || "$os" = "linux" ]];then
		export "$os"
		return 0
	else
		_err 'O S.O. utilizado nao eh suportado pelo projeto QDUS.\n'
		return 1
	fi
}

#############################################################################
# Nome da funcao: _checkDistribution()
# Verifica a distribuicao utilizada para rodar o programa.
# Variaveis Globais:
# 	Nenhuma
# Argumentos:
# 	Nenhum
# Retornos:
# 	$dist
#############################################################################

_checkDistribution()
{
	if [[ "${os}" = linux ]];then
		dist="$(cat /etc/*release | # arquivo que contem o nome da distribuicao.
					 tr A-Z a-z | # troca de maiusculo para minusculo
					 grep -Eo $(ls $DIR_CONFIG | # grep alimentado pelo retorno do ls
					 					 	xargs | # tratamento para o sed
					 					 	sed 's/ /|/g') | # troca os espacos por pipe(OU p/ o grep).
					 head -n1)"

		if [[ -n "${dist}" ]]; then
			export "${dist}"
			return 0
		else
			_err 'A distribuicao utilizada nao eh suportado pelo projeto QDUS.\n'
			return 1
		fi
		
	else
		_err 'Nao ha distribuicao suportada para o seu S.O. pelo projeto QDUS.\n'
	fi

}

#############################################################################
# Nome da funcao: _checkDependencies()
# Verifica as dependencias recebidas
# Variaveis Globais:
# 	nonPrograms
# Argumentos:
# 	As dependencias a serem checadas
# Retornos:
# 	Mensagem na tela dizendo se existe ou nao a dependencia.
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

	# todas as dependencias nao instaladas
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
	# Se existe o diretorio do gerenciador de pacotes especificado.
	if [[ -e ${packageManager[0]} ]]; then
		# Flag utilizada para o while
		local trueOrFalse=0

		while [[ trueOrFalse -eq 0 ]]; do
			_print "Deseja instalar as dependencias automaticamente? (y/N): "
			# Entrada do usuario com y ou N.
			read yN
			_print "\n"

			# Se a entrada for y ou N
			if [[ "${yN}" = "y" || "${yN}" = "N" ]]; then

				# Se estiver digitado "y"
				if [[ "${yN}" = "y" ]]; then
					# For para percorrer o array que tem todas as dependencias.
					for dependence in ${nonPrograms[@]}; do
						printf '%s %s %s %s\n' "${packageManager[@]}" "$dependence"
						# ${packageManager[@]}: gerenciador de pacotes e
						# argumento de instalacao. (Veja em $DIR_CONFIG/$os/*.conf)
						# $dependence: dependencia a ser instalada.
						"${packageManager[@]}" "$dependence"

						if [[ $? -ne 0 ]]; then
							_err "Nao foi possivel instalar $dependence.\n"
							return 1
						fi

					done

				# Se estiver digitado "N"
				else
					_err "Resolva todas as dependecias para continuar a instalacao.\n"
					return 1
				fi

				# Saida do while
				trueOrFalse=1
			fi

		done

	else
		_err "Nao existe gerenciador de pacotes setado para sua distribuicao.\n"
		return 1
	fi
}
