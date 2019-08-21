
cd src
./Scripts/setup-ssl.sh || exit 1

name=$prog-`echo $params | sed 's/ /-/g'`

if ! test -e Programs/Schedules/$name.sch; then
    ./compile.py -D -R 64 $prog $params || exit 1
fi

./Scripts/ring.sh $name -m old || exit 1
