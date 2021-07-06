FROM centos:centos7
MAINTAINER  vitalii.kulbachenko@gmail.com



# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------

LABEL \
	name="vitaliikulbachenko" \
	image="centos7-mysql57" \
	vendor="centos7" \
	license="MIT" \
	build-date="2017-09-08"


# -----------------------------------------------------------------------------
# Mysql Install
# -----------------------------------------------------------------------------
# Install MySQL pre-requisites
RUN \
		yum -y install perl pwgen libpwqu libpwquality  openssl hostname && \
		yum clean all && \
		rm -fr /var/cache/*


RUN	\
		yum -y install https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm && \
		yum-config-manager --disable mysql5* && \
		yum-config-manager --enable mysql57-community && \
		yum-config-manager --disable mysql80-community && \
		yum -y install mysql-community-server && \
		yum clean all && \
		rm -rf /var/cache/*

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







