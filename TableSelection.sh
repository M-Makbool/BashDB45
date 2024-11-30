#!/bin/bash
clear && echo "SELECT FROM $t_name"

while true; do
    read -p "WHERE " col_name
    if [ -z "$col_name" ]; then 
        cond_col_num=0
        break
    elif ! cut -d: -sf1 $DATABASE_DIR/.$t_name | grep -w $col_name > /dev/null; then
            echo "column dose not exist! try another column"
    else
        cond_col_num=$(cut -d: -sf1 $DATABASE_DIR/.$t_name | grep -nw $col_name | cut -d: -sf1)
        read -p "WHERE $col_name = " cond_col_val
        break
    fi
done
awk -v ccol=$cond_col_num -v cval=$cond_col_val '
    BEGIN{
        FS = ":"
        OFS = ":"
    }{
        if ( ccol == 0 )
            print $0
        else if ( $ccol == cval )
            print $0
    }
' $DATABASE_DIR/$t_name > $DATABASE_DIR/.$t_name.temp
clear
cat $DATABASE_DIR/.$t_name | cut -d ':' -f1 | xargs | column -s' ' -nt
column -s':' -nt < "$DATABASE_DIR/.$t_name.temp"
rm $DATABASE_DIR/.$t_name.temp
read

# while true; do
    
# done
#     echo "Enter the column you want to"
#     read -p "SELECT " col_name
#     sel_col_num=$(cut -d: -sf1 $DATABASE_DIR/.$t_name | grep -nw $col_name | cut -d: -sf1 2> /dev/null)
#     if [ $sel_col_num -gt 0 ] || [ -z $col_name ]; then
        
#     else
#         echo -e "\033[1;31mColumn does not exist\033[0m"
#     fi
# else
#     echo -e "\033[1;31mColumn does not exist\033[0m"
# fi