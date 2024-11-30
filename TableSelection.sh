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

while true; do
    echo "Please, Enter the columns you want to select seperated with comma, or * to select all"
    read -p "SELECT " col_names
    if [ -z "$col_names" ]; then 
        echo "There is no columns to select!"
        continue
    elif [ "$col_names" = '*' ]; then
        clear
        cat $DATABASE_DIR/.$t_name | cut -d ':' -f1 | xargs | column -s' ' -nt
        column -s':' -nt < "$DATABASE_DIR/.$t_name.temp"
        rm $DATABASE_DIR/.$t_name.temp
        read
        break
    else
        declare -i col_num
        declare -i i
        tryagain=0
        col_names=$(echo $col_names | sed 's/ //g' | sed 's/,/:/g')
        col_num=$(echo $col_names | sed 's/:/ /g' | wc -w)
        for((i=1;i<=$col_num;i++)); do
            col_name=$(echo $col_names | cut -d: -f$i)
            if [ -z "$col_name" ]; then
                echo "There is an empty column field!"
                tryagain=1
                break
            elif ! cut -d: -sf1 $DATABASE_DIR/.$t_name | grep -w $col_name > /dev/null; then
                echo "\"$col_name\" column dose not exist! try another column from: "
                cat $DATABASE_DIR/.$t_name | cut -d ':' -f1 | xargs | column -s' ' -nt
                tryagain=1
                break
            else
                sel_col_num=$(cut -d: -sf1 $DATABASE_DIR/.$t_name | grep -nw $col_name | cut -d: -sf1)
                if [ $i -eq 1 ]; then
                    sel_col_nums=$sel_col_num
                else
                    sel_col_nums=$sel_col_nums:$sel_col_num
                fi
            fi
        done
        if [ $tryagain -eq 1 ]; then
            continue
        else
            echo $sel_col_nums > $DATABASE_DIR/.$t_name.col_nums.temp
            awk '
                BEGIN{
                    FS = ":"
                    OFS = ":"
                }{
                    if ( NR == 1 ){
                        col_num = NF
                        for( i = 1; i <= NF; i++ )
                            col_nums[i] = $i
                    }
                    else{
                        for( i = 1; i <= col_num; i++ )
                            if ( i == 1 )
                                row = $col_nums[i]
                            else
                                row = row FS $col_nums[i]
                        print row
                    }
                }
            ' $DATABASE_DIR/.$t_name.col_nums.temp $DATABASE_DIR/.$t_name.temp > $DATABASE_DIR/.$t_name.temp1
            clear
            cat $DATABASE_DIR/.$t_name | cut -d ':' -f1 | xargs | column -s' ' -nt
            column -s':' -nt < "$DATABASE_DIR/.$t_name.temp1"
            read
            break
        fi
    fi

done
rm $DATABASE_DIR/.$t_name.*
