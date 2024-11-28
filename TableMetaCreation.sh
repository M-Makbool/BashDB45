#!/bin/bash
touch "$DATABASE_DIR/.$t_name"
clear
echo "Table $t_name"
declare -i col_num
declare -i i
while true; do
read -p "Enter the columns Number: " col_num
    if [ $col_num -gt 0 ]; then
        break
    else
        echo "The Input should be Number greater then 0 !"
    fi
done

for ((i=1;i<=$col_num;i++)); do
    while true; do
    read -p "Enter the column $i name: " col_name
        if name_checker $col_name; then
            if grep -w $col_name $DATABASE_DIR/.$t_name; then
                echo "column already exist !"
            else
                break
            fi
        fi
    done
    echo $col_name >> $DATABASE_DIR/.$t_name;
done