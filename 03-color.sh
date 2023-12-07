#!/bin/bash

#Each and every color you see on terminal will have a color code and we need to use that code based on our need

# Colors          Foreground           Background
# Red                31                  41
# Green              32                  42
# Yellow             33                  43
# Blue               34                  43
# Cyan               35                  45
# Magenta            36                  45

# Syntax to Print COLORS is :

# echo -e "\e[COLORCODEm I am printing Red color \e[0m"

echo -e "\e31m I am printing Red color \e[0m"
echo -e "\e32m I am printing Green color \e[0m"
echo -e "\e33m I am printing Yellow color \e[0m"
echo -e "\e34m I am printing Blue color \e[0m"
echo -e "\e35m I am printing Cyan color \e[0m"