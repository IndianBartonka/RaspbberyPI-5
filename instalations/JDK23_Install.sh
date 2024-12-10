#!/bin/bash
# Autorem jest ChatGPT

# Definiowanie URL do pliku JDK
JDK_URL="https://github.com/adoptium/temurin23-binaries/releases/download/jdk-23.0.1%2B11/OpenJDK23U-jdk_aarch64_linux_hotspot_23.0.1_11.tar.gz"
JDK_DIR="/opt/jdk-23.0.1"

# Pobieranie pliku JDK
echo ""
echo "Pobieranie JDK 23.0.1..."
wget -q --show-progress "$JDK_URL" -O /tmp/jdk-23.0.1.tar.gz

# Sprawdzanie czy pobieranie się powiodło
if [ $? -ne 0 ]; then
    echo ""
    echo "Błąd podczas pobierania JDK."
    exit 1
fi

# Rozpakowanie pliku
echo ""
echo "Rozpakowywanie JDK..."
sudo mkdir -p "$JDK_DIR"
sudo tar -xzf /tmp/jdk-23.0.1.tar.gz -C "$JDK_DIR" --strip-components=1

# Usunięcie pobranego pliku
rm /tmp/jdk-23.0.1.tar.gz

# Ustawianie zmiennych środowiskowych
echo ""
echo "Ustawianie zmiennych środowiskowych..."
echo "export JAVA_HOME=$JDK_DIR" | sudo tee -a /etc/profile.d/jdk.sh
echo "export PATH=\$JAVA_HOME/bin:\$PATH" | sudo tee -a /etc/profile.d/jdk.sh

# Ładowanie nowych zmiennych środowiskowych
source /etc/profile.d/jdk.sh

# Sprawdzenie wersji Javy
echo ""
echo "Instalacja zakończona. Sprawdzanie wersji JDK..."
java -version

