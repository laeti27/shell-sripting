#!/bin/bash

# Conditions help us to execure something only if SOME-Factor is true or false.



# Syntax of case

# case $var in
#    opt1) commands-x ;;
#   opt2) commands-y ;;
#esac
ACTION=$1                      # $1 refers first command line argument

case $ACTION in
     start)
         echo -e "\e[32m starting shipping servive \e[0m"
         exit 0
         ;;
     stop)
         echo -e "\e[32m stopping shipping servive \e[0m"
         exit 1
         ;;
     retart)
         echo -e "\e[32m restarting shipping servive \e[0m"
         exit 3
         ;;
    *)
         echo -e "e[35m Valid Options are start or stop or restart only \e[0m"
         echo -e "\e[33m Example usage: \e[0m \n\t\t bash script.sh start"         
esac          