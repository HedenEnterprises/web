#!/bin/bash

rc=0
dirs=$(find . -type d | grep -v "\.git")

for dir in $dirs; do
    pushd $dir

    phpfiles=$(find . -maxdepth 1 -name "*.php")
    for file in $phpfiles; do
        echo "> checking file ($file)"
        php $file &>/dev/null
        file_rc=$?

        if [ $file_rc -ne 0 ]; then
            echo "!! error ($file_rc)"
            rc=$(( $rc + $file_rc ))
        fi
    done
    popd
done

exit $rc
