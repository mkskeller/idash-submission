#!/bin/sh

if ! test "$2"; then
    echo "Usage: $0 <normal data> <positive data>"
    exit 1
fi

mkdir src/Player-Data

prog=idash_train

. `dirname $0`/common.sh
