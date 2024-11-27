                    #Bash shell script Database Management system

#! /bin/bash

#Main Menu:
#- Create Database
#- List Databases
#- Connect To Databases
#- Drop Database

#The base directory for DBMS:
 BASE_DIR=./.serry

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
            "1"|"create"|"create database") create_database;;
            "2"|"list"|"list database") list_database;;
            "3"|"connect"|"connect database") connect_database;;
            "4"|"drop"|"drop database") drop_database;;
            "5"|exit) break;;
            *) echo "Wrong choice, Please write a number from 1 to 5 or the option you want to do, ex: 1 or create database." ;;
esac
done
}

create_database () {
    read -p "Enter Database Name: " db_name
    #name checker
    if [ -z "$db_name" ]; then 
        echo "Database Name can NOT be empty"    
    elif [ -d "$BASE_DIR/$db_name" ]; then    
        echo "Database already exists"
    else 
        mkdir -p "$BASE_DIR/$db_name" && echo "Database '$db_name' created succesfully"    
    fi
}


list_database(){
    echo "Databases List: "
    ls -d "$BASE_DIR"/*/ 2> /dev/null | xargs -n 1 basename 2> /dev/null || echo "No database found !"
}

connect_database(){
    read -p "Please enter a database name to connect: " db_name
    #name checker
    if [ -d "$BASE_DIR/$db_name" ]; then 
        echo "Database $database is connected" 
        db_menu "$BASE_DIR/$db_name"
    else 
        echo "Database does NOT exist"  
    fi  
}


drop_database(){
    read -p "Enter the database name you want to delete: " db_name
    #name checker
    if [ -d "$BASE_DIR/$db_name" ]; then
        rm -r "$BASE_DIR/$db_name" && echo "Database succesfully dropped"
    else 
    echo "database does not exist!"    
    fi
}

main_menu
