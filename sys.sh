#!/bin/bash

function basic(){
        echo -e "\n<<<<< this function will display you a basic information of operating system >>>>>\n"
        echo    "******************************************************************************************"

	echo -e "<<operating system>>\n***************************************************"
	uname 

	echo -e "\n"
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


#######################################################################################

function cpu(){
	echo -e "\n<<<<<  displaying the Cpu usage percentage of all processes of th system >>>>>\n"
	echo    "*************************************************************************************"
        #calculate user & sys cpu%
	cpu_usage=$(top -bn1 | grep "Cpu(s):" | awk '{print $2 + $4}')
	echo -e "cpu usage percentage -->>( $cpu_usage )"
	echo -e "\n***********************************************************************************"
}




#######################################################################################


function memory(){
	echo -e "\n<<<<<  displaying the memory usage percentage for  processes of th system >>>>>\n"
        echo -e "******************************************************************************************************\n\n"
	mem_usage=$(free -m | grep "Mem:" | awk '{print $3/$2 * 100.0}')
        echo " Memory usage percentage -->> $mem_usage"
	echo -e "\n*******************************************************"


}


#######################################################################################

function disk_space(){
	echo -e "\n<<<<<  displaying the total disk space, used space, and available space for each mounted filesystem >>>>>\n"
        echo -e "******************************************************************************************************\n"
        disk_usage=$(df -h / | grep "/$" | awk '{print $5}')
        free_space=$(free -m | grep "Mem:" | awk '{print ($2-$3)/$2 * 100.0}')
	echo -e "-disk usage : $disk_usage \n-free space : $free_space\n "
	echo -e "\n\n"
	df -ah
	echo -e "\n*******************************************************************************************************\n"
}


#######################################################################################
# report of system

function report(){

	hostname=$(hostname)
	username=$(whoami)
	date=$(date +"%A ,%B %D ,%Y %H:%M:%S")

	echo -e "*************************************************************************************************************\n" 
	echo -e "hostname is : $hostname \nuser : $username . \ndate: $date\n"  
	echo -e "*************************************************************************************************************\n" 

	mem_usage=$(free -m | grep "Mem:" | awk '{print $3/$2 * 100.0}')
        disk_usage=$(df -h / | grep "/$" | awk '{print $5}')
	free_space=$(free -m | grep "Mem:" | awk '{print ($2-$3)/$2 * 100.0}')
	swap_mem=$(free -m | awk '/Swap/ { print $3 / $2 * 100 }')


	echo -e "<<<<< Memory >>>>>"
	echo -e "*************************************************************************************************************\n" 
        echo -e "-memory usage : $mem_usage \n-swap memory : $swap_mem\n-disk usage : $disk_usage \n-free space : $free_space\n "
	echo -e "memory usage in details (in megabytes):\n$(free -m) \n\n" 

	read -p "enter number of batches (of processes) you want to display : " batch
	echo -e "*********************************************************\n"
	echo -e "Memory usage in details for processes : \n"
	top -bn "$batch" | awk 'NR<=50{print $1,$2,$10}'
	echo -e "*************************************************************************************************************\n"

	echo -e "$(cpu)"
	echo -e "number of cores --> $(nproc --all)"
        echo -e "*********************************************************\n"
	read -p "enter number of batches (of processes) you want to display : " batch
	echo -e "*********************************************************\n"
	echo -e "cpu usage in details : \n"
	top -bn "$batch" | awk 'NR<=50{print $1,$2,$9}'
	echo -e "*************************************************************************************************************\n"


}	

#######################################################################################

function exit_o(){
	read -p "# Do you want to exit? (yes/no): " exit_choice
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

#main##################################################################################

while true;
do

           echo -e "-please choose option by number :-\n[1] basic system information. \n[2] Cpu usage mentoring. \n[3] memory usage mentoring. \n[4] Disk space mentoring \n[5] logging and reporting."
           
	   read  number

           case $number in 
        
	           "1")
	                  basic
			  exit_o
	                  ;;
	           "2")
	                  cpu
			  exit_o
	                  ;;
	           "3")
	                  memory
			  exit_o
	                  ;;
	           "4")
	                  disk_space
			  exit_o
	                  ;;
	           "5")
	                  report
			  exit_o
	                  ;;
	           *)
	                  echo -e "\n<<<< invalid option please try again >>>>"
	                  exit_o
	                  ;;
           esac	 
	   echo -e "\n\n"
done
