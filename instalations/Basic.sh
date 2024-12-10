#!/bin/bash
# Autorem jest IndianBartonka

# Sprawdzanie uprawnień
if [[ $EUID -ne 0 ]]; then
   echo ""
    echo -e "\e[31mUruchom ten skrypt jako root lub za pomocą sudo.\e[0m"
   exit 1
fi

echo ""
echo "Aktualizowanie systemu..."
apt update && apt upgrade -y

# Usuń Chromium
echo ""
echo "Usuwanie chromium..."
apt purge -y chromium

# Zainstaluj Firefox
echo ""
echo "Instalowanie firefoxa..."
apt install -y firefox

# Zainstaluj gnome-disk-utility
echo ""
echo "Instalowanie gnome-disk-utility..."
apt install -y gnome-disk-utilit

# Zainstaluj gparted
echo ""
echo "Instalowanie gparted..."
apt install -y gparted

# Zainstaluj rpi-connect
echo ""
echo "Instalowanie Raspbbery PI Connect..."
apt install -y rpi-connect

# Uruchom rpi-connect
rpi-connect on
echo "Uruchomiono Raspbbery PI Connect"

# Zainstaluj Tailscale
echo ""
echo "Instalowanie Tailscale...."
curl -fsSL https://tailscale.com/install.sh | sh
