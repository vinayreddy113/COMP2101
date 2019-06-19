#!/bin/bash
#
# this script displays some host identification information for a simple Linux machine
#
# Sample output:
#   Hostname        : hostname
#   LAN Address     : 192.168.2.2
#   LAN Hostname    : host-name-from-hosts-file
#   External IP     : 1.2.3.4
#   External Name   : some.name.from.our.isp

# Task 1: Add a section to the script to define variables which hold the output data for
#         each output item and move the commands which generate the data to that section so that
#         the output command only outputs the labels and single variables.

# Task 2: Add output items for the default router's name and IP address,
#         adding a name to your /etc/hosts file as needed.
# e.g.
#   Router Address  : 192.168.2.1
#   Router Hostname : router-name-from-hosts-file

# Task 3: Add output items for the network's name and IP address, adding a name to your /etc/networks file as needed.
# e.g.
#   Network Number. : 192.168.2.0
#   Network Name    : network-name-from-networks-file

# we use the hostname command to get our system name
# the LAN name is looked up using the LAN address in case it is different from the system name
# finding external information relies on curl being installed and relies on live internet connection
# awk is used to extract only the data we want displayed from the commands which produce extra data
# this command is ugly done this way, so generating the output data into variables is recommended to make the script more readable.
# e.g.
#   interface_name=$(ip a |awk '/: e/{gsub(/:/,"");print $2}')


MyHost=$(hostname)
interface=$(ip a |awk '/: e/{gsub(/:/,"");print $2}')
LAN_Address=$(ip a s $interface |awk '/inet /{gsub(/\/.*/,"");print $2}')
LAN_Hostname=$(getent hosts $LAN_Address| awk '{print $2}')
External_IP=$(curl -s icanhazip.com)
Router_address=$(ip route | grep 'default' | awk '{ print $3}')
Router_name=$(getent hosts $Router_address| awk '{print $2}')
Network_Address=$(route -n | awk '/255.255.255.0/''{print $1}')
Network_Name=$(getent networks $Network_Address| awk '{print $1}')
cat <<EOF
Hostname      : $MyHost

LAN IP        : $LAN_Address

LAN Hostname  : $LAN_Hostname

External IP   : $External_IP

Router address: $Router_address

Router Name   : $Router_name

Network IP    : $Network_Address

Network NAME  : $Network_Name

EOF
