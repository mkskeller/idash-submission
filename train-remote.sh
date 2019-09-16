#!/bin/bash

if ! test "$5"; then
    echo "Usage: $0 <host 0> <host 1> <host 2> <normal data> <positive data>"
    exit 1
fi

host0=$1
host1=$2
host2=$3

for i in `seq 3`; do
    shift
done

mkdir src/Player-Data

prog=idash_train

. `dirname $0`/common-setup.sh

for host in $host1 $host2; do
    rsync -av Player-Data Programs $host:`pwd`
done

i=0
pn=$[RANDOM+1024]
for host in $host0 $host1 $host2; do
    ssh $host "cd `pwd`; ./replicated-ring-party.x $name -p $i -h $host0 -pn $pn" &
    i=$[i+1]
done

wait
