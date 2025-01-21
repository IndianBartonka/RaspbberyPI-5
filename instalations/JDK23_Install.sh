#!/bin/bash
# Autorem jest ChatGPT
# Skrypt instalujący GraalVM CE

# Definiowanie URL do pliku GraalVM
GRAALVM_URL="https://download.oracle.com/graalvm/23/latest/graalvm-jdk-23_linux-aarch64_bin.tar.gz"
GRAALVM_DIR="/opt/graalvm"

# Pobieranie pliku GraalVM
echo ""
echo "Pobieranie GraalVM..."
wget -q --show-progress "$GRAALVM_URL" -O /tmp/graalvm.tar.gz

# Sprawdzanie czy pobieranie się powiodło
if [ $? -ne 0 ]; then
    echo ""
    echo "Błąd podczas pobierania GraalVM."
    exit 1
fi

# Rozpakowanie pliku
echo ""
echo "Rozpakowywanie GraalVM..."
sudo mkdir -p "$GRAALVM_DIR"
sudo tar -xzf /tmp/graalvm.tar.gz -C "$GRAALVM_DIR" --strip-components=1

# Usunięcie pobranego pliku
rm /tmp/graalvm.tar.gz

# Ustawianie zmiennych środowiskowych
echo ""
echo "Ustawianie zmiennych środowiskowych..."
echo "export JAVA_HOME=$GRAALVM_DIR" | sudo tee /etc/profile.d/graalvm.sh
echo "export PATH=\$JAVA_HOME/bin:\$PATH" | sudo tee -a /etc/profile.d/graalvm.sh

# Ładowanie nowych zmiennych środowiskowych
source /etc/profile.d/graalvm.sh

# Sprawdzenie wersji Javy
echo ""
echo "Instalacja zakończona. Sprawdzanie wersji GraalVM..."
java -version

echo ""
echo "GraalVM został pomyślnie zainstalowany!"
