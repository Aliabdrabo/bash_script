#!/bin/bash


function exit_o(){
        read -p "# Do you want to exit the script ? (yes/no): " exit_choice
        if [[ $exit_choice == "yes" ]]; then
                 exit
        elif [[ $exit_choice == "no" ]]; then
                 continue 2> /dev/null
        else
                echo "<<<<< invalid choice >>>>>"
                echo "exitig"
                exit
        fi
}

##########################################################################################################
function fd_m (){
	echo -e "   <<<<< file & directory management >>>>>\n"
	echo -e "**********************************************\n"
	while true;
	do
		echo -e " please enter the the process by it's number:-\n[1] File and directory operation.\n[2] searching.\n[3] permission management.\n[4] backup & restore\n[5] back option."
		read number
		case $number in
		        "1")
			        ./file_and_dir.sh
			       # exit_o
				echo -e "***********************************************************************************************\n"
			        ;;
			"2")
			        ./search.sh
				#exit_o
				echo -e "***********************************************************************************************\n"
				;;
			"3")
			        ./permission.sh
				#exit_o
				echo -e "***********************************************************************************************\n"
				;;
			"4")
			        ./backup.sh
				#exit_o
				echo -e "***********************************************************************************************\n"
				;;
			"5")
			        return
				echo -e "***********************************************************************************************\n"
				;;
			*)
			        echo -e "invalid option please try again"
				continue
				echo -e "***********************************************************************************************\n"
				;;
		esac
	done	

}





#########################################################################################################



echo -e "   <<<<< welcom to file management & system montering >>>>>\n"
echo -e "***************************************************************\n\n"

while true;
do
	echo -e " please enter the the process by it's number:-\n[1] File and directory management.\n[2] System monitoring\n[3] exit."
	read number
	case $number in
	        "1")
		       fd_m
		      # exit_o
		       ;;
		"2")
		       ./sys.sh
		       #:exit_o
		       ;;
		"3")
		       exit
		       ;;
		*)
		       echo "invalid option "
		       exit_o
		       echo -e "***********************************************************************************************\n"
		       ;;
	esac
done	


