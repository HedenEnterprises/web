#!/bin/bash

# for local testing, let's build the site as we do for the dockerfile
# but we'll create a test directory and populate it
# then we can spin up an nginx container and mount this test directory
# as /usr/share/nginx/html

basedir=$(dirname $(readlink -f $0))

if [ ! -d $basedir/html ] || [ ! -d $basedir/template ]; then
    echo "It looks as if you aren't running this script from the project root.."
    exit 1
fi


tdir=$basedir/template

rm -rf $basedir/test
cp -r $basedir/html $basedir/test

files=$(find $basedir/test -type f -name "*.html" -o -name "*.php" -path assets -prune)

for file in $files; do
    php $tdir/build.php --header=$tdir/header.php --footer=$tdir/footer.php --content=$file > $file.tmp
    mv $file.tmp $file
done

echo "$basedir/test directory has been populated.."

if ! docker ps >/dev/null 2>&1; then
    echo "Docker doesn't appear to be running.."
    exit 1
fi

# find a suitable port
port=80
while netstat -an | grep -q :$port; do
    port=$(( $port + 1 ))
done

if docker ps --all | grep -q heweb; then
    docker stop heweb
    docker rm heweb
fi

docker run --name heweb -v $basedir/test:/usr/share/nginx/html -d -p $port:80 nginx

echo "Container 'heweb' is running, routing container port 80 to localhost:$port"
echo "e.g.: Open your browser and point it to http://localhost:$port/"
