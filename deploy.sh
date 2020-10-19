#!/bin/bash

# server to connect to
host=$1

# username on server to deploy to
user=$2

# site directory basename
basename=$3

env="stage"
prefix="staging-"

if [ "$4" = "prod" ]; then
    env="prod"
    prefix=""
fi

ts=$(date +%s)
dir="/home/${user}/web_deployment_${env}_${ts}"

ssh $user@$host "mkdir ${dir}"

# only copy php files from root dir over
pwd_files=$(find .  -maxdepth 1 -name "*.php")

for file in $pwd_files; do
    scp $file $user@$host:$dir
done

pwd_dirs=$(find . -maxdepth 1 -type d -not -path ./.git -not -path .)

for pwd_dir in $pwd_dirs; do
    scp -r $pwd_dir $user@$host:$dir
done

htmldir="/var/www/${prefix}${basename}/html"

ssh $user@$host "if [ -f ${htmldir}/assets/sensitive.php ]; then sudo chattr +i ${htmldir}/assets/sensitive.php; fi"
ssh $user@$host "sudo rm -r ${htmldir}/*"
ssh $user@$host "sudo cp -r ${dir}/* ${htmldir}/"
ssh $user@$host "sudo chattr -i ${htmldir}/assets/sensitive.php"
ssh $user@$host "sudo touch ${htmldir}/assets/sensitive.php"
ssh $user@$host "rm -r ${dir}"

./create-htaccess.sh
scp .htaccess "$user@$host:/home/${user}/htaccess_${env}_${ts}"
ssh $user@$host "sudo cp /etc/apache2/conf-available/heden-enterprises-hide-php-ext.conf /etc/apache2/conf-available/heden-enterprises-hide-php-ext.conf.bak_${ts}"
ssh $user@$host "sudo cp /home/${user}/htaccess_${env}_${ts} /etc/apache2/conf-available/heden-enterprises-hide-php-ext.conf"
ssh $user@$host "rm /home/${user}/htaccess_${env}_${ts}"

echo "Deployment to /var/www/${prefix}${basename}/html complete"
