#!/bin/bash                 
  
   #Bash shell script Database Management system
                    

#Main Menu:
#- Create Database
#- List Databases
#- Connect To Databases
#- Drop Database

#The base directory for DBMS:
 BASE_DIR=./.serry

main_menu() { 
    while true ; do
        clear;
        echo -e "\033[1;35m---Main Menu---\033[0m"
        echo -e "\033[1;35m-------------------\033[0m"   
        echo -e "\033[1;34m1- Create Database\033[0m"
        echo -e "\033[1;34m2- List Databases\033[0m"
        echo -e "\033[1;34m3- Connect To Database\033[0m"
        echo -e "\033[1;34m4- Drop Database\033[0m"
        echo -e "\033[1;31m5- Exit\033[0m"
        echo -e "\033[1;35m-------------------\033[0m"
        echo $MESSEGE
        read -p "Choose What you want to do: " option
        option2=$(echo "$option" | tr '[:upper:]'  '[:lower:]')
        MESSEGE=''
        case "$option2" in 
            "1"|"create"|"create database") MESSEGE=$(create_database);;
            "2"|"list"|"list databases") MESSEGE=$(list_database);;
            "3"|"connect"|"connect database") connect_database;;
            "4"|"drop"|"drop database") MESSEGE=$(drop_database);;
            "5"|exit) clear; break;;
            *) MESSEGE="Wrong choice, Please write a number from 1 to 5 or the option you want to do, ex: 1 or create database." ;;
esac
done
}

name_checker(){

    if [[ "$1" =~ ^[0-9] || "$1" =~ [^a-zA-Z0-9] ]]; then
        echo -e "\033[1;31mPlease enter a valid name with no special characters and does not start with a number.\033[0m"
        return 1
    else
        return 0
    fi
}
create_database () {
    read -p "Enter Database Name: " db_name
    MESSEGE=$(name_checker $db_name)
    if [ $? -eq 0 ]; then
        if [ -z "$db_name" ]; then 
            echo -e "\033[1;31mDatabase Name can NOT be empty\033[0m"    
        elif [ -d "$BASE_DIR/$db_name" ]; then    
            echo -e "\033[1;31mDatabase already exists\033[0m"
        else 
            mkdir -p "$BASE_DIR/$db_name" && echo -e "\033[1;32mDatabase '$db_name' created successfully\033[0m"    
        fi
    else
    echo -e "\033[1;31m$MESSEGE\033[0m";
    fi
}


list_database(){
    echo -e "\033[1;32mDatabases List:\033[0m" 
    if ls -d "$BASE_DIR"/*/ 2> /dev/null | xargs -n 1 basename 2> /dev/null; then
       echo -e "\033[1;32mOperation completed successfully.\033[0m"
    else 
        echo -e "\033[1;31mNo database found!\033[0m"  
    fi    
}

connect_database(){
    echo -e "\033[1;34mPlease enter a database name to connect:\033[0m"
    read -p "> " db_name
    echo $db_name
    if [ -n "$db_name" ] && [ -d "$BASE_DIR/$db_name" ]; then 
        ./DatabaseMenu.sh "$BASE_DIR/$db_name"
    else 
        MESSEGE="Database does NOT exist"  
    fi  
      
}


drop_database(){
    read -p "Enter the database name you want to delete: " db_name
    MESSEGE=$(name_checker $db_name)
    if [ $? -eq 0 ]; then
        if [ -d "$BASE_DIR/$db_name" ]; then
            rm -r "$BASE_DIR/$db_name" && echo "Database successfully dropped"
        else 
        echo "database does not exist!"    
        fi
    else
    echo $MESSEGE;
    fi
}


main_menu
