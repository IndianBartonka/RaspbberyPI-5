#!/bin/bash
set -e  # zatrzymaj przy błędzie

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
