#!/bin/bash

<< INFO
Mohammed Makbool
23-11-2024
iTi Bash Project
INFO

DATABASE_DIR=$1

function name_checker(){
    if [[ "$1" =~ ^[0-9] || "$1" =~ [^a-zA-Z0-9] ]]; then
        echo -e "\033[1;31mPlease enter a valid name with no special chars and does not start with a number\033[0m"
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
            MESSEGE="\033[1;31mTable Name can NOT be empty\033[0m"    
        elif [ -f "$DATABASE_DIR/$t_name" ]; then    
            MESSEGE="\033[1;31mTable already exists\033[0m"
        else 
            . ./TableMetaCreation.sh && touch "$DATABASE_DIR/$t_name" && MESSEGE="Table $t_name Created Successfully."
        fi
    else
    echo $MESSEGE;
    fi
}

function list_table(){
    echo "Table List: "
    ls -f "$DATABASE_DIR"/* 2> /dev/null | xargs -n 1 basename 2> /dev/null || echo -e "\033[1;31mNo Tables found!\033[0m"
}

function drop_table(){
    read -p "Enter the table name you want to drop: " t_name
    MESSEGE=$(name_checker $t_name)
    if [ $? -eq 0 ]; then
        if [ -f "$DATABASE_DIR/$t_name" ]; then
            rm -r "$DATABASE_DIR/$t_name" "$DATABASE_DIR/.$t_name" && echo -e "\033[1;32mTable $t_name successfully dropped\033[0m"
        else 
            echo -e "\033[1;31mTable does not exist!\033[0m"    
        fi
    else
    echo $MESSEGE;
    fi
}

function insert_table(){
   read -p "Enter Table Name you want to insert in: " t_name
    MESSEGE=$(name_checker $t_name)
    if [ $? -eq 0 ]; then
        if [ -z "$t_name" ]; then 
            MESSEGE="\033[1;31mTable Name can NOT be empty\033[0m"    
        elif [ -f "$DATABASE_DIR/$t_name" ]; then    
            . ./TableInsertion.sh && MESSEGE="New row inserted in Table $t_name Successfully."
        else 
            MESSEGE="\033[1;31mTable does not exist!\033[0m"
        fi
    else
    echo $MESSEGE;
    fi
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
    read -p "Enter Table name: " t_name
    if [ -f $DATABASE_DIR/$t_name ] && [ -f $DATABASE_DIR/.$t_name ]; then
        echo "Table columns: "
        cat $DATABASE_DIR/.$t_name | cut -d ':' -f1 | xargs
        read -p "what column you want to delete with?  " col_name
        if grep -w $col_name $DATABASE_DIR/.$t_name; then
            read -p "WHERE $col_name = " col_val
            sed -i "/$col_val/d" $DATABASE_DIR/$t_name
            MESSEGE="In tble $t_name the row where $col_name = $col_val, deleted successfully."
        else
            MESSEGE="Column does not txist"
        fi
    else  
        MESSEGE="Table does not txist"
    fi    
}

function update_table(){
    read -p "Enter table name: " table_name 
    if [ -f "$table_name" ]; then
        read -p "Enter row to update: " old_row 
        read -p "Enter new data: " new_row
        sed -i "s/$old_row/$new_row/" "table_name"
        echo "Table '$table_name' updated."
    else    
    echo "Table does not exist." 
    fi
}

while true
do
    clear;
    echo -e "\033[1;35m------Connect Menu------\033[0m"
    echo -e "\033[1;34m1- Create Table\033[0m"
    echo -e "\033[1;34m2- List Tables\033[0m"
    echo -e "\033[1;34m3- Drop Table\033[0m"
    echo -e "\033[1;34m4- Insert into Table\033[0m"
    echo -e "\033[1;34m5- Select From Table\033[0m"
    echo -e "\033[1;34m6- Delete From Table\033[0m"
    echo -e "\033[1;34m7- Update Table\033[0m"
    echo -e "\033[1;31m8- Back to Main Menu\033[0m"
    echo -e "\033[1;35m-------------------------\033[0m"
    echo -e $MESSEGE
    read -p "Choose What you want to do: " option
    option2=$(echo "$option" | tr '[:upper:]'  '[:lower:]')
    MESSEGE=''
    case "$option2" in 
        "1"|"create"|"create table") create_table;;
        "2"|"list"|"list tables") MESSEGE=`list_table`;;
        "3"|"drop"|"drop table") MESSEGE=`drop_table`;;
        "4"|"insrt"|"insert into table") insert_table;;
        "5"|"select"|"select from table") select_table;;
        "6"|"delete"|"delete from table") delete_table;;
        "7"|"update"|"update table") MESSEGE=`update_table`;;
        "8"|exit|"main"|"main menu"|"Back to Main Menu") break;;
        *) MESSEGE="Wrong choice, Please write a number from 1 to 7 or the option you want to do, ex: 1 or create table." ;;
    esac
done;
