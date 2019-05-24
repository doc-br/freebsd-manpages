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

case "$1" in
        convert)
		# Search for man files under /usr/src and convert it to .po file using po4a tool
            for manfile in `find /usr/src -name "*.[1-9]" -print | grep -v tests`
              do
                potfile=`echo $manfile | awk -F"/" '{print $NF}'`
                mansection=`echo $manfile | awk -F"." '{print $NF}'`
                echo "Converting $potfile -> $potfile.pot"
                po4a-gettextize -M utf8 -f man -m $manfile -p ./man$mansection/$potfile.pot
              done
            ;;

        translate)
		# Search for translated .po files under actual directory and convert it back to mdoc format using po4a tool
			for manfile in `find ./ -name "*.po" -print`
              do
                pofile=`echo $manfile | awk -F"/" '{print $NF}'`
                man=`echo $pofile | awk -F".po" '{print $1}'`
                original=`find /usr/src -name $man -print`
                mansection=`echo $original | awk -F"." '{print $NF}'`
                echo "Converting $pofile -> $man"
                po4a-translate -M UTF-8 -L UTF-8 -f man -m $original -p $manfile -l man$mansection/pt_BR/$man
              done
            ;;

        update)
		# Search for .po files under actual directory and updated it from the original using po4a tool
			for manfile in `find ./ -name "*.po" -print`
              do
                pofile=`echo $manfile | awk -F"/" '{print $NF}'`
                man=`echo $pofile | awk -F".po" '{print $1}'`
                original=`find /usr/src -name $man -print`
                echo "Updating $man -> $pofile"
                po4a-updatepo -M UTF-8 -f man -m $original -p $manfile
              done
            ;;
                *)
            echo $"Usage: $0 {convert|translate|update}"
            exit 1

esac
