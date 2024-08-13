#!/bin/bash


function set_per(){

        while true; do
                read -p "enter user (owner) permission (rwx) : " user
                read -p "enter group  permission (rwx) : " group
                read -p "enter others (any other user) permission (rwx) : " others

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
                break

    done

}




function a_or_s() {

        echo "<<<<this function will allow you to modify all the section of permission or the one speacific section>>>> "

        while true; do
                read -p "# enter the operator ( + ) for adding permissions ( - ) for removeing permissions : " operator
                read -p "# enter  permission (rwx) : " permission

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

                        echo "# no such a file or a dir"
                        continue

                fi
                break

        done

        read -p "# if you want to modify all the three section enter (( a )) if you want to modify one section (( o )) : " process
case ${process,,} in
                "a")
                        chmod "$operator$permission" "$path"
			if [ $? -eq 0 ];then
                                ls -l "$path"
			        
			else
				echo " there may a problems"

                        fi

                        ;;
                "o")
                        while true;
                        do
                               read -p "# enter the category you want to modify u / g / o : " category
                               if [[ ! ${category,,} =~ ^[ugo]+$ ]]; then
                                     echo "# invalid category"
                                     read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                                     if [[ ${conf,,} == "yes" ]]; then
                                             break
                                     elif [[ ! ${conf,,} == "no" ]]; then
                                             echo "invalid option try again"
					     continue 2> /dev/null
                                     fi


                               fi
                               chmod "$category$operator$permission" "$path"
                               ls -l "$path"
			       read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                               if [[ ${conf,,} == "yes" ]]; then
                                         break
                               elif [[ ! ${conf,,} == "no" ]]; then
                                         echo "invalid option try again"
                                         continue 2> /dev/null
                               fi

                        done
                        ;;
                *)
                        echo "invalid option"
			return 

                        ;;
        esac
}



function num_mode(){
        echo "<<<< this function allow you to change the permissions by numiric values>>>>"
        echo -e "- r = 4 \n - w = 2 \n - x = 1 \n\n"

        while true; do
                read -p "# enter  permission (1 2 4 7 6) : " permission

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
                 break

        done

}


function change_owner() {
        while true ;
        do

               read -p " please enter the path of the file : " path
               read -p "please enter the new owner user : " new_owner
               # Check if file exists
               if [ ! -e "$path" ]; then
                      echo "Error: File '$path' does not exist."
                      continue
               fi 

               # Check if new owner exists
               if id -u "$new_owner" &> /dev/null; then
                     #User exists
                     chown "$new_owner" "$path"
                     if [ $? -eq 0 ]; then
                            echo "Ownership changed successfully for '$path' to '$new_owner'"
                            break

		     else
                            echo "Error changing ownership for '$path'"
                            echo -e "<<<< please try again >>>>\n"
                            read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                             if [[ ${conf,,} == "yes" ]]; then
                                     break
                            elif [[ ! ${conf,,} =~ "no" ]]; then
                                     echo "invalid option please try again"
                                     continue
                            fi

		    fi
                else
                            echo "Error: User '$new_owner' does not exist."
                            read -p "do you want to exit from this operation? ( yes / no ) :  " conf
                             if [[ ${conf,,} == "yes" ]]; then
                                     break
                            elif [[ ! ${conf,,} =~ "no" ]]; then
                                     echo "invalid option please try again"
                                     continue
                            fi

		fi

        done

}


#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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


function symbolic_mode(){
	
	while true;
        do
		echo -e "[1]  set\n[2] assigning\n[3] back option"
		read  x

                   case $x in
                            "1")
                                     set_per
                                     ;;
                            "2")
                                      a_or_s
                                      ;;
			 
			    "3")    
                                      exit
                                      ;;
                            *)
                                      echo " invalied option"
                                      exit_o
                                      ;;
                     esac
       done
}


#main##############################################################################################

while true;
do
	echo -e "<<<<permission managment>>>>\n\n"
	echo -e "what mode do you want to use?\n[1] for symbolic_mode\n[2] for numeric_mode \n[3] changeowner user\n[4] back option"
        read  mode
        echo -e "\n\n"
	case $mode in
                "1")
                        symbolic_mode
                        ;;
                "2")
                        num_mode
                        ;;
		"3")
		        change_owner
			;;
		"4")
		        return
		        ;;
                *)
                        echo " invalied option"
			exit_o 
                        ;;
        esac
done

