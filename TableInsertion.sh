#!/bin/bash
clear && echo "Insert into Table $t_name"

declare -i col_num
declare -i i

col_num=$(wc -l < $DATABASE_DIR/.$t_name)
row_val=""
for((i=1;i<=$col_num;i++)); do
    col_name=$(sed -n "${i}p" $DATABASE_DIR/.$t_name | cut -d: -sf1)
    col_type=$(sed -n "${i}p" $DATABASE_DIR/.$t_name | cut -d: -sf2)
    pk_check=$(sed -n "${i}p" $DATABASE_DIR/.$t_name | cut -d: -sf3)
    read -p "Enter the column $col_name value ($col_type): " col_val
    if [ "$pk_check" = "pk" ]; then
        if [ -z "$col_val" ]; then
            echo "primary key column can NOT be empty!"
            ((i--))
            continue
        elif cut -d: -sf$i $DATABASE_DIR/$t_name | grep -w $col_val; then
            echo "primary key value already exist!"
            ((i--))
            continue
        fi
    fi
    if [[ $col_val =~ ^[^0-9]+$ && "$col_type" = "int" ]]; then
        echo "column value should be integr!"
        ((i--))
        continue
    elif [[ $col_val =~ ^[^0-9a-zA-Z_]+$ && "$col_type" = "varchar" ]]; then
        echo Please enter a valid value with no special chars
        ((i--))
        continue
    fi
    if [ $i -eq 1 ]; then
        row_val=$col_val
    else
        row_val=$row_val:$col_val
    fi
done
echo $row_val >> $DATABASE_DIR/$t_name;
return 0
