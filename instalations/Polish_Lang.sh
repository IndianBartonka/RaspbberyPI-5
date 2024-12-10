#!/bin/bash

# Sprawdzanie uprawnień
if [[ $EUID -ne 0 ]]; then
   echo ""
   echo "Uruchom ten skrypt jako root lub za pomocą sudo."
   exit 1
fi

echo ""
echo "Aktualizowanie systemu..."
apt update && apt upgrade -y

echo ""
echo "Instalowanie polskiej paczki językowej..."
apt install -y locales language-pack-pl

echo ""
echo "Odkomentowywanie pl_PL w /etc/locale.gen"
sed -i 's/^# *\(pl_PL.UTF-8 UTF-8\)/\1/' /etc/locale.gen

echo ""
echo "Generowanie lokalizacji..."
locale-gen

echo ""
echo "Zmienianie lokalizacji na polską..."
update-locale LANG=pl_PL.UTF-8

echo ""
echo "Za 5 sekund system zostanie zrestartowany..."
sleep 5

reboot
