FROM centos:centos7

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------
LABEL \
        maintainer="Vitalii Kulbachenko <vitalii.kulbachenko@gmail.com>"

# -----------------------------------------------------------------------------
#  Nginx Install
# -----------------------------------------------------------------------------
RUN yum -y install openssl hostname \
		yum clean all && \
		rm -rf /var/cache/* && \
    rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
	  yum -y install nginx && \
    yum clean all && \
    rm -rf /var/cache/yum

# -----------------------------------------------------------------------------
#  Nginx Config
# -----------------------------------------------------------------------------
RUN	mkdir  /tmp/fcgi-cache && \
	 	mkdir -p /etc/nginx && \
	 	rm -rf /etc/nginx/conf.d/*

RUN chown root:nginx /etc/nginx/nginx.conf; chmod 644 /etc/nginx/nginx.conf && \
	  chown -R root:nginx /etc/nginx/sites-available; chmod -R 644 /etc/nginx/sites-available/* && \
    chown -R root:nginx /etc/nginx/templates; chmod -R 644 /etc/nginx/templates/* && \
    chown -R root:nginx /var/www; chmod -R 755 /var/www && \
   	chown -R nginx:nginx /tmp/fcgi-cache/ && \
	  ln -s /etc/nginx/sites-available/default /etc/nginx/conf.d/default.conf

EXPOSE 80/tcp 443/tcp

STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
