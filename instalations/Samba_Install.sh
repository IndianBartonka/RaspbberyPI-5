#!/bin/bash
# Autorem: IndianBartonka – automatyczna instalacja Samby z konfiguracją

# Sprawdzenie uprawnień
if [[ $EUID -ne 0 ]]; then
   echo -e "\n\e[31mUruchom ten skrypt jako root (sudo).\e[0m"
   exit 1
fi

echo -e "\nAktualizowanie systemu..."
apt update && apt upgrade -y

echo -e "\nInstalowanie Samby..."
apt install samba -y

# Tworzenie katalogu współdzielonego
SHARE_PATH="/srv/samba/nas"
mkdir -p "$SHARE_PATH"

# Zapytaj o użytkownika
echo ""
read -p "Podaj nazwę użytkownika do Samby: " userName

# Dodanie użytkownika systemowego, jeśli nie istnieje
if ! id "$userName" &>/dev/null; then
    adduser "$userName"
fi

# Ustaw hasło do Samby
smbpasswd -a "$userName"

# Nadanie uprawnień do folderu
chown "$userName:$userName" "$SHARE_PATH"
chmod -R 775 "$SHARE_PATH"

# Tworzenie domyślnego pliku konfiguracyjnego Samby
cat > /etc/samba/smb.conf <<EOF
[global]
   workgroup = WORKGROUP
   server string = RaspberryPi Samba Server
   map to guest = Bad User
   log file = /var/log/samba/log.%m
   max log size = 1000
   logging = file
   server role = standalone server
   usershare allow guests = no
   unix password sync = yes
   security = user
   passdb backend = tdbsam

[nas]
   comment = Udostępniony folder NAS
   path = $SHARE_PATH
   browseable = yes
   writable = yes
   valid users = $userName
   create mask = 0660
   directory mask = 0771
EOF

# Restart usługi Samba
systemctl restart smbd

echo -e "\n\e[32mSamba skonfigurowana!\e[0m"
echo -e "Udział: \\\\$(hostname -I | awk '{print $1}')\\nas"
