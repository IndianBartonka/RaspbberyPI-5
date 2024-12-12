#!/bin/bash
# Autorem jest IndianBartonka

# Sprawdzanie uprawnień
if [[ $EUID -ne 0 ]]; then
   echo ""
    echo -e "\e[31mUruchom ten skrypt jako root lub za pomocą sudo.\e[0m"
   exit 1
fi

echo ""
echo "Uruchamienia Tailscale jako Exit Node"
tailscale up --advertise-exit-node

echo ""
echo "Zezwalanie na dostęp przez lan dla exit nodu"
tailscale set --exit-node-allow-lan-access

echo ""
echo "Aby wszytko było okej resetujemy usługe Tailscale"
systemctl restart tailscaled