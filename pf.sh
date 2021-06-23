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
    echo "##### cache / optimizer / accelerator #####"
    echo "1: Start-LNMP"
    echo "2: Restart-LNMP"
    echo "3: Memcached"
    echo "4: opcache"
    echo "5: Redis"
    echo "6: apcu"
    echo "7: Install"
    echo "8: Unstall"
    echo "exit: Exit current script"
    echo "#####################################################"
    read -p "Enter your choice (1, 2, 3, 4, 5, 6, 7, 8 or exit): " action2
}



clear
echo "+------------------------------------------------------------------------+"
echo "|           PFinal script for LNMP V${LNMP_Ver}, Written by Licess             |"
echo "+------------------------------------------------------------------------+"
echo "|        A tool to auto-compile & install LNMP/LNMPA/LAMP on Linux       |"
echo "+------------------------------------------------------------------------+"
echo "|           For more information please visit                            |"
echo "+------------------------------------------------------------------------+"

if [[ "${action}" == "" || "${action2}" == "" ]]; then
    action='install'
    Display_Addons_Menu
fi