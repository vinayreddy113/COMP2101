MyHost=$(hostname)
interface=$(ip a |awk '/: e/{gsub(/:/,"");print $2}')
LAN_Address=$(ip a s $interface |awk '/inet /{gsub(/\/.*/,"");print $2}')
LAN_Hostname=$(getent hosts $LAN_Address| awk '{print $2}')
External_IP=$(curl -s icanhazip.com)
Router_address=$(ip route | grep 'default' | awk '{ print $3}')
Router_name=$(getent hosts $Router_address| awk '{print $2}')
Network_Address=$(route | awk '/255.255.255.0/''{print $1}')
Network_Name=$(getent networks $Network_Address| awk '{print $2}')
cat <<EOF
Hostname      : $MyHost

LAN IP        : $LAN_Address

LAN Hostname  : $LAN_Hostname

External IP   : $External_IP

Router address: $Router_address

Router Name   : $Router_name

Network IP    : $Network_Address

Network Name  : $Network_Name

EOF
