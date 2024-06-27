##!/bin/bash

# Paketquellen aktualisieren und Systemupgrade durchführen
apt update && apt upgrade -y

# Benötigte Pakete installieren
apt install apt-transport-https ca-certificates gnupg-agent software-properties-common -y

# Docker-Repository zur Paketquelle hinzufügen
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update

# Docker installieren
apt install docker-ce docker-ce-cli containerd.io -y

# Docker-Volume für Nginx Proxy Manager erstellen
docker volume create npm_data

# Nginx Proxy Manager Container starten
docker run -d -p 80:80 -p 81:81 -p 443:443 --name npm --restart=always -v npm_data:/data -v /etc/letsencrypt:/etc/letsencrypt jc21/nginx-proxy-manager:latest

# Hinweis zur Erreichbarkeit des Nginx Proxy Managers anzeigen
IP=$(hostname -I | awk '{print $1}')
echo -e "\n\n##############################################"
echo "Installation abgeschlossen. Du kannst jetzt auf die Nginx Proxy Manager-Web-Oberfläche zugreifen:"
echo "http://$IP:81"
echo "#####################################################"
