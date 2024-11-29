#!/bin/bash

if [ -f "$DATABASE_DIR/.$t_name" ]; then
    rm "$DATABASE_DIR/.$t_name"
fi

touch "$DATABASE_DIR/.$t_name" && clear && echo "Table $t_name"

declare -i col_num
declare -i i

while true; do
read -p "Enter the columns Number: " col_numS
    if [[ $col_numS =~ ^[1-9]+$ ]]; then
        col_num=$col_numS
        break
    else
        echo "The Input should be Number greater than 0 !"
    fi
done

for((i=1;i<=$col_num;i++)); do
    read -p "Enter the column $i name: " col_name
        if [ -z "$col_name" ]; then 
            echo "column Name can NOT be empty"
            ((i--))
            continue
        elif name_checker $col_name; then
            if grep -w $col_name $DATABASE_DIR/.$t_name; then
                echo "column already exist !"
                ((i--))
                continue
            fi
        else
            ((i--))
            continue
        fi
    while true; do
        read -p "Enter the column \"$col_name\" type ( 1 int or 2 varchar ):  " col_type
        if [[ "$col_type" = "1" || $col_type = [iI][nN][tT] ]]; then
            col_type="int"
            break
        elif [[ "$col_type" = "2" || $col_type = [vV][aA][rR][cC][hH][aA][rR] ]]; then
            col_type="varchar"
            break
        else
            echo "unvalid choice !"
        fi
    done
    while [ ! "$pk_check" = "yes" ]; do
        read -p "Is column \"$col_name\" a primary key? ( 1 yes or 2 no ) " pk_check
        if [[ "$pk_check" = "1" || $pk_check = [yY][eE][sS] ]]; then
            pk_check="yes"
            col_type="$col_type:pk"
            break
        elif [[ "$pk_check" = "2" || $pk_check = [nN][oO] ]]; then
            pk_check="no"
            break
        else
            echo "unvalid choice !"
        fi
    done
    echo $col_name:$col_type >> $DATABASE_DIR/.$t_name;
done
