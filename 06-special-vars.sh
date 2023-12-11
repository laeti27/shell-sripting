#!/bin/bash

# Special Variables are $0 to $9 , $* , $@ , $#, $$
a=1000

echo "Value of a is $a"
echo "printing Script Name : $0"

echo "First Argument is : $1 "
echo "Second Argument is : $2 "
#bash scriptingName.sh firstArg  secondArg  thirdArg
#                         $1         $2        $



echo $0  # Prints Script Name
echo $#  # Prints the overall arguments used in the script
echo $?  # prints the exit code of the last command
echo $*  # Prints all the arguments used.
echo $@  # Prints all the arguments used