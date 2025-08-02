#!/bin/bash

# Sprawdzanie uprawnień
if [[ $EUID -ne 0 ]]; then
   echo ""
   echo -e "\e[31mUruchom ten skrypt jako root lub za pomocą sudo.\e[0m"
   exit 1
fi

echo ""
echo "Aktualizowanie systemu..."
apt update && apt upgrade -y

echo "Instaluję JDK 23..."
curl -s https://raw.githubusercontent.com/IndianBartonka/RaspbberyPI-5/main/instalations/JDK23_Install.sh | sudo bash

echo "Wykonuję instalację podstawową..."
curl -s https://raw.githubusercontent.com/IndianBartonka/RaspbberyPI-5/main/instalations/Basic.sh | sudo bash

echo "Ustawiam język polski..."
curl -s https://raw.githubusercontent.com/IndianBartonka/RaspbberyPI-5/main/instalations/Polish_Lang.sh | sudo bash

echo "Wszystko gotowe!"
