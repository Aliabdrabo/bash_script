#!/bin/bash

function basic(){
        echo -e "\n<<<<< this function will display you a basic information of operating system >>>>>\n"
        echo    "******************************************************************************************"

        echo -e "<<hostname>>\n*****************************************************"
        hostname

	echo -e "\n"
        echo -e "<<uptime>>\n****************************************************"
        uptime

	echo -e "\n"
        echo -e "<<date>>\n****************************************************"
        date +" %A , %B %d , %Y %H:%M:%S"
	echo -e "\n*************************************************************"
}




function cpu(){
	echo -e "\n<<<<< this function will display the Cpu usage percentage for all processes of th system >>>>>\n"
	echo    "*******************************************************************************************"
	read -p "enter number of batches you want to display : " batch



	echo "<<<  pid   ,  user ,  Cpu%  >>>"
	echo "*****************************************************"
	top -bn "$batch" | awk 'NR<=50{print $1,$2,$9}'
	echo -e "\n****************************************************************************************"
}







function memory(){
	echo -e "\n<<<<< this function will display the memory usage percentage for  processes of th system >>>>>\n"
        echo -e "******************************************************************************************************\n"
	read -p "enter number of batches you want to display : " batch
        echo -e "<<<  pid   ,  user ,  Cpu%  >>>\e"
        echo "**********************************************************"
        top -bn "$batch" | awk 'NR<=50{print $1,$2,$10}'
	echo -e "\n*******************************************************"


}




function disk_space(){
	echo -e "\n<<<<< this function display the total disk space, used space, and available space for each mounted filesystem >>>>>\n"
        echo -e "******************************************************************************************************\n"
        df -ah

	echo -e "\n*******************************************************************************************************\n"
}





function report(){








