#!/usr/bin/env bash

# QDUS -  QUICK DEPLOYMENT OF UNIX-LIKE SERVICES.

# Author:  Willy Romao Goncalves Franca -  (willyr.goncalves (a) gmail.com)
# Created: 2014-08-01
# License: GPLv2
# GitHub:  https://github.com/willyrgf/qdus


# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

DIR_FUNC="functions"

source $DIR_FUNC/verification.sh

_verifyUser

_verifyOS


