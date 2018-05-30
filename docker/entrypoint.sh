#!/bin/sh

set -eu

cd /var/www/localhost/htdocs

while ! mysql -hdb -uroot -pwordpress -e 'select 1;' >/dev/null; do
    sleep 1
done

if [ -f index.html ]; then
    rm -f index.html
fi

if [ ! -f index.php ]; then
    wp core download
fi

if [ ! -f wp-config.php ]; then
    wp config create \
        --dbhost=db \
        --dbname=wordpress \
        --dbuser=wordpress \
        --dbpass=wordpress \
        --extra-php <<EOF
define('WP_SITEURL',
    isset(\$_SERVER['HTTP_HOST']) ?
    'http://' . \$_SERVER['HTTP_HOST'] :
    'http://phastpress.test'
);
define('WP_HOME', WP_SITEURL);
EOF
fi

wp core install \
    --url=http://phastpress.test \
    --title=PhastPress \
    --admin_user=admin \
    --admin_email=info@kiboit.com \
    --admin_password=admin

ln -sfn /data wp-content/plugins/phastpress
wp plugin activate phastpress

cd /
mkdir -p /run/apache2
exec httpd -D FOREGROUND -f /etc/apache2/httpd.conf
