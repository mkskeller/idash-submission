#!/bin/sh

if ! test "$1"; then
    echo "Usage: $0 <data>"
    exit 1
fi

params=`./predict_data.py $* || exit 1`
prog=idash_predict

. `dirname $0`/common.sh

