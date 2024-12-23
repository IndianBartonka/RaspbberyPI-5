#!/bin/bash
# Autorem jest IndianBartonka Z ChatemGPT

# Sprawdzanie uprawnień
if [[ $EUID -ne 0 ]]; then
   echo ""
   echo -e "\e[31mUruchom ten skrypt jako root lub za pomocą sudo.\e[0m"
   exit 1
fi

# Sprawdź czy użytkownik ma Box64
if ! command -v box64 &> /dev/null; then
    echo ""
    echo -e "\e[33mBox64 nie jest zainstalowany. Kontynuowanie instalacji...\e[0m"
else
    echo ""
    echo -e "\e[32mBox64 jest już zainstalowany.\e[0m"
fi

echo ""
echo "Dodawanie architektury armhf..."
dpkg --add-architecture armhf

echo ""
echo "Aktualizacja systemu..."
apt update && apt upgrade -y

echo ""
echo "Instalowanie narzędzi do kompilacji ARM..."
apt install gcc-arm-linux-gnueabihf -y

echo ""
echo "Instalowanie bibliotek Mesa i innych zależności armhf..."
apt install libgdm1:armhf libudev1:armhf libgl1-mesa-dri:armhf libglapi-mesa:armhf \
libglu1-mesa:armhf libglx-mesa0:armhf mesa-va-drivers:armhf mesa-vdpau-drivers:armhf \
mesa-vulkan-drivers:armhf libsdl1.2debian:armhf libegl-mesa0:armhf -y

echo ""
echo "Instalowanie libc6 dla armhf..."
apt-get install libc6:armhf -y

echo ""
echo "Instalowanie mesa-vulkan-drivers..."
apt install mesa-vulkan-drivers -y

echo ""
echo "Instalowanie Box64 Steam..."
curl -sL https://raw.githubusercontent.com/ptitSeb/box64/main/install_steam.sh | bash

echo ""
echo -e "\e[32mInstalacja zakończona pomyślnie!\e[0m"
