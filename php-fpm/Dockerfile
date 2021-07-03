FROM centos:centos7

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------

LABEL \
        maintainer="Vitalii Kulbachenko <vitalii.kulbachenko@gmail.com>"

# -----------------------------------------------------------------------------
#  PHP-FPM ENV
# -----------------------------------------------------------------------------
ENV PHP_VERSION=73 \
    PHP_INI_FILE_PATH="/etc/opt/remi/php"${PHP_VERSION}"/php.ini"

# -----------------------------------------------------------------------------
#  PHP-FPM Install
# -----------------------------------------------------------------------------
RUN yum install -y yum-utils  epel-release && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    yum-config-manager --disable remi-php5* && \
    yum-config-manager --enable remi-php"${PHP_VERSION}" && \
    yum -y install php${PHP_VERSION}-php-fpm php${PHP_VERSION}-php-mysql php${PHP_VERSION}-php-redis php${PHP_VERSION}-php-apcu \
    php${PHP_VERSION}-php-xmlrpc php${PHP_VERSION}-php-curl php${PHP_VERSION}-php-pdo php${PHP_VERSION}-php-gd \
    php${PHP_VERSION}-php-ldap php${PHP_VERSION}-php-imap php${PHP_VERSION}-php-odbc php${PHP_VERSION}-php-pear \
    php${PHP_VERSION}-php-json php${PHP_VERSION}-php-mcrypt php${PHP_VERSION}-php-mbstring php${PHP_VERSION}-php-soap  \
    php${PHP_VERSION}-php-zip php${PHP_VERSION}-php-mysqlnd php${PHP_VERSION}-php-xml php${PHP_VERSION}-php-xmlrpc \
    php${PHP_VERSION}-php-opcache

# -----------------------------------------------------------------------------
#  PHP-FPM config
# -----------------------------------------------------------------------------
RUN sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Europe\/Kiev/g' ${PHP_INI_FILE_PATH} && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 3M/" ${PHP_INI_FILE_PATH} && \
    sed -i 's/^expose_php.*/expose_php = off/' ${PHP_INI_FILE_PATH} && \
    sed -i 's/^max_execution_time.*/max_execution_time = 300/' ${PHP_INI_FILE_PATH} && \
    sed -i 's/^max_input_time.*/max_input_time = 300/' ${PHP_INI_FILE_PATH} && \
    sed -i 's/expose_php.*/expose_php = Off/' ${PHP_INI_FILE_PATH}

EXPOSE 9000
WORKDIR /var/www/html

CMD ["php${PHP_VERSION}-php-fpm", "-g", "daemon off;"]