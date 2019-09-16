
host0=$1
host1=$2
host2=$3

for i in `seq 3`; do
    shift
done

. `dirname $0`/common-setup.sh

for host in $host0 $host1 $host2; do
    rsync -avR Player-Data/*.{pem,key,0} Programs $host:`pwd`
done

i=0
for host in $host0 $host1 $host2; do
    ssh $host "cd `pwd`; ./replicated-ring-party.x $name $opts -p $i -h $host0 -pn 5001" &
    i=$[i+1]
done

wait
