#!/bin/bash
#
# this script displays some host identification information for a Linux machine
#
# Sample output:
#   Hostname      : zubu
#   LAN Address   : 192.168.2.2
#   LAN Name      : net2-linux
#   External IP   : 1.2.3.4
#   External Name : some.name.from.our.isp
# the LAN info in this script uses a hardcoded interface name of "eno1"
#    - change eno1 to whatever interface you have and want to gather info about in order to test the script
# TASK 1: Dynamically identify the list of interface names for the computer running the script, and use a for loop to generate the report for every interface except loopback
################
# Data Gathering
################
# grep is used to filter ip command output so we don't have extra junk in our output
# stream editing with sed and awk are used to extract only the data we want displayed
# we use the hostname command to get our system name
my_hostname=$(hostname)
default_router_address=$(ip r s default| cut -d ' ' -f 3)
default_router_name=$(getent hosts $default_router_address|awk '{print $2}')
external_address=$(curl -s icanhazip.com)

cat <<EOF

-------- System Identification Summary------

Hostname      : $my_hostname
Default Router: $default_router_address
Router Name   : $default_router_name
External IP   : $external_address
EOF

getint=$(lshw -class network | awk '/logical name:/{print $3}' | wc -l)
for((w=1;w<=$getint;w+=1));
do
  interface=$(lshw -class network | awk '/logical name:/{print $3}' | awk -v z=$w 'NR==z{print $1; exit}')
  if [[ $interface = lo* ]] ; then
    continue ;
  fi

  ipv4_address=$(ip a s $interface | awk -F '[/ ]+' '/inet /{print $3}')
  ipv4_hostname=$(getent hosts $ipv4_address | awk '{print $2}')
  network_address=$(ip route list dev $interface scope link|cut -d ' ' -f 1)
  network_number=$(cut -d / -f 1 <<<"$network_address")
  network_name=$(getent networks $network_number|awk '{print $1}')
  echo Interface        :$interface
  echo ------------------------------------------------------------
  echo Address          : $ipv4_address
  echo Name             : $ipv4_hostname
  echo Network Address  : $network_address
  echo Network Name     : $network_name
done
