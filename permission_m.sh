#!/bin/bash


function set_per(){

	while true; do
		read -p "enter user (owner) permission (rwx) : " user
		read -p "enter group  permission (rwx) : " group
		read -p "enter others (any other user) permission (rwx) : " others
		read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                if [[ ${conf,,} == "yes" ]]; then
                         break
                elif [[ ${conf,,} == "no" ]]; then
                         continue 2> /dev/null
                else
                         echo "invalid option force exit"
                         break
                fi


		if [[ ${user} -le 3 && ${group} -le 3 && ${others} -le 3 ]];then
			echo " valied length "
		else
			continue
		fi
		

		if [[ ! ${user} =~ ^[rwx-]+$ && ! ${group} =~ ^[rwx-]+$ && ! ${others} =~ ^[rwx-]+$ ]]; then
			echo "  you entered wrong permission the permission is just r , w , x ,and  - (for no permission) "
			continue
		fi
		
		

		read -p "please enter the path of the file or the dir you want to change the permission to: " path

		if [ -e "$path" ] && [ -w "$path" ]; then
			echo "///////////////////////////////////////////////////////////////////////////////////////"
		else 
			echo "no such a file or a dir"
			continue
		fi

		echo "<<<< you set permissions successfully >>>>"
                chmod "u=$user,g=$group,o=$others" "$path"
                ls -l "$path"


	done
	
}	




function a_or_s() {

	echo "<<<<this function will allow you to modify all the section of permission or the one speacific section>>>> "

	while true; do
		read -p "# enter the operator ( + ) for adding permissions ( - ) for removeing permissions : " operator
                read -p "# enter  permission (rwx) : " permission
		read -p "# Do you want to exit? (yes/no): " exit_choice
                if [[ $exit_choice == "yes" ]]; then
                         exit
                fi

                if [[ ${permission} -le 3 ]];then
                        echo "# valied length "
                else
                        continue
                fi


                if [[ ! ${permission} =~ ^[rwx-]+$ ]]; then
                        echo "# you entered wrong permission the permission is just r , w , x ,and  - (for no permission) "
                        continue
                fi

		if [[ ! ${operator} =~ ^[+-]+$ ]]; then
			echo "# invalid operator"
			continue
		fi

                read -p "# please enter the path of the file or the dir you want to change the permission to: " path

                if [[ ! -e "$path" ]] && [[ ! -w "$path" ]]; then
                    
                        echo"# no such a file or a dir"
                        continue

                fi
		break

        done

	read -p "# if you want to modify all the three section enter (( a )) if you want to modify one section (( o )) : " process

	case $process in
		"a")
			chmod "$operator$permission" "$path"
                        ls -l "$path"
			if [[ ${conf,,} == "yes" ]]; then
                                 break
                        elif [[ ${conf,,} == "no" ]]; then
                                 continue 2> /dev/null
                        else
                                 echo "invalid option force exit"
                                 break
                        fi

			;;
		"o")
			while true;
                        do
                               read -p "# enter the category you want to modify u / g / o : " category
                               if [[ ! ${category} =~ ^[ugo]+$ ]]; then
                                     echo "# invalid category"
				     read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                                     if [[ ${conf,,} == "yes" ]]; then
                                             break
                                     elif [[ ${conf,,} == "no" ]]; then
                                             continue 2> /dev/null
                                     else
                                             echo "invalid option force exit"
                                             break
                                     fi


                               fi
			       chmod "$category$operator$permission" "$path"
                               ls -l "$path"

                        done
			;;
		*)
			echo "invalid option"
			read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                        if [[ ${conf,,} == "yes" ]]; then
                                 break
                        elif [[ ${conf,,} == "no" ]]; then
                                 continue 2> /dev/null
                        else
                                 echo "invalid option force exit"
                                 break
                        fi
			;;
	esac		
}				
		



function num_mode(){
	echo "<<<< this function allow you to change the permissions by numiric values>>>>"
	echo -e "- r = 4 \n - w = 2 \n - x = 1 \n\n" 

	while true; do
                read -p "# enter  permission (1 2 4 7 6) : " permission
		read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                if [[ ${conf,,} == "yes" ]]; then
                         break
                elif [[ ${conf,,} == "no" ]]; then
                         continue 2> /dev/null
                else
                         echo "invalid option force exit"
                         break
                fi

                if [[ ${#permission} -eq 3 ]]; then
                        echo "# valied length "
                else
			echo "invalied length please enter 3 digit one for user one, for group, and one for others"
                        continue
                fi


                if [[ ! ${permission} =~ ^[0-7]+$ ]]; then
                        echo "# you entered wrong permission the permission is just r=4 , w=2  , x=1 ,and  0 (for no permission) "
                        continue
                fi


                read -p "# please enter the path of the file or the dir you want to change the permission to: " path

                if [[ ! -e "$path" ]] && [[ ! -w "$path" ]]; then

                        echo"# no such a file or a dir or permission denied"
                        continue

                fi

		chmod "$permission" "$path"
                echo "you set permission sucessfully"
                ls -l "$path"

        done
}




function change_owner() {
	while true ;
	do

	       read -p " please enter the path of the file " path
               read -p "please enter the new owner user " new_owner
               # Check if file exists
               if [ ! -e "$path" ]; then
                      echo "Error: File '$path' does not exist."
                      continue
               fi

               # Check if new owner exists
               if id -u "$new_owner" &> /dev/null; then
                     #User exists
                     chown "$new_owner" "$file"
                     if [ $? -eq 0 ]; then
                            echo "Ownership changed successfully for '$path' to '$new_owner'"
			    read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                            if [[ ${conf,,} == "yes" ]]; then
                                    break
                            elif [[ ${conf,,} == "no" ]]; then
                                    continue 2> /dev/null
                            else
                                    echo "invalid option force exit"
                                    break
                             fi
                     else
                            echo "Error changing ownership for '$path'"
			    echo -e "<<<< please try again >>>>\n"
			    read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                            if [[ ${conf,,} == "yes" ]]; then
                                    break
                            elif [[ ${conf,,} == "no" ]]; then
                                    continue 2> /dev/null
                            else
                                    echo "invalid option force exit"
                                    break
                            fi
                     fi
                else
                            echo "Error: User '$new_owner' does not exist."
			    read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                            if [[ ${conf,,} == "yes" ]]; then
                                    break
                            elif [[ ${conf,,} == "no" ]]; then
                                    continue 2> /dev/null
                            else
                                    echo "invalid option force exit"
                                    break
                            fi
                fi

	done	

}
#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#main


echo -e "<<<<permission managment>>>>\n\n"
read -p "what mode do you want to use? ( symbolic_mode / numeric_mode ) :" mode
echo -e "\n\n"

function symbolic_mode(){
	read -p " set / assigning " x
        case $x in
                "set")
                       set_per
                       ;;
                "assigning")
                       a_or_s
                       ;;
                *)
                       echo "invalid option"
                       ;;
       esac	
}



case $mode in
	"symbolic_mode")
		symbolic_mode
		;;
	"numeric_mode")
		num_mode
		;;
	*)
		echo " invalied option"
		;;
esac

		


	


