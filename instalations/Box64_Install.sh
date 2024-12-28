#!/bin/bash
# Autorem jest ChatGPT wraz z Indianem
set -e

# Sprawdzanie uprawnień
if [[ $EUID -ne 0 ]]; then
   echo ""
   echo -e "\e[31mUruchom ten skrypt jako root lub za pomocą sudo.\e[0m"
   exit 1
fi

# Zmienna dla folderu roboczego
WORK_DIR="$HOME/box64_build"
[[ -d $WORK_DIR ]] && rm -r $WORK_DIR

# Tworzenie folderu roboczego
mkdir -p "$WORK_DIR"
cd "$WORK_DIR" || exit 1

# Aktualizacja systemu
echo ""
echo "Aktualizowanie systemu..."
apt update && apt upgrade -y

# Instalowanie zależności
echo ""
echo "Instalowanie zależności..."
apt install -y build-essential cmake git

# Klonowanie repozytorium Box64 z GitHuba
echo ""
echo "Klonowanie repozytorium Box64 z GitHuba..."
git clone https://github.com/ptitSeb/box64.git || {
    echo ""
    echo "Nie udało się sklonować repozytorium."
    exit 1
}

# Przechodzenie do folderu Box64
cd box64 || exit 1

# Tworzenie folderu build
mkdir -p build && cd build

# Konfiguracja CMake
echo ""
echo "Konfigurowanie CMake..."
cmake .. -D RPI5ARM64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo -DARM_DYNAREC=ON || {
    echo "Konfiguracja CMake nie powiodła się."
    exit 1
}

# Kompilacja
echo ""
make -j"$(nproc)" || {
   echo ""
    echo "Kompilacja Box64 nie powiodła się."
    exit 1
}

# Instalacja
echo ""
echo "Instalowanie Box64..."
make install || {
    echo "Instalacja Box64 nie powiodła się."
    exit 1
}

# Aktualizacja dynamicznego linkera
echo ""
echo "Aktualizacja dynamicznego linkera..."
ldconfig

# Restartowanie systemd-binfmt
echo ""
echo "Restartowanie systemd-binfmt..."
systemctl restart systemd-binfmt || {
    echo "Nie udało się zrestartować systemd-binfmt. Sprawdź logi."
    exit 1
}

echo ""
echo "Box64 został pomyślnie zainstalowany!"
