#!/bin/bash
# Autorem jest IndianBartonka

# Sprawdzanie uprawnień
if [[ $EUID -ne 0 ]]; then
   echo ""
    echo -e "\e[31mUruchom ten skrypt jako root lub za pomocą sudo.\e[0m"
   exit 1
fi

echo ""
echo "Wyłączanie wifi"
nmcli radio wifi off

echo ""
echo "Włączanie wifi"
nmcli radio wifi on
