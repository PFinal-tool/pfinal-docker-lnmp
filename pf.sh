#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

Stack=$1
if [ "${Stack}" = "" ]; then
    Stack="lnmp"
else
    Stack=$1
fi

LNMP_Ver='1.0'

cur_dir=$(pwd)

action=$1


Display_Addons_Menu()
{
    echo "##### Menu #####"
    echo "1: Start-LNMP"
    echo "2: Restart-LNMP"
    echo "3: Stop-LNMP"
    echo "4: opcache"
    echo "5: Redis"
    echo "6: apcu"
    echo "7: Install"
    echo "8: Unstall"
    echo "exit: Exit current script"
    echo "#####################################################"
    read -p "Enter your choice (1, 2, 3, 4, 5, 6, 7, 8 or exit): " action
}

Check_Docker()
{
   # 检测是否安装Docker
   if ! type docker >/dev/null 2>&1; then
        echo 'docker 未安装';
        exit
   fi
}


clear
echo "+------------------------------------------------------------------------+"
echo "|           PFinal script for LNMP V${LNMP_Ver}, Written by Licess             |"
echo "+------------------------------------------------------------------------+"
echo "|        A tool to auto-compile & install LNMP/LNMPA/LAMP on Linux       |"
echo "+------------------------------------------------------------------------+"
echo "|           For more information please visit                            |"
echo "+------------------------------------------------------------------------+"

if ["${action}" == ""]; then
    action='install'
    Display_Addons_Menu
fi
case "${action}" in
            1)
                Check_Docker
                echo "Start LNMP For Docker:"
                ES_UID=$(id -u):$(id -g) docker-compose start
                ;;
            2)
                Check_Docker
                echo "ReStart LNMP For Docker:"
                ES_UID=$(id -u):$(id -g) docker-compose restart
                ;;
            3)
                Check_Docker
                echo "Stop LNMP For Docker:"
                ES_UID=$(id -u):$(id -g) docker-compose stop
                ;;
esac

