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
vendor=centos7

#----------------------------- CASE -------------------------------
ECHO_QUESTION -n \
"
***********************************************************
* 1  - Build :=> Mysql57
* 2  - Build :=> Nginx
* 3  - Build :=> Php-fpm 7.3
* 4  - Build :=> Php-fpm 7.4
* 5  - Build :=> MariaDB 10.5
***********************************************************
" \
"Choose installation option: => "

read DISTR
#--no-cache
  case $DISTR in
    build-1|1)            docker build -t $name/$vendor-mysql57 ./mysql ;;
    build-2|2)            docker build -t $name/$vendor-nginx ./nginx ;;
    build-3|3)            docker build --build-arg PHP_VERSION=73 -t $name/$vendor-php73-fpm ./php-fpm ;;
    build-4|4)            docker build --build-arg PHP_VERSION=74 -t $name/$vendor-php74-fpm ./php-fpm ;;
    build-5|5)            docker build -t $name/$vendor-mariadb10.5 ./mariadb/10.5 ;;


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
