#!/bin/bash


function exit_o(){

        read -p "# Do you want to exit? (yes/no): " exit_choice
        if [[ $exit_choice == "yes" ]]; then
                  exit
        elif [[ $exit_choice == "no" ]] ; then
                  continue 2> /dev/null
        else
                  echo "invalid option exiting...."
                  exit
        fi
}


function s_file_name() {
	while true;
	do

	          read -p "please enter the path you want to search on:  " path
	          read -p "please enter name of the file : " name
	          if [ -e "$path" ] && [ -r "$path" ] 2> /dev/null; then
		          find $path -name "$name" 
		          if [ $? -eq 0 ] 2> /dev/null; then
			          echo " the $name has been found "
				  break
		          else
			          echo "there's a trouble has occured  please try again"
				  continue
		          fi
	          else 
		          echo " no such a file or a dirvof the path you entered or permission denied please check and try again "
 	          fi
	done	  
}	





function s_file_type() {
	while true;
	do
		echo -e "- please enter type d (directory) \n- f for (regular file) \n- l for (symbolic link) \n- b for (block special file) : "


	          read type
		  echo -e"**************************************************************************************************************************\n"
	          valid_type=( "f" "d" "l" "b" )
                  if [[ ! "${valid_type[*],,}" =~ "$type" ]] 2> /dev/null; then

                            echo "<<<< invalid type please try again >>>> "
			    echo -e "********************************************************\n"
			    continue
                  fi

                  read -p "please enter the path you want to search on:  " path
                  if [ -e "$path" ] && [ -r "$path" ] 2> /dev/null; then
                            sudo find $path -type "$type"
                            if [ $? -eq 0 ]; then
		                     echo "<<<<< the $type has been found>>>>> "
				     break
                            else
                                     echo "<<<< there's a trouble has occured  please try again >>>>"
				     echo -e "**************************************************\n"
				     continue
                            fi
                  else
                            echo "<<<<<< no such a file or a dir of the path you entered or permission denied please check and try again >>>>>>"
			    echo -e "\n\n"
			    continue
                  fi
	done	  
}

function s_file_size(){
	while true;
	do


	        read -p "please enter size  " size
	        echo -e "please enter the unit of the size b: bytes \n c: blocks (512 bytes) \n k: kilobytes (1024 bytes) \n M: megabytes (1024 * 1024 bytes) \nG: gigabytes (1024 * 1024 * 1024 bytes) "
	        read  unit
	        valid_units=( "b" "c" "k" "M" "G" )
	        if [[ ! "${valid_units[*]}" =~ "$unit" ]] 2> /dev/null; then
		        echo -e "<<<<< invalid unit >>>>>>\n"
		        echo -e "<<<< please notice the case sensativeity valid units is : c , b , k , M , G >>>> \n" 
		        echo -e "****************************************************************************************\n"
		        continue
	        fi	
                read -p "please enter the path you want to search on:  " path
                if [ -e "$path" ] && [ -r "$path" ] 2> /dev/null; then
                
		        find $path -size "$size""$unit"
                
		        if [ $? -eq 0 ] 2> /dev/null; then
                                echo "<<<< the file or dir that match the size you enter has been found >>>>"
			        break
                        else
                                echo "<<<< there's a trouble has occured  please try again >>>>"
			        echo -e "****************************************************************************************\n"
			        continue
		        fi
        
	        else
                        echo -e "<<<<<< no such a file or a dir of the path you entered or permission denied please check and try again >>>>>>\n "
		        continue
        
	        fi
	done

}


function s_file_mod_time(){
	while true;
	do



	        read -p "please enter time (number)  " time
		echo -e "\n**************************************************************************************************\n"
		echo -e "# (+) Indicates files modified more than the specified number of days ago.\n# (-)Indicates files modified less than the specified number of days ago."
	        read  operator
                valid_operator=( "+" "-" )
                if [[ ! "${valid_operator[*]}" =~ "$operator" ]] 2> /dev/null;then 
                         echo "<<<< invalid operator please try again >>>>"
                         continue
                fi
		echo -e "****************************************************************************************************\n"
                read -p "please enter the path you want to search on:  " path
                if [ -e "$path" ] && [ -r "$path" ] 2> /dev/null; then

                        find $path -mtime "$operator""$time"

                        if [ $? -eq 0 ] 2> /dev/null; then
                              echo "<<<<< the file or dir that modified in that time you enter has been found >>>>> "
			      echo -e "\n**************************************************************************************************\n"
			      break
                        else
                              echo "<<<<< there's a trouble has occured  please try again >>>>>>"
			      echo -e "\n**************************************************************************************************\n"
			      continue

                        fi

                else
                        echo "<<<<< no such a file or a dir of the path you entered or permission denied please check and try again >>>>> "
			continue

                fi
	done	

}


#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#main 

while true;
do

        echo "<<<< file search sytem >>>>"
	echo "============================================="
        echo -e " which of criteria you want to find the files with (please enter the criteria you want by it's number)? \n[1] s_file_name.\n[2] s_file_type.\n[3] s_file_size. \n[4] s_file_mod_time\n[5] back option." 
        read criteria

        case $criteria in
             "1")
                    s_file_name
		    exit_o
                    ;;
             "2")
                    s_file_type
		    exit_o
                    ;;
             "3")
                    s_file_size
		    exit_o
                    ;;
             "4")
                    s_file_mod_time
		    exit_o
                    ;;
	     "5")
	            exit
                    ;;	      
             *)
                    echo "invalid criteria  please try again or write the command manually and try"
		    read -p " if you want to write your command manually please enter y if not enter n " con
		    if [ "$con" = "y" ]; then
		           read -p "Enter a find command: " find_command
                           if [[ ! "${find_command}" =~ ^find\  ]]; then
                                    echo "Invalid find command. Please start with 'find'."
                                    exit_o
			     
                           fi
                           #execute find_command
                           eval "$find_command"
		       
	             else
		           echo "please try again using the criteria"
		           exit_o
		     fi       
         esac
done
