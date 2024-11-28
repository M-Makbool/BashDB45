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
        echo "---Main Menu---"
        echo "1- Create Database"
        echo "2- List Databases"
        echo "3- Connect To Database"
        echo "4- Drop Database"
        echo "5- Exit"
        echo "--------------"
        echo $MESSEGE
        read -p "Choose What you want to do: " option
        option2=$(echo "$option" | tr '[:upper:]'  '[:lower:]')
        MESSEGE=''
        case "$option2" in 
            "1"|"create"|"create database") MESSEGE=$(create_database);;
            "2"|"list"|"list databases") MESSEGE=$(list_database);;
            "3"|"connect"|"connect database") connect_database;;
            "4"|"drop"|"drop database") MESSEGE=$(drop_database);;
            "5"|exit) break;;
            *) MESSEGE="Wrong choice, Please write a number from 1 to 5 or the option you want to do, ex: 1 or create database." ;;
esac
done
}

name_checker(){

    if [[ "$1" =~ ^[0-9] || "$1" =~ [^a-zA-Z0-9] ]]; then
        echo Please enter a valid name with no special chars and does not start with a number
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
            echo "Database Name can NOT be empty"    
        elif [ -d "$BASE_DIR/$db_name" ]; then    
            echo "Database already exists"
        else 
            mkdir -p "$BASE_DIR/$db_name" && echo "Database '$db_name' created succesfully"    
        fi
    else
    echo $MESSEGE;
    fi
}


list_database(){
    echo "Databases List: "
    ls -d "$BASE_DIR"/*/ 2> /dev/null | xargs -n 1 basename 2> /dev/null || echo "No database found !"
}

connect_database(){
    read -p "Please enter a database name to connect: " db_name
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
