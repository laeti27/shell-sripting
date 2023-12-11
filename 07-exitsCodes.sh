#!/bin/bash

#each and every action in Linux will have a exit code

# 0 to 255 is the range of the codes
# Among all, 0 represents action completed successfully .

# 0       : Global Success
# 1...125+: Some failure from the command
# 125+    : Syxtem Failure

# Exit codes also plays a key role in debugging big scripts.

# Ex : If you're having a big script and if your script fails and it's really challenging to figure out the mistake as it makes us to watch over the e
# Instead, we can use exit codes everywhere to find out where our script failes.