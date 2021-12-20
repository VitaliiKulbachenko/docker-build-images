#!/usr/bin/env bash
#------------------------------
# Define some global variables.
# ------------------------------
tmprootdir="$(dirname $0)"
echo ${tmprootdir} | grep '^/' >/dev/null 2>&1
if [ X"$?" == X"0" ]; then
  export ROOTDIR="${tmprootdir}"
else
  export ROOTDIR="$(pwd)"
fi

cd ${ROOTDIR}

ECHO_QUESTION()
{
    if [ X"$1" == X"-n" ]; then
        shift 1
        echo -ne "${_QUESTION_FLAG} $@"
    else
        echo -e "${_QUESTION_FLAG} $@"
    fi
}

ask_confirm()
{
    # Usage: ask_confirm 'prompt text'
    prompt_text="${1}"
    echo -ne "${prompt_text} [y|N]"
    read ANSWER
    case ${ANSWER} in
        Y|y ) : ;;
        N|n|* ) return 1 ;;
    esac
}



clear
cat <<EOF

***********************************************************
* Start  Build Docker Images
***********************************************************
EOF

# Variables
name=vitaliikulbachenko
vendor1=centos7
vendor2=alpine

#----------------------------- CASE -------------------------------
ECHO_QUESTION -n \
"
***********************************************************
* 1.1  - Build :=> Nginx
* 1.2  - Build :=> Nginx 1.20 :alpine 3.15
* 1  - Build :=> Mysql57
* 3  - Build :=> Php-fpm 7.3
* 4  - Build :=> Php-fpm 7.4
* 5.1  - Build :=> MariaDB 10.5 :centos7
* 5.2  - Build :=> MariaDB 10.6 :centos7
* 6.1  - Build :=> Dnsmasq :alpine
***********************************************************
" \
"Choose installation option: => "

read DISTR
  case $DISTR in
    build-1.1|1.1)        time docker build -t $name/nginx-$vendor1 ./nginx ;;
    build-1.2|1.2)        time docker build -t $name/nginx-1.20-$vendor2 -f ./nginx/Dockerfile.alpine ./nginx;;
    
    build-3|3)            time docker build --build-arg PHP_VERSION=73 -t $name/php73-fpm-$vendor1 ./php-fpm ;;
    build-4|4)            time docker build --build-arg PHP_VERSION=74 -t $name/php74-fpm-$vendor1 ./php-fpm ;;
     
    build-1|1)            time docker build -t $name/mysql57-$vendor1 ./mysql ;;

    build-5.1|5.1)        time docker build -t $name/mariadb10.5-$vendor1 ./mariadb/10.5 ;;
    build-5.1|5.2)        time docker build --build-arg MARIADB_VERSION=10.6 -t $name/mariadb10.6-$vendor1 -f ./mariadb/10.6/Dockerfile.centos7 ./mariadb/10.6;;

    build-6.1|6.1)        time docker build -t $name/dnsmasq-$vendor1 -f ./dnsmasq/Dockerfile.centos7 ./dnsmasq;;
    build-6.2|6.2)        time docker build -t $name/dnsmasq-$vendor2 -f ./dnsmasq/Dockerfile.alpine ./dnsmasq;;

     *)
          echo "Goodbye my friend."
          ;;
esac





#if ask_confirm  " Build :=> Mysql57"
#    then
#    docker build -t $name/$vendor-mysql57 ./mysql
#    clear
#fi

#if ask_confirm  " Build :=> Nginx"
#    then
#    docker build -t $name/$vendor-nginx ./nginx
#    clear
#fi
