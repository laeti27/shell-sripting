#!/bin/bash

# DATE="11DECEMBER2023"
DATE=$(date +%F)
NO_OF_SESSIONS=$(who|wc -l)
echo -e "Good Morning , Todays date is \32m $DATE \e[0m"
echo -e "Total Number Of Connected Sessions : \e[32m $NO_OF_SESSIONS \e[0m"
