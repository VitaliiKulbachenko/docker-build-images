FROM centos:centos7
MAINTAINER  vitalii.kulbachenko@gmail.com

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------
LABEL \
        maintainer="Vitalii Kulbachenko <vitalii.kulbachenko@gmail.com>"

# -----------------------------------------------------------------------------
# ENV
# -----------------------------------------------------------------------------
ENV MARIADB_VERSION=10.5

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
# Install MySQL pre-requisites
RUN { \
      echo '[mariadb]'; \
      echo 'name = MariaDB'; \
      echo "baseurl = http://yum.mariadb.org/$MARIADB_VERSION/centos7-amd64"; \
      echo 'gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB'; \
      echo 'gpgcheck=1'; \
    } > /etc/yum.repos.d/mariadb.repo

RUN \
    yum install -y epel-release && \
    yum install -y pwgen MariaDB-server MariaDB-client && \
		yum clean all && \
		rm -fr /var/cache/*

# -----------------------------------------------------------------------------
# Config
# -----------------------------------------------------------------------------
RUN	\
		rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld && \
		chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
		chmod 777 /var/run/mysqld

ADD my.cnf /etc/my.cnf

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
