#!/bin/bash

# find all php files, get rid of the prepended "./", then get rid of everything in assets and template directories
# then get rid of the php extension
files=$(find . -name "*.php" | sed 's|^./||' | grep -v "^assets" | grep -v "^template" | sed 's|\.php$||')

echo "RewriteEngine On" > .htaccess

for file in $files; do
    echo "RewriteRule /${file}\$ /${file}.php [L]" >> .htaccess
done
