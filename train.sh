#!/bin/sh

if ! test "$2"; then
    echo "Usage: $0 <normal data> <positive data>"
    exit 1
fi

params=`./train_data.py $* || exit 1`

cd src
./Scripts/setup-ssl.sh || exit 1
./compile.py -D -R 64 idash_train $params || exit 1

./Scripts/ring.sh idash_train-`echo $params | sed 's/ /-/g'` || exit 1
