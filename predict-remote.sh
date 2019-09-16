#!/bin/bash

if ! test "$4"; then
    echo "Usage: $0 <host 0> <host 1> <host 2> <data>"
    exit 1
fi

prog=idash_predict
opts="-m old"

. $root/common-remote.sh
