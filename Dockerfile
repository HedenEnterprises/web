FROM nginx

WORKDIR /usr/share/nginx/html

COPY [ "html/" , "." ]
COPY [ "template/" , "/usr/share/nginx/html" ]

RUN \
    echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections && \
    apt-get update -y && \
    apt-get install -y php-cli && \
    files=$(find . -type f -name "*.html" -o -name "*.php" -path assets -prune) && \
    for file in $files; do \
        php build.php --header=header.php --footer=footer.php --content=$file; \
        php build.php --header=header.php --footer=footer.php --content=$file > $file.tmp; \
        mv $file.tmp $file; \
    done && \
    rm /usr/share/nginx/html/build.php && \
    rm /usr/share/nginx/html/header.php && \
    rm /usr/share/nginx/html/footer.php && \
    apt-get remove --purge -y php-cli && \
    apt-get autoremove -y
