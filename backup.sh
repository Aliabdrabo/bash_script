#!/bin/bash


function exit_o(){
	#exit option
                  read -p "do you want to exit? ( yes / no ) :  " conf
                  if [[ ${conf,,} == "yes" ]]; then
                         exit
                  elif [[ ${conf,,} == "no" ]]; then
                          continue 2> /dev/null
                  else
                          echo "invalid option force exit" 
                          break
                  fi

}

function backup(){
	echo -e  "<<<<< this function allow you to create backups of files / directories >>>>>\n\n"

	while true ;
	do
		read -p " -please enter the path of the file / dir to bs backed up:  " path

		if [ -e "$path" ] && [ -f "$path" ] 2> /dev/null ; then
			
			echo -e "\n\n <<<all backups will be created in backup directory>>>\n"
		        read -p "   -enter name : " name
			cp "$path" "/home/ali/backups" 2> /dev/null
			gzip "/home/ali/backups/""$name" 2> /dev/null
			if [ $? -eq 0 ] 2> /dev/null ;then
				echo " <<<the file has been backed up successfully>>>"
				ls "/home/ali/backups"
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
				
				echo -e "<<<there might be an error please try again>>>\n\n" 
			        #breck option
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
		elif [ -e "$path" ] && [ -d "$path" ] 2> /dev/null ; then

		        read -p "please enter backup name:  " backup_name
			tar czfP "$backup_name" "$path" 2> /dev/null
			if [ $? -eq 0 ] 2> /dev/null;then
				echo -e "\n"
                                echo -e " <<<the directory has been backed up successfully>>>\n"
				read -p "do you want to exit from this operation? ( yes / no ) :  " conf
				echo -e "********************************************************************\n"

                                if [[ ${conf,,} == "yes" ]]; then
                                       break
                                elif [[ ${conf,,} == "no" ]]; then
                                       continue 2> /dev/null
                                else
                                       echo "invalid option force exit"
                                       break
                                fi
                        else
                                echo "<<< there might be an error please try again >>>\n\n" 
				read -p "do you want to exit from this operation? ( yes / no ) :  " conf
				echo -e "********************************************************************\n"
                                if [[ ${conf,,} == "yes" ]]; then
                                       break
                                elif [[ ${conf,,} == "no" ]]; then
                                       continue 2> /dev/null
                                else
                                       echo "invalid option force exit" 
                                       break
                                fi
                        fi
			mv "$backup_name" "/home/ali/backups" 2> /dev/null
			echo -e "\n\n" 
			ls  "/home/ali/backups" 2> /dev/null
		else
			echo "<<<< no such file or directory >>>>\n"
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


function restore() {
	while true;
	do



	        echo -e "<<<< this function restore data when needed >>>> \n\n"
	        read  -p " -enter the compressed file path :  " path

		if [[ ! -f "$compressed_file" || ! "${compressed_file}" =~ \.(gz|tar)+$ ]]; then
                        echo " Invalid compressed file specified: $path " 2> /dev/null
                fi

	        if [[ "${path}" =~ \.gz$ ]]; then

			gunzip "$path"
			if [ $? -eq 0 ] 2> /dev/null;then
                                echo -e "\n"
                                echo " <<<the directory has been restored successfully>>>"
				break
   
                        else
                                        continue 2> /dev/null
                                        echo "invalid option force exit" 
                        fi
		fi	

		if [[ "${path}" =~ \.tar$ ]] 2> /dev/null; then
		        
			tar -xvf "$path" 2> /dev/null
			if [ $? -eq 0 ] 2> /dev/null;then
                                 echo -e "\n\n"
                                 echo  " <<<the directory has been restored successfully>>>"
                                 break
                                  
                        else
                                 echo -e "<<< there might be an error please try again >>>\n\n" 2> /dev/null
                                         continue 2> /dev/null
                        fi
			
		fi
	done
}	

while true;
do
        echo -e "please choose the option by number: \n [1]Backup. \n [2] Restore \n [3] back option. "
        read number
        case $number in
                "1")
                       backup
                       #exit_o
                       ;;
                "2")
                       restore
                      # exit_o
                       ;;
		"3")
		      exit
		      ;;
                *)
                       echo -e "<<<<< invalid option >>>>>>\n"
                       echo "<<<<<try again >>>>>"
                       exit_o
                       ;;
        esac
done

