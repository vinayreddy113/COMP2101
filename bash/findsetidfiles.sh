#!/bin/bash
#
# this script generates a report of the files on the system that have the setuid permission bit turned on
# it is for the lab1 exercise

# Task 1 for the exercise is to modify it to also find and display the setgid files in a second listing
# The second listing should display after the setuid file list, and be formatted similar to the setuid file list

# Task 2 for the exercise is to modify it to also display the 10 largest files in the system, sorted by their sizes
# The listing should include the file name, owner, and size in MBytes and be displayed after the listings of setuid and setgid files

echo "Setuid files:"
echo "============="
find / -type f -executable -perm -4000 -ls 2>/dev/null | sort -k 3   # find use to find file location -type f mean only files sort -k 3
                                                                        #                                 mean sort the output by key 3


echo ""

echo "now getting setgid file"
echo "Setgid files:"
echo "============="
sleep 5

find / -type f -executable -perm -2000 -ls 2>/dev/null | sort -k 3

echo""

echo "Now displaying the 10 largest files in the system"
echo "============="
sleep 5

find / 2>/dev/null -type f -exec ls -l --block-size=M {} + | sort -rh -k 5 | head -n 10 | awk '{print $5, $3, $9}'

                                                                 # awk used for a kind of filter above comand mean only filter part $5 firts
                                                                   # and after $5 than 3 and 9  coloum :)
