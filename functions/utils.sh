#!/usr/bin/env bash

# QDUS -  QUICK DEPLOYMENT OF UNIX-LIKE SERVICES.

# Author:  Willy Romao Goncalves Franca -  (willyr.goncalves (a) gmail.com)
# Created: 2014-08-01
# License: GPLv2
# GitHub:  https://github.com/willyrgf/qdus

#############################################################################
# Nome do arquivo: utils.sh
# 
# Possui funcoes utilitarias e para melhor padronizacao do programa.
#
#############################################################################


#############################################################################
# Nome da funcao: _print()
# Imprime na tela formatando o texto.
# Variaveis Globais:
#   Nenhuma
# Argumentos:
#   Mensagem a ser impressa na tela
# Retornos:
#   Nenhum
#############################################################################

_print()
{
  printf "$@"
}

#############################################################################
# Nome da funcao: _err()
# Imprime na stderr o erro.
# Variaveis Globais:
#   Nenhuma
# Argumentos:
#   Mensagem a ser enviada a stderr
# Retornos:
#   Nenhum
#############################################################################
_err()
{
  printf "[$(date +'%Y-%m-%d %H:%M:%S')]: $@" >&2
}
