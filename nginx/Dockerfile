FROM centos:centos7

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------

LABEL \
        maintainer="Vitalii Kulbachenko <vitalii.kulbachenko@gmail.com>"

# -----------------------------------------------------------------------------
#  Nginx Install
# -----------------------------------------------------------------------------

RUN 	yum -y install openssl hostname \
		yum clean all && \
		rm -rf /var/cache/* && \
        rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
	    yum -y install nginx && \
	 	mkdir  /tmp/fcgi-cache && \
	 	mkdir -p /etc/nginx && \
	 	rm -rf /etc/nginx/conf.d/*

COPY    nginx.conf /etc/nginx/nginx.conf
COPY	sites-available /etc/nginx/sites-available
COPY 	templates /etc/nginx/templates
COPY	www /var/www

RUN 	chown root:nginx /etc/nginx/nginx.conf; chmod 644 /etc/nginx/nginx.conf && \
	    chown -R root:nginx /etc/nginx/sites-available; chmod -R 644 /etc/nginx/sites-available/* && \
        chown -R root:nginx /etc/nginx/templates; chmod -R 644 /etc/nginx/templates/* && \
        chown -R root:nginx /var/www; chmod -R 755 /var/www && \
   	    chown -R nginx:nginx /tmp/fcgi-cache/ && \
	   	ln -s /etc/nginx/sites-available/default /etc/nginx/conf.d/default.conf

EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
