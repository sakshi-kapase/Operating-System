create(){
    echo "Enter Address book name"
    read ab
    res=`ls | grep -w "$ab" | wc -w`
    if [ $res -gt 0 ]
    then
        echo "Error: File already exists"
    else
        touch "$ab"
        echo "Address book '$ab' created successfully."
    fi
}

display() {
    echo "Enter Address book name"
    read ab

    if [ -f "$ab" ]; then
        printf "%-5s %-10s %-15s %-10s %-10s %-10s\n" "S.No" "ROLLNO" "NAME" "PERCENTAGE" "BRANCH" "CLASS"
        i=1
        while IFS= read -r line
        do
            rn=$(echo "$line" | awk '{print $1}')
            nm=$(echo "$line" | awk '{print $2}')
            pc=$(echo "$line" | awk '{print $3}')
            br=$(echo "$line" | awk '{print $4}')
            cl=$(echo "$line" | awk '{print $5}')
            
            printf "%-5s %-10s %-15s %-10s %-10s %-10s\n" "$i" "$rn" "$nm" "$pc" "$br" "$cl"
            ((i++))
        done < "$ab"
    else
        echo "Error: File does not exist"
    fi
}


insert(){
    echo "Enter Address book name"
    read ab

    if [ -f "$ab" ]; then
        echo -ne "Enter the number of records to create: "
        read num  
        for((i=0;i<num;i++))
        do
            echo "Enter roll number of student:"  
            read rn  
            len=`grep -w "$rn" "$ab" | wc -l`
            if [ $len -gt 0 ]
            then
                echo "Error: Roll number already exists"
            else
                echo "Enter name of student:"  
                read nm  
                echo "Enter percentage of student:"  
                read sk  
                echo "Enter Branch of student:"  
                read eg  
                echo "Enter Class of student:"  
                read hn  
                record="$rn   $nm   $sk   $eg   $hn"  
                echo "$record" >> "$ab"  
                echo "Record inserted."
            fi
        done
    else
        echo "Error: File does not exist"
    fi
}

delete_record() {
    echo "Enter Address book name"
    read ab

    if [ -f "$ab" ]; then
        echo "Enter roll number to delete:"
        read rn

       
        if grep -q "^$rn[[:space:]]" "$ab"; then
            grep -v "^$rn[[:space:]]" "$ab" > temp.txt
            mv temp.txt "$ab"
            echo "Record with Roll No. $rn deleted successfully."
        else
            echo "Error: Roll number not found."
        fi
    else
        echo "Error: File does not exist"
    fi
}


modify_record() {
    echo "Enter Address book name"
    read ab

    if [ -f "$ab" ]; then
        echo "Enter roll number to modify:"
        read rn

        exists=$(grep -w "$rn" "$ab" | wc -l)
        if [ $exists -eq 0 ]; then
            echo "Error: Roll number not found."
            return
        fi

        grep -vw "$rn" "$ab" > temp.txt
        mv temp.txt "$ab"

        echo "Enter new name of student:"  
        read nm  
        echo "Enter new percentage of student:"  
        read sk  
        echo "Enter new Branch of student:"  
        read eg  
        echo "Enter new Class of student:"  
        read hn  
        record="$rn   $nm   $sk   $eg   $hn"  
        echo "$record" >> "$ab"  
        echo "Record modified."
    else
        echo "Error: File does not exist"
    fi
}

search_record() {
    echo "Enter Address book name"
    read ab

    if [ -f "$ab" ]; then
        echo "Enter roll number to search:"
        read rn

      
        record=$(grep "^$rn[[:space:]]" "$ab")

        if [ -n "$record" ]; then
            echo -e "\nRecord found:"
            printf "%-10s %-15s %-10s %-10s %-10s\n" "ROLLNO" "NAME" "PERCENTAGE" "BRANCH" "CLASS"
            rn=$(echo "$record" | awk '{print $1}')
            nm=$(echo "$record" | awk '{print $2}')
            pc=$(echo "$record" | awk '{print $3}')
            br=$(echo "$record" | awk '{print $4}')
            cl=$(echo "$record" | awk '{print $5}')
            printf "%-10s %-15s %-10s %-10s %-10s\n" "$rn" "$nm" "$pc" "$br" "$cl"
        else
            echo "Error: Record not found."
        fi
    else
        echo "Error: File does not exist"
    fi
}


ans=y
while [ "$ans" = "y" ]
do
    clear
    echo "*=*=*=*=* MENU *=*=*=*=*"
    echo "1) Create database"
    echo "2) View database"
    echo "3) Insert a record"
    echo "4) Delete a record"
    echo "5) Modify a record"
    echo "6) Search a record"
    echo "7) Exit"
    echo -ne "\nEnter your choice: "
    read choice

    case $choice in
        1) create ;;
        2) display ;;
        3) insert ;;
        4) delete_record ;;
        5) modify_record ;;
        6) search_record;;
        7) exit ;;
        *) echo "Enter a valid choice!" ;;
    esac

    echo -ne "\nDo you want to continue? (y/n): "
    read ans
done
