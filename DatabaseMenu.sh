#!/bin/bash

<< INFO
Mohammed Makbool
23-11-2024
iTi Bash Project
INFO

DATABASE_DIR=$1

function name_checker(){
    if [[ "$1" =~ ^[0-9] || "$1" =~ [^a-zA-Z0-9] ]]; then
        echo Please enter a valid name with no special chars and does not start with a number
        return 1
    else
        return 0
    fi
}

function create_table(){
   read -p "Enter Table Name: " t_name
    MESSEGE=$(name_checker $t_name)
    if [ $? -eq 0 ]; then
        if [ -z "$t_name" ]; then 
            echo "Table Name can NOT be empty"    
        elif [ -f "$DATABASE_DIR/$t_name" ]; then    
            echo "Table already exists"
        else 
            touch "$DATABASE_DIR/$t_name" && echo "Table '$t_name' created succesfully"    
        fi
    else
    echo $MESSEGE;
    fi
}

function list_table(){
    echo "Table List: "
    ls -f "$DATABASE_DIR"/* 2> /dev/null | xargs -n 1 basename 2> /dev/null || echo "No Tables found !"
}

function drop_table(){
    read -p "Enter the table name you want to drop: " t_name
    MESSEGE=$(name_checker $t_name)
    if [ $? -eq 0 ]; then
        if [ -f "$DATABASE_DIR/$t_name" ]; then
            rm -r "$DATABASE_DIR/$t_name" && echo "Table successfully dropped"
        else 
            echo "Table does not exist!"    
        fi
    else
    echo $MESSEGE;
    fi
}

function insert_table(){
    echo table insert;
}
function select_table(){
    read -p "Enter Table name: " table_name
    if [ -f $DATABASE_DIR/.$table_name ]; then
        cat $DATABASE_DIR/.$table_name | cut -d ':' -f1 | xargs
        column -s':' -t < "$DATABASE_DIR/$table_name"                             #cat $DATABASE_DIR/$table_name 
    else  
        echo "Table does not txist"
    fi    
        read -p "Enter Table name: " table_name

}
function delete_table(){
    echo table delete;
}
function update_table(){
    echo table update;
}

while true
do
    clear;
    echo '1- Create Table'
    echo '2- List Tables'
    echo '3- Drop Table'
    echo '4- Insert into Table'
    echo '5- Select From Table'
    echo '6- Delete From Table'
    echo '7- Update Table'
    echo '8- Back to Main Menu'
    echo "----------------------"
    echo $MESSEGE
    read -p "Choose What you want to do: " option
    option2=$(echo "$option" | tr '[:upper:]'  '[:lower:]')
    MESSEGE=''
    case "$option2" in 
        "1"|"create"|"create table") MESSEGE=`create_table`;;
        "2"|"list"|"list tables") MESSEGE=`list_table`;;
        "3"|"drop"|"drop table") MESSEGE=`drop_table`;;
        "4"|"insrt"|"insert into table") MESSEGE=`insert_table`;;
        "5"|"select"|"select from table") select_table;;
        "6"|"delete"|"delete from table") MESSEGE=`delete_table`;;
        "7"|"update"|"update table") MESSEGE=`update_table`;;
        "8"|exit|"main"|"main menu"|"Back to Main Menu") break;;
        *) MESSEGE="Wrong choice, Please write a number from 1 to 7 or the option you want to do, ex: 1 or create table." ;;
    esac
done;
