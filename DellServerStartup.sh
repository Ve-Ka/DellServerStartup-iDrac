#!/bin/sh
function serverStartup(){
expect <<EOF
    spawn ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$1
    expect "root@$1's password: "
    send "$sshPassword\r"
    expect "/admin1-> "
    send "racadm serveraction powerup\r"
    expect "/admin1-> "
    send "exit\r"
EOF
}

### Main Output ###
read -p "SSH Password: " -s sshPassword
echo

while true; do
    echo "-------------------"
    echo "|Server to Startup|"
    echo "-------------------"
    echo "|RX20-ESXI-01  [1]|"
    echo "|RX20-ESXI-02  [2]|"
    echo "|RX20-ESXI-03  [3]|"
    echo "|R510-Unraid   [4]|"
    echo "|EVE-NG-SAT    [E]|"
    echo "|ALL           [A]|"
    echo "|Exit          [ ]|"
    echo "-------------------"
    read -p "-> " serverSelection
    case $serverSelection in
        [1]* ) serverStartup "192.168.10.14"; echo;;
        [2]* ) serverStartup "192.168.10.16"; echo;;
        [3]* ) serverStartup "192.168.10.18"; echo;;
        [4]* ) serverStartup "192.168.10.12"; echo;;
        [Ee]*) serverStartup "192.168.10.14"; serverStartup "192.168.10.16"; serverStartup "192.168.10.18"; echo;;
        [Aa]*) serverStartup "192.168.10.14"; serverStartup "192.168.10.16"; serverStartup "192.168.10.18"; serverStartup "192.168.10.12"; echo;;
        * ) echo "Programme Exiting..."; echo; break;;
    esac
done