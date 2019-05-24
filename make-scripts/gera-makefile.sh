#!/usr/local/bin/bash
# Copyright (C) 2019 Edson Brandi <ebrandi@FreeBSD.org>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
# OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

# Generate the Makefile that are needed for the build processyy

case "$1" in
        1|2|3|4|5|6|7|8|9)
          echo "# \$FreeBSD\$" > ./man$1/pt_BR/Makefile
          echo >> ./man$1/pt_BR/Makefile
          echo "MAN$1= \\" >> ./man$1/pt_BR/Makefile
          for i in `find . -name "*.$1" -print | awk -F "./" '{print $NF}'`
            do
              echo "      $i \\" >> ./man$1/pt_BR/Makefile
            done
          echo >> ./man$1/pt_BR/Makefile
          echo >> ./man$1/pt_BR/Makefile
          echo ".include <bsd.prog.mk>" >> ./man$1/pt_BR/Makefile 
	  echo "Makefile generated!"
        ;;

        *)
            echo "Usage: $0 {1|2|3|4|5|6|7|8|9}"
            exit 1
        ;;

esac
