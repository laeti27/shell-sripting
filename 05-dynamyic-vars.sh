#!/bin/bash

# DATE="11DECEMBER2023"
DATE=$(date +%F)
NO_OF_SESSIONS=$(who|wc -l)
echo "Good Morning , Todays date is $DATE"
echo "Total Number Of Connected Sessions : $NO_OF_SESSIONS"
