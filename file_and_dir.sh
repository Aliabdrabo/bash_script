#!/bin/bash

function create_file() {
        read -p " please enter the path of the file : " path
	touch "$path"
	#check if the previous command execute
	if [ $? -eq 0 ]; then
		echo "file is created successfully"
	else
		echo "erro creating file please try again "
		create_file
	fi
}

#**********************************************************************************************************************
function create_dir(){
        read -p " please enter the path of the directory : " path
        mkdir "$path"
        if [ $? -eq 0 ]; then
                echo "file is created successfully"
        else    
                echo "erro creating directory please try again"
		create_dir
        fi
}

#***********************************************************************************************************************
function copy() {
	read -p "what do you want to copy directory / file ? " type
	read -p "please enter the source path of the file or the dir you want to copy : " source
	read -p "please enter the destination path of the file or the dir you want to move : " destination
	if [ -f "$source" ] && [ -d"destination" ]; then
		read -p "please enter the destination path of the file or the dir you want to copy : " destination
                cp -r "$source" "$destination"
                if [ $? -eq 0 ]; then
                         echo "you copied the $type sucessfully"
                else
                         echo " there's something wrong happend please try again"
                         copy
                fi
        else
		echo "your source or destination may not exisit please check the right one"
		copy
	fi	
}

#************************************************************************************************************************
function move() {
        read -p "what do you want to copy directory / file ? " type
        read -p "please enter the source path of the file or the dir you want to move : " source
       	read -p "please enter the destination path of the file or the dir you want to move : " destination
        
	if [ -f "$source" ] || [ -d "$source" ] && [ -d "$destination" ]; then
		chmod +rw "$source"

                # -i:to prompt for confirmation befor confirmation
                 mv -i "$source" "$destination"

                  if [ $? -eq 0 ]; then
                            echo "you moved the $type sucessfully"
                  else
                             echo " there's something wrong happend please try again"
                             move
                  fi
		
        else
                 echo "your source or destination may not exist please check the right one"
		 move
        fi 
}

#************************************************************************************************************************
function rename() {

        read -p "please enter the old name of the file or the dir you want to rename : " old_name
        read -p "please enter the new_name of the file or the dir  : " new_name


                # -i:to prompt for confirmation befor overwrite any file with the same new_name 
                 mv -i "$old_name" "$new_name"

                  if [ $? -eq 0 ]; then
                            echo "you renamed the $old_name sucessfully to $new_name"
                  else
                             echo " there's something wrong happend please try again"
                             rename
                  fi
}

#*******************************************************************************************************

function delete(){
	read -p "please enter the type directory/file : " type
	read -p "please enter name of the $type : " name
	read -p " are you sure you want to delet this $type y/n : " conf
	if [ $conf = "y" ]; then

		if [ -x "$(dirname "$name")" ]; then

			if [ $type = "file" ]; then
				rm "$name"
				#check if the previous command execute
				if [ $? -eq 0 ]; then
					echo "this $type i deleted successfully"
				else
					echo "there may be a problem please try again"
					delete
				fi 

			elif [$type = "directory"]; then

				rmdir "$name"
				 if [ $? -eq 0 ]; then
                                        echo "this $type i deleted successfully"
                                else
                                        echo "there may be a problem please try again"
                                        delete
                                fi
			fi

		else 
		 	echo " you don't have the permission to delete this $type"
		fi
	else
		break
	fi	
}


#//////////////////////////////////////////////////////////////////////////////////////////////////////
# main menu

echo "welcom to file & dir mangment"
echo " which of these option do you want to use? \n create_file \n create_dir \n copy \n move \n rename \n delete \n" 
read option

case $option in
	"create_file")
		create_file
		;;
	"create_dir")
		create_dir
		;;
	"copy")
		copy
		;;
	"move")
		move
		;;
	"rename")
		rename
		;;
	"delete")
		delete
		;;
	*)
		echo "invalid option please try again"
		;;
esac

#/////////////////////////////////////////////////////////////////////////////////////////////////////
