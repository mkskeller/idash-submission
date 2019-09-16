#!/bin/bash

if ! test "$5"; then
    echo "Usage: $0 <host 0> <host 1> <host 2> <normal data> <positive data>"
    exit 1
fi

prog=idash_train

. ./common-remote.sh
