#!/usr/bin/env bash

# QDUS -  QUICK DEPLOYMENT OF UNIX-LIKE SERVICES.

# Author:  Willy Romao Goncalves Franca -  (willyr.goncalves (a) gmail.com)
# Created: 2014-08-01
# License: GPLv2
# GitHub:  https://github.com/willyrgf/qdus


#############################################################################
# Nome do arquivo: menu.sh
#
# Monta os menu's utilizados no projeto.
#
#############################################################################

#############################################################################
# Nome da funcao: _opening
# Menu principal do projeto.
# Variaveis Globais:
# 	Nenhuma
# Argumentos:
# 	Nenhum
# Retornos:
# 	Nenhum
#############################################################################

_opening(){
  clear
  cat <<EOT

         .d88888b. 8888888b. 888     888 .d8888b.  
        d88P" "Y88b888  "Y88b888     888d88P  Y88b 
        888     888888    888888     888Y88b.      
        888     888888    888888     888 "Y888b.   
        888     888888    888888     888    "Y88b. 
        888 Y8b 888888    888888     888      "888 
        Y88b.Y8b88P888  .d88PY88b. .d88PY88b  d88P 
         "Y888888" 8888888P"  "Y88888P"  "Y8888P"  
               Y8b                                

EOT
  printf "\tQUICK  DEPLOYMENT  OF  UNIX-LIKE  SERVICES\n\n"
  return 0
}

#############################################################################
# Nome da funcao: _mainMenu
# Menu principal do projeto.
# Variaveis Globais:
# 	Nenhuma
# Argumentos:
# 	Nenhum
# Retornos:
# 	Nenhum
#############################################################################

#_mainMenu(){
#
#}
