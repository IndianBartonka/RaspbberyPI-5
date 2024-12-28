#!/bin/bash
# Autorem jest ChatGPT wraz z Indianem
set -e

if [[ $EUID -ne 0 ]]; then
   echo ""
   echo -e "\e[31mUruchom ten skrypt jako root lub za pomocą sudo.\e[0m"
   exit 1
fi

echo -e "\e[31mBox86 to jebane gówno pewnie nie skompiluje sie poprawnie.\e[0m"
echo -e "\e[31mBox86 to jebane gówno pewnie nie skompiluje sie poprawnie.\e[0m"
echo -e "\e[31mBox86 to jebane gówno pewnie nie skompiluje sie poprawnie.\e[0m"
echo -e "\e[31mBox86 to jebane gówno pewnie nie skompiluje sie poprawnie.\e[0m"
echo -e "\e[31mBox86 to jebane gówno pewnie nie skompiluje sie poprawnie.\e[0m"
echo -e "\e[31mBox86 to jebane gówno pewnie nie skompiluje sie poprawnie.\e[0m"
sleep 6

WORK_DIR="$HOME/box86_build"
[[ -d $WORK_DIR ]] && rm -r $WORK_DIR

mkdir -p "$WORK_DIR"
cd "$WORK_DIR" || exit 1

echo ""
echo "Dodawanie architektury armhf..."
dpkg --add-architecture armhf
dpkg --add-architecture i386

echo ""
echo "Aktualizowanie listy pakietów..."
apt update

echo ""
echo "Instalowanie zależności dla armhf..."
apt install -y libc6:armhf gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf

echo ""
echo "Aktualizowanie systemu..."
apt upgrade -y

echo ""
echo "Instalowanie zależności..."
apt install -y build-essential cmake git
apt install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf

echo ""
echo "Klonowanie repozytorium Box86 z GitHuba..."
git clone https://github.com/ptitSeb/box86.git || {
    echo ""
    echo "Nie udało się sklonować repozytorium."
    exit 1
}

cd box86
mkdir -p build && cd build

echo ""
echo "Konfigurowanie CMake..."

export CC=/usr/bin/arm-linux-gnueabihf-gcc
export CXX=/usr/bin/arm-linux-gnueabihf-g++

cmake .. -DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo || {
    echo "Konfiguracja CMake nie powiodła się."
    exit 1
}

echo ""
echo "Kompilowanie Box86..."
make clean
make -j"$(nproc)" || {
    echo ""
    echo "Kompilacja Box86 nie powiodła się."
    exit 1
}

echo ""
echo "Instalowanie Box86..."
make install || {
    echo ""
    echo "Instalacja Box86 nie powiodła się."
    exit 1
}

echo ""
echo "Aktualizacja dynamicznego linkera..."
ldconfig

echo ""
echo "Restartowanie systemd-binfmt..."
systemctl restart systemd-binfmt || {
    echo ""
    echo "Nie udało się zrestartować systemd-binfmt. Sprawdź logi."
    exit 1
}

echo ""
echo "Box86 został pomyślnie zainstalowany!"
