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


#function break_o(){

 #       read -p "# Do you want to exit this process ? (yes/no): " exit_choice
  #      if [[ $exit_choice == "yes" ]]; then
   #               break 2> /dev/null 
    #    elif [[ $exit_choice == "no" ]] ; then
                 
                 # echo "invalid option exiting...."
     #             continue 2> /dev/null
#	else 
#		echo"invalid exiting ...."
#		break

#        fi
#}


function create_file() {
	while true ;
	do
		
                read -p " please enter the path of the dir you want to create the file on : " path
		read -p " please enter the name of the file : " name
	        touch "$path"
	        #check if the previous command execute
	        if [ $? -eq 0 ] 2> /dev/null; then
		       echo -e "<<<<file is created successfully>>>>\n"
		       echo -e "*********************************************************************\n\n"
		       break
	        else
		        echo "erro creating file please try again "
			continue
	        fi
		
	done	
}

#**********************************************************************************************************************
function create_dir(){
	while true;
	do

                read -p " please enter the path of the directory : " path
	        echo -e "*****************************************************************************\n\n"
                mkdir "$path"
                if [ $? -eq 0 ] 2> /dev/null ; then
                         echo -e "<<<<file is created successfully>>>>\n"
		         echo -e"*****************************************************************************\n\n"
		         break
                else    
                         echo "erro creating directory please try again"
		         continue
                fi
	done	
}

#***********************************************************************************************************************
function copy() {
	while true;
	do

	        read -p "what do you want to copy directory / file ? " type
	        read -p "please enter the source path of the file or the dir you want to copy : " source
	        read -p "please enter the destination path of the file or the dir you want to move : " destination
	        if [ -f "$source" ] && [ -d"destination" ]; then
                           cp -r "$source" "$destination"
                           if [ $? -eq 0 ] 2> /dev/null; then
                                   echo "you copied the $type sucessfully"
				   break
                           else
                                   echo " there's something wrong happend please try again"
                                   continue
                           fi
                else
		           echo "your source or destination may not exisit please check the right one"
		           continue
	        fi
         done
}

#************************************************************************************************************************
function move() {
	while true;
	do

                read -p "what do you want to move directory / file ? " type
                read -p "please enter the source path of the file or the dir you want to move : " source
       	        read -p "please enter the destination path of the file or the dir you want to move : " destination
        
	        if [ -f "$source" ] || [ -d "$source" ] && [ -d "$destination" ]; then
		        chmod +rw "$source"

                        # -i:to prompt for confirmation befor confirmation
                        mv -i "$source" "$destination"

                        if [ $? -eq 0 ] 2> /dev/null; then
                                 echo "you moved the $type sucessfully"
				 break
                        else
                                 echo " there's something wrong happend please try again"
                                 continue
                        fi
		
                 else
                        echo "your source or destination may not exist please check the right one"
		        continue
                 fi
	done	 
}

#************************************************************************************************************************
function rename() {
	while true;
	do


                read -p "please enter the old name of the file or the dir you want to rename : " old_name
                read -p "please enter the new_name of the file or the dir  : " new_name


                # -i:to prompt for confirmation befor overwrite any file with the same new_name 
                 mv -i "$old_name" "$new_name"

                  if [ $? -eq 0 ] 2> /dev/null; then
                            echo "you renamed the $old_name sucessfully to $new_name"
			    break
                  else
                             echo " there's something wrong happend please try again"
                             continue
                  fi
	done	  
}

#*******************************************************************************************************

function delete(){
	while true;
	do

	       read -p "please enter the type directory/file : " type
	       echo -e "***************************************************\n"

	       read -p "please enter name of the $type : " name
	       echo -e "***************************************************\n"

	       read -p " are you sure you want to delet this $type y/n : " conf
	       echo -e "***************************************************\n"

	       if [[  ${conf,,} = "y" ]]; then

		       if [[ -x "$(dirname "$name")" ]]; then

			        if [[ ${type,,} = "file" ]]; then
				       rm "$name"
				       #check if the previous command execute
				       if [ $? -eq 0 ] 2> /dev/null; then
					       echo "this $type i deleted successfully"
					       break
				       else
					       echo "there may be a problem please try again"
					       continue
				       fi 

			         elif [[ ${type,,} = "directory" ]]; then

				       rmdir "$name"
				       if [ $? -eq 0 ] 2> /dev/null; then
                                               echo "this $type i deleted successfully"
					       break
                                        else
                                               echo "there may be a problem please try again"
                                               continue
                                        fi
			         fi

		        else 
		 	         echo " you don't have the permission to delete this $type"
			         break
		        fi

	       else
		        break
	       fi
	done       
}


#//////////////////////////////////////////////////////////////////////////////////////////////////////
# main menu
while true;
do

       echo "<<<< welcom to file & dir mangment >>>>"
       echo -e "********************************************************************************************\n"
       echo -e "please enter the option by it's number  to use it :- \n [1] create_file. \n [2] create_dir. \n [3] copy. \n [4] move. \n [5] rename. \n [6] delete. \n >>>>> :" 
       read option

       case $option in
	       "1")
		         create_file
		        # exit_o
		         ;;
	        "2")
		         create_dir
		        # exit_o
		         ;;
	        "3")
		         copy
		         #exit_o
		         ;;
	        "4")
		         move
		         #exit_o
		         ;;
	        "5")
		         rename
		         #exit_o
		         ;;
	        "6")
		         delete
		         #exit_o
		         ;;
		"7")  
		         return
			 ;;
			
	        *)
		         echo "invalid option please try again"
		         continue
		         ;;
        esac
done	

#/////////////////////////////////////////////////////////////////////////////////////////////////////
