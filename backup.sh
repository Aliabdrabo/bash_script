#!/bin/bash


function exit_o(){
	#exit option
                  read -p "do you want to exit? ( yes / no ) :  " conf
                  if [[ ${conf,,} == "yes" ]]; then
                         exit
                  elif [[ ${conf,,} == "no" ]]; then
                          continue
                  else
                          echo "invalid option force exit" 2> /dev/null
                          exit
                  fi

}
function backup(){
	echo -e  "<<<<< this function allow you to create backups of files / directories >>>>>\n\n"

	while true ;
	do
		read -p " -please enter the path of the file / dir to bs backed up:  " path

		if [ -e "$path" ] && [ -f "$path" ]; then
			echo -e "\n\n <<<all backups will be created in backup directory>>>\n"
		        read -p "   -enter name : " name
			cp "$path" "/home/ali/backups" 2> /dev/null
			gzip "/home/ali/backups/""$name" 2> /dev/null
			if [ $? -eq 0 ];then
				echo " <<<the file has been backed up successfully>>>"
				ls "/home/ali/backups"
			else
				echo -e "<<<there might be an error please try again>>>\n\n" 2> /dev/null
				continue
			fi
		elif [ -e "$path" ] && [ -d "$path" ]; then
		        read -p "please enter backup name:  " backup_name
			tar czfP "$backup_name" "$path" 2> /dev/null
			if [ $? -eq 0 ];then
				echo -e "\n"
                                echo " <<<the directory has been backed up successfully>>>"
                                
                        else
                                echo "<<< there might be an error please try again >>>\n\n" 2> /dev/null
				continue
                        fi
			mv "$backup_name" "/home/ali/backups" 2> /dev/null
			echo -e "\n\n" 
			ls  "/home/ali/backups" 2> /dev/null
		else
			echo "<<<< no such file or directory >>>>\n" 2> /dev/null
		fi
	#exit option
	exit_o
	done
}


function restore() {
	while true;
	do



	        echo -e "<<<< this function restore data when needed >>>> \n\n"
	        read  -p " -enter the compressed file name:  " path

		if [[ ! -f "$compressed_file" || ! "${compressed_file}" =~ \.(gz|tar)+$ ]]; then
                        echo " Invalid compressed file specified: $path " 2> /dev/null
                fi

	        if [[ "${path}" =~ \.gz$ ]]; then

			gunzip "$path"
			if [ $? -eq 0 ];then
                                echo -e "\n"
                                echo " <<<the directory has been restored successfully>>>"
   
                        else
                                echo "<<< there might be an error please try again >>>\n\n" 2> /dev/null
                                exit_o
				continue
                        fi
		fi	

		if [[ "${path}" =~ \.tar$ ]]; then
		        
			tar -xzvf "$path" 
			if [ $? -eq 0 ];then
                                 echo -e "\n\n"
                                 echo  " <<<the directory has been restored successfully>>>"
 
                         else
                                 echo -e "<<< there might be an error please try again >>>\n\n" 2> /dev/null
                                 exit_o
				 continue
                         fi
			
		fi
	done
}	

restore
