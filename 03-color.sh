#!/bin/bash

#printing or presentingh your work in a nice neatly way using colors 
#colors       foreground          background
#red              31                   41
#green            32                    42
#yellow           33                    43
#blue             34                    44
#Magenta          36                    45

# syntax to print COLORS is : 

# echo -e  "\e[COLORCODEm I am printing Red color \e[0m"

echo -e "\e[31m I am printing Red color \e[0m"
echo -e "\e[32m I am printing Green color \e[0m"
echo -e "\e[33m I am printing  Yellow color \e[0m"
echo -e "\e[34m I am printing Blue color \e[0m"
echo -e "\e[35m I am printing Magenta color \e[0m"

# Background + Foregroung
echo -e "\e[43;34m I am printing background +forground \e[0m"