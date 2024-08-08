#!/bin/bash


function s_file_name() {
	read -p "please enter the path you want to search on:  " path
	read -p "please enter name of the file : " name
	if [ -e "$path" ] && [ -r "$path" ]; then
		find $path -name "$name" 
		if [ $? -eq 0 ]; then
			echo " the $name has been found "
		else
			echo "there's a trouble has occured  please try again"
		fi
	else 
		echo " no such a file or a dirvof the path you entered or permission denied please check and try again "
	fi
}	





function s_file_type() {
	read -p "please enter type d (directory) / f for (regular file) / l for (symbolic link) / b for (block special file) : " type
	valid_type=( "f" "d" "l" "b" )
        while [[ ! "${valid_type[*]}" =~ "$type" ]]; do

                echo "invalid type"
                read -p " valid units is : f , d , l , b  " type
        done

        read -p "please enter the path you want to search on:  " path
        if [ -e "$path" ] && [ -r "$path" ]; then
               sudo find $path -type "$type"
                if [ $? -eq 0 ]; then
		echo "<<<<< the $type has been found>>>>> "
                else
                        echo "there's a trouble has occured  please try again"
                fi
        else
                echo " no such a file or a dir of the path you entered or permission denied please check and try again "
        fi
}

function s_file_size(){

	read -p "please enter size  " size
	read -p "please enter the unit of the size b: bytes \n c: blocks (512 bytes) \n k: kilobytes (1024 bytes) \n M: megabytes (1024 * 1024 bytes) \nG: gigabytes (1024 * 1024 * 1024 bytes)  " unit
	valid_units=( "b" "c" "k" "M" "G" )
	while [[ ! "${valid_units[*]}" =~ "$unit" ]]; do
		echo "invalid unit"
		read -p " valid units is : c , b , k , M , G " unit
	done	
        read -p "please enter the path you want to search on:  " path
        if [ -e "$path" ] && [ -r "$path" ]; then
                
		find $path -size "$size""$unit"
                
		if [ $? -eq 0 ]; then
                        echo " the file or dir that match the size you enter has been found "
                else
                        echo "there's a trouble has occured  please try again"
                
		fi
        
	else
                echo " no such a file or a dir of the path you entered or permission denied please check and try again "
        
	fi

}


function s_file_mod_time(){


	read -p "please enter time (number)  " time
	read -p "(+) Indicates files modified more than the specified number of days ago.\n(-)Indicates files modified less than the specified number of days ago." operator
        valid_operator=( "+" "-" )
        while [[ ! "${valid_operator[*]}" =~ "$operator" ]]; do
                echo "invalid operator"
                read -p " valid units is : + , - " operator
        done
        read -p "please enter the path you want to search on:  " path
        if [ -e "$path" ] && [ -r "$path" ]; then

                find $path -mtime "$operator""$time"

                if [ $? -eq 0 ]; then
                        echo " the file or dir that modified in that time you enter has been found "
                else
                        echo "there's a trouble has occured  please try again"

                fi

        else
                echo " no such a file or a dir of the path you entered or permission denied please check and try again "

        fi

}


#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#main 


echo "file search sytem "
echo -e " which of criteria you want to find the files with? \ns_file_name  \ns_file_type  \ns_file_size \n s_file_mod_time" 
read criteria

case $criteria in
        "s_file_name")
                s_file_name
                ;;
        "s_file_type")
                s_file_type
                ;;
        "s_file_size")
                s_file_size
                ;;
        "s_file_mod_time")
                s_file_mod_time
                ;;
        *)
                echo "invalid criteria  please try again or write the command manually and try"
		read -p " if you want to write your command manually please enter y if not enter n " con
		if [ "$con" = "y" ]; then
		       read -p "Enter a find command: " find_command
                       if [[ ! "${find_command}" =~ ^find\  ]]; then
                             echo "Invalid find command. Please start with 'find'."
                             exit 1
			     
                       fi
                       #execute find_command
                       eval "$find_command"
		       
	        else
		       echo "please try again using the criteria"
		       break
		fi       
esac

