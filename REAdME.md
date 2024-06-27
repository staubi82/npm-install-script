
### Docker und Nginx Proxy Manager auf Debian installieren und konfigurieren

#### 1. Docker und Nginx Proxy Manager Installations-Skript herunterladen und ausführen

Um Docker und den Nginx Proxy Manager auf Debian zu installieren und zu konfigurieren, führen Sie das folgende Skript aus. Es erledigt alle notwendigen Schritte automatisch:

```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/staubi82/npm-install-script/main/npm-install.sh)"
```

#### 2. Manuelle Schritte zur Installation und Konfiguration

Falls Sie die Schritte manuell durchführen möchten, finden Sie hier die detaillierte Anleitung:

##### a. Paketquellen aktualisieren und Systemupgrade durchführen

Aktualisieren Sie die Paketliste und führen Sie ein Systemupgrade durch:

```bash
apt update && apt upgrade -y
```

##### b. Benötigte Pakete installieren

Installieren Sie die benötigten Pakete:

```bash
apt install apt-transport-https ca-certificates gnupg-agent software-properties-common -y
```

##### c. Docker-Repository hinzufügen

Fügen Sie das Docker-Repository zur Paketquelle hinzu:

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
```

##### d. Docker installieren

Installieren Sie Docker:

```bash
apt install docker-ce docker-ce-cli containerd.io -y
```

##### e. Nginx Proxy Manager einrichten

Erstellen Sie ein Docker-Volume für die Nginx Proxy Manager-Daten:

```bash
docker volume create npm_data
```

Starten Sie den Nginx Proxy Manager-Container:

```bash
docker run -d -p 80:80 -p 81:81 -p 443:443 --name npm --restart=always -v npm_data:/data -v /etc/letsencrypt:/etc/letsencrypt jc21/nginx-proxy-manager:latest
```

#### 3. Zugriff auf die Nginx Proxy Manager Web-Oberfläche

Öffnen Sie Ihren Webbrowser und gehen Sie zur Adresse:

```http
http://[Ihre-IP]:81
```

