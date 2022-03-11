#! /bin/bash

input_dir=$1
output_dir=$2
acrhive=$3

input_dir_s=$2
output_dir_s=$3
acrhive_s=$4


#Основная функция скрипта
Run()
{
    files=$(find $input_dir | wc -l)
    dirs=$(find $input_dir -type d | wc -l)
    memory=$(du -s --block-size=KB $input_dir | cut -f1)

    echo "$dirs dirs, $files files, $memory"
    for file in `find $input_dir`; do 
        cp --backup=t $file $output_dir &>/dev/null
    done

    cd $output_dir
    tar -cf $acrhive.zip ./ &>/dev/null 
}


#Скрипт без вывода в консоль
Silent()
{
    for file in `find $input_dir_s`; do 
        cp --backup=t $file $output_dir_s &>/dev/null
    done

    cd $output_dir_s
    tar -cf $acrhive_s.zip ./ &>/dev/null
}

Help()
{  
   echo
   echo
   echo "Скрипт копирует файлы и создает архив"
   echo
   echo "Артументы задаются ./script_name [-s/-h] input_dir output_dir archive_name"
   echo
   echo "[-s] - Выполнить скрипт без вывода чего-либо в консоль"
   echo
   echo "[-h] - Открыть помощь по скрипту (Это окно)"
   echo
   echo
}

#Опции скрипта
while getopts ":hs:" option
do
    case $option in
        h) Help
           exit;;
        s) Silent
           exit;;
    esac
done


Run