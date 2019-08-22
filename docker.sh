#!/bin/bash

id=$1
path=/usr/mp-spdz/

for i in *.sh *.py *.md src; do
    dir=`dirname $path/$i`
    docker container exec $id mkdir -p $dir
    docker cp $i $id:$dir
done

docker exec $id rm -R $path/src/.git

docker cp src/static/replicated-ring-party.x $id:$path/src

docker exec $id apt update
docker exec $id apt install python openssl

docker save -o idash-mp-spdz.tar `docker commit $id`
