sudo nmcli con mod "Połączenie przewodowe 1" ipv4.addresses 192.168.8.131/24 
sudo nmcli con mod "Połączenie przewodowe 1" ipv4.gateway 192.168.8.1 
sudo nmcli con mod "Połączenie przewodowe 1" ipv4.dns 192.168.8.131 
sudo nmcli con mod "Połączenie przewodowe 1" ipv4.method manual 
sudo nmcli con mod "Połączenie przewodowe 1" connection.autoconnect yes 
sudo nmcli con up "Połączenie przewodowe 1"


```
sudo nmcli con mod "Połączenie przewodowe 1" ipv4.addresses 192.168.8.131/24 && sudo nmcli con mod "Połączenie przewodowe 1" ipv4.gateway 192.168.8.1 && sudo nmcli con mod "Połączenie przewodowe 1" ipv4.dns 192.168.8.131 && sudo nmcli con mod "Połączenie przewodowe 1" ipv4.method manual && sudo nmcli con mod "Połączenie przewodowe 1" connection.autoconnect yes && sudo nmcli con up "Połączenie przewodowe 1"
```