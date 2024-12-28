#!/bin/bash
# Autorem jest ChatGPT wraz z Indianem
set -e

if [[ $EUID -ne 0 ]]; then
   echo ""
   echo -e "\e[31mUruchom ten skrypt jako root lub za pomocą sudo.\e[0m"
   exit 1
fi

WORK_DIR="$HOME/box86_build"
[[ -d $WORK_DIR ]] && rm -r $WORK_DIR

mkdir -p "$WORK_DIR"
cd "$WORK_DIR" || exit 1

echo ""
echo "Dodawanie architektury..."
dpkg --add-architecture armhf && apt-get update
apt-get install libc6:armhf -y
apt install gcc-arm-linux-gnueabihf -y

echo ""
echo "Aktualizowanie systemu..."
apt update && apt upgrade -y

echo ""
echo "Instalowanie zależności..."
apt install -y build-essential cmake git

echo ""
echo "Klonowanie repozytorium Box86 z GitHuba..."
git clone https://github.com/ptitSeb/box86.git || {
    echo "Nie udało się sklonować repozytorium."
    exit 1
}

cd box86
mkdir -p build && cd build

echo ""
echo "Konfigurowanie CMake..."
cmake .. -D RPI5ARM64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo -DARM_DYNAREC=ON || {
    echo "Konfiguracja CMake nie powiodła się."
    exit 1
}

echo ""
echo "Kompilowanie Box86..."
make -j"$(nproc)" || {
   echo ""
    echo "Kompilacja Box64 nie powiodła się."
    exit 1
}

echo ""
echo "Instalowanie Box86..."
make install

echo ""
echo "Aktualizacja dynamicznego linkera..."
ldconfig

echo ""
echo "Restartowanie systemd-binfmt..."
systemctl restart systemd-binfmt || {
    echo "Nie udało się zrestartować systemd-binfmt. Sprawdź logi."
    exit 1
}

echo ""
echo "Box86 został pomyślnie zainstalowany!"
