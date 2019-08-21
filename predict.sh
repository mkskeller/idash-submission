#!/bin/sh

if ! test "$1"; then
    echo "Usage: $0 <data>"
    exit 1
fi

prog=idash_predict
opts="-m old"

. `dirname $0`/common.sh

