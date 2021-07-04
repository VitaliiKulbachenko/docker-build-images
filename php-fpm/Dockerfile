FROM centos:centos7

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------

LABEL \
        maintainer="Vitalii Kulbachenko <vitalii.kulbachenko@gmail.com>"

# -----------------------------------------------------------------------------
#  PHP-FPM ENV
# -----------------------------------------------------------------------------
ARG PHP_VERSION
ENV PHP_VERSION=${PHP_VERSION:-73}
ENV PHP_INI_FILE="/etc/opt/remi/php${PHP_VERSION}/php.ini"
ENV PHP_FPM_PATH="/etc/opt/remi/php${PHP_VERSION}/php-fpm.d"
# -----------------------------------------------------------------------------
#  PHP-FPM Install
# -----------------------------------------------------------------------------
RUN yum install -y yum-utils  epel-release && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    yum-config-manager --disable remi-php5* && \
    yum-config-manager --enable remi-php${PHP_VERSION} && \
    yum -y install php${PHP_VERSION}-php-fpm php${PHP_VERSION}-php-mysql php${PHP_VERSION}-php-redis php${PHP_VERSION}-php-apcu \
    php${PHP_VERSION}-php-xmlrpc php${PHP_VERSION}-php-curl php${PHP_VERSION}-php-pdo php${PHP_VERSION}-php-gd \
    php${PHP_VERSION}-php-ldap php${PHP_VERSION}-php-imap php${PHP_VERSION}-php-odbc php${PHP_VERSION}-php-pear \
    php${PHP_VERSION}-php-json php${PHP_VERSION}-php-mcrypt php${PHP_VERSION}-php-mbstring php${PHP_VERSION}-php-soap  \
    php${PHP_VERSION}-php-zip php${PHP_VERSION}-php-mysqlnd php${PHP_VERSION}-php-xml php${PHP_VERSION}-php-xmlrpc \
    php${PHP_VERSION}-php-opcache

# -----------------------------------------------------------------------------
#  PHP-FPM config
# -----------------------------------------------------------------------------

#COPY default.conf ${PHP_FPM_PATH}/default.conf

RUN sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Europe\/Kiev/g' ${PHP_INI_FILE} && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 3M/" ${PHP_INI_FILE} && \
    sed -i 's/^expose_php.*/expose_php = off/' ${PHP_INI_FILE} && \
    sed -i 's/^max_execution_time.*/max_execution_time = 300/' ${PHP_INI_FILE} && \
    sed -i 's/^max_input_time.*/max_input_time = 300/' ${PHP_INI_FILE} && \
    sed -i 's/expose_php.*/expose_php = Off/' ${PHP_INI_FILE}

RUN adduser --system --no-create-home --user-group -s /sbin/nologin nginx

EXPOSE 9000

CMD ["/opt/remi/php74/root/usr/sbin/php-fpm", "--daemonize"]
