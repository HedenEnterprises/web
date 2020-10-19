#!/bin/bash

ts=$(date +%s)

function usage()
{
    echo ""
    echo "Usage:"
    echo "$0 <hostname> <user> <directory-basename> [stage|prod]"
    echo ""
    echo "stage is default deployment. if deploying to stage, then"
    echo "  'staging-' is prepended to directory-basename"
    echo ""
    exit 1
}

function cmd()
{
    command=$@
    echo "> $command"
    eval $command
}

if [ $# -lt 3 ]; then
    usage
fi

# server to connect to
host=$1

# username on server to deploy to
user=$2

# attempt to connect
connect_test=$(ssh ${user}@${host} "echo ping" 2>&1)
if [ "$connect_test" != "ping" ]; then
    echo "Unable to echo on ${user}@${host}"
    usage
fi

# site directory basename
basename=$3

env="stage"
prefix="staging-"

if [ "$4" = "prod" ]; then
    env="prod"
    prefix=""
fi

htmldir="/var/www/${prefix}${basename}/html"

dir_test=$(ssh ${user}@${host} "sudo touch ${htmldir}/test_${ts}" 2>&1 && echo "ping")
if [ "$dir_test" != "ping" ]; then
    echo "${htmldir} appears not to exist, or is incorrect"
    usage
fi

dir="/home/${user}/web_deployment_${env}_${ts}"

cmd ssh ${user}@${host} "mkdir ${dir}"

# only copy php files from root dir over
pwd_files=$(find .  -maxdepth 1 -name "*.php")

for file in $pwd_files; do
    cmd scp $file ${user}@${host}:$dir
done

pwd_dirs=$(find . -maxdepth 1 -type d -not -path ./.git -not -path .)

for pwd_dir in $pwd_dirs; do
    cmd scp -r $pwd_dir ${user}@${host}:$dir
done


cmd ssh ${user}@${host} "sudo cat ${htmldir}/assets/sensitive.php && sudo chattr +i ${htmldir}/assets/sensitive.php"
cmd ssh ${user}@${host} "sudo rm -r ${htmldir}/*"
cmd ssh ${user}@${host} "sudo cp -r ${dir}/* ${htmldir}/"
cmd ssh ${user}@${host} "sudo chattr -i ${htmldir}/assets/sensitive.php"
cmd ssh ${user}@${host} "sudo touch ${htmldir}/assets/sensitive.php"
cmd ssh ${user}@${host} "rm -r ${dir}"

echo "> generating new .htaccess (/etc/apache2/conf-available/heden-enterprises-hide-php-ext.conf"
./create-htaccess.sh

cmd scp .htaccess "${user}@${host}:/home/${user}/htaccess_${env}_${ts}"
cmd ssh ${user}@${host} "sudo cp /etc/apache2/conf-available/heden-enterprises-hide-php-ext.conf /etc/apache2/conf-available/heden-enterprises-hide-php-ext.conf.bak_${ts}"
cmd ssh ${user}@${host} "sudo cp /home/${user}/htaccess_${env}_${ts} /etc/apache2/conf-available/heden-enterprises-hide-php-ext.conf"
cmd ssh ${user}@${host} "rm /home/${user}/htaccess_${env}_${ts}"

cmd ssh ${user}@${host} "sudo systemctl restart apache2"

echo ""
echo ""
echo "Deployment to /var/www/${prefix}${basename}/html complete"
echo ""
echo ""
