#!/bin/bash

<< INFO
Mohammed Makbool
23-11-2024
iTi Bash Project
INFO

function create_table(){
    echo table created;
}
function list_table(){
    echo table list;
}
function drop_table(){
    echo table drop;
}
function insert_table(){
    echo table insert;
}
function select_table(){
    echo table select;
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
    echo $Mess
    read -p "Choose What you want to do: " option
    option2=$(echo "$option" | tr '[:upper:]'  '[:lower:]')
    Mess=''
    case "$option2" in 
        "1"|"create"|"create table") Mess=`create_table`;;
        "2"|"list"|"list tables") Mess=`list_table`;;
        "3"|"drop"|"drop table") Mess=`drop_table`;;
        "4"|"insrt"|"insert into table") Mess=`insert_table`;;
        "5"|"select"|"select from table") Mess=`select_table`;;
        "6"|"delete"|"delete from table") Mess=`delete_table`;;
        "7"|"update"|"update table") Mess=`update_table`;;
        "8"|exit|"main"|"main menu"|"Back to Main Menu") break;;
        *) Mess="Wrong choice, Please write a number from 1 to 7 or the option you want to do, ex: 1 or create table." ;;
    esac
done;
