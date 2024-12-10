#!/bin/bash

# Sprawdzanie uprawnień
if [[ $EUID -ne 0 ]]; then
   echo ""
   //TODO: Dodaj w innych skryptach też ten tekst na czerwono
   echo -e "\e[31mUruchom ten skrypt jako root lub za pomocą sudo.\e[0m"
   exit 1
fi

echo ""
echo "Aktualizowanie systemu..."
apt update && apt upgrade -y

echo ""
echo "Odkomentowywanie pl_PL w /etc/locale.gen"
sed -i 's/^# *\(pl_PL.UTF-8 UTF-8\)/\1/' /etc/locale.gen

echo ""
echo "Generowanie lokalizacji..."
locale-gen

echo ""
echo "Zmienianie lokalizacji na polską..."
update-locale LANG=pl_PL.UTF-8

echo "=================="
echo ""
echo -e "\e[31mJEŚLI POLSKI NIE JEST ZAZNACZONY, ZAZNACZ GO W OKNIE KONFIGURACJI\e[0m"
echo ""
echo "=================="
sleep 2
dpkg-reconfigure locales

echo ""
echo "Za 5 sekund system zostanie zrestartowany..."
sleep 5

reboot
