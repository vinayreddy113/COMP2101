#!/bin/bash
#
# this script demonstrates doing arithmetic

# Improve this script by asking the user to supply the two numbers
# Improve this script by demonstrating using subtraction and multiplication
# Improve this script by demonstrating the modulus operation
#   - the output should look something like:
#   - first divided by second gives X with a remainder of Y
# Improve this script by calculating and displaying the first number raised to the power of the second number
#variables and data gathering
#firstnum=5
#secondnum=2
read -p "Give me a number: " firstnum
read -p "Give me a another number: " secondnum

#calculations
sum=$((firstnum + secondnum))
dividend=$((firstnum / secondnum))
subtracting=$((firstnum - secondnum))
multiplying=$((firstnum * secondnum))
modulas=$((firstnum % secondnum))
power=$((firstnum ** secondnum))
fpdividend=$(awk "BEGIN{printf \"%.2f\", $firstnum/$secondnum}")

cat <<EOF
$firstnum plus $secondnum is $sum
$firstnum divided by $secondnum is $dividend
$firstnum subtracted by $secondnum is $subtracting
$firstnum multiplyied by $secondnum is $multiplying
$firstnum modulas by $secondnum is $modulas
$firstnum power by $secondnum is $power
  - More precisely, it is $fpdividend
EOF
