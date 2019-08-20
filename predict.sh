#!/bin/sh

if ! test "$1"; then
    echo "Usage: $0 <data>"
    exit 1
fi

params=`./predict_data.py $* || exit 1`

cd src
./Scripts/setup-ssl.sh || exit 1
./compile.py -D -R 64 idash_predict $params || exit 1

./Scripts/ring.sh idash_predict-`echo $params | sed 's/ /-/g'` -m old || exit 1
