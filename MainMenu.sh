                    #Bash shell script Database Management system

#! /bin/bash

#Main Menu:
#- Create Database
#- List Databases
#- Connect To Databases
#- Drop Database

#The base directory for DBMS:
  BASE_DIR=$(pwd)

main_menu() { 
    while true ; do
        echo "---Main Menu---"
        echo "1- Create Database"
        echo "2- List Databases"
        echo "3- Connect To Database"
        echo "4- Drop Database"
        echo "5- Exit"
        echo "--------------"

        read -p "Choose What you want to do: " option

        option2=$(echo "$option" | tr '[:upper:]'  '[:lower:]')

        case "$option2" in 
            "1"|"create database") create_database;;
            "2"|"list database") list_database;;
            "3"|"connect database") connect_database;;
            "4"|"drop database") drop_database;;
            "5"|exit) break;;
            *) echo "Wrong choice, Please write a number from 1 to 5 or the option you want to do, ex: 1 or create database." ;;
esac
done
}

main_menu


