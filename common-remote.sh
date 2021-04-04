
host0=$1
host1=$2
host2=$3
vm_port=$4
ssh_port=$5

for i in `seq 5`; do
    shift
done

. `dirname $0`/common-setup.sh

rm HOSTS

for host in $host0 $host1 $host2; do
    echo $host:$vm_port >> HOSTS
done


for host in $host1 $host2; do
    rsync -avR -e "ssh -p $ssh_port" HOSTS Player-Data/*.{pem,key,0} Programs $host:`pwd`
done

i=1
for host in $host1 $host2; do
    ssh -p $ssh_port $host "cd `pwd`; ./replicated-ring-party.x $name $opts -p $i -ip HOSTS" &
    i=$[i+1]
done

./replicated-ring-party.x $name $opts -p 0 -ip HOSTS
