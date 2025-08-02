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

echo ""
echo "Instaluje Sambe..."
apt install samba -y

echo ""
echo "Za 5 sekund zostanie otwarty plik konfiguracyjny samby do edycji..."
sleep 5
nano /etc/samba/smb.conf

echo ""
read -p "Podaj nazwę użytkownika do Samby: " userName
adduser "$userName"
smbpasswd -a "$userName"

echo ""
echo "Restartowanie Samby..."
systemctl restart smbd

echo ""
echo -e "\e[32mSamba została zainstalowana i skonfigurowana.\e[0m"
