#!/bin/bash

echo "$$"    # $$ is going to print the PID of the current process
echo '$$'    # Single Quotes Always Eliminates The Power Of The Special Variable

echo $?
echo "$?"
echo '$?'