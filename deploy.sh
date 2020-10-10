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

ssh $host "mkdir ${dir}"

# only copy php files from root dir over
pwd_files=$(find .  -maxdepth 1 -name "*.php")

for file in $pwd_files; do
    scp $file $host:$dir
done

pwd_dirs=$(find . -maxdepth 1 -type d -not -path ./.git -not -path .)

for pwd_dir in $pwd_dirs; do
    scp -r $pwd_dir $host:$dir
done

ssh $host "sudo rm -r /var/www/${prefix}${basename}/html/*"
ssh $host "sudo cp -r ${dir}/* /var/www/${prefix}${basename}/html/"
ssh $host "sudo touch /var/www/${prefix}${basename}/html/assets/sensitive.php"
ssh $host "rm -r ${dir}"

echo "Deployment to /var/www/${prefix}${basename}/html complete"
