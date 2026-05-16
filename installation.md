# **Inlämningsuppgift 1**

Här redogörs stegen som togs för att sätta apacheservern

## **1. Virtualisering**

* **Åtgärd:** Jag har installerat Virtual Box i värdatorn som kör Linux Mint
* **Kommando (på Linux Mint-värd):**

```bash
sudo apt install virtualbox-qt
```

## **2. Installation av Ubuntu Server VM**

* **Åtgärd:** Laddade ner den officiella .iso för Ubuntu Server LTS från Ubuntus webbplats.
* **Åtgärd:** Skapade en ny virtuell maskin i VirtualBox.
* **Konfiguration:**
  * **Nätverk:** Ställde in VM:ens nätverksadapter till **"Bridged Adapter"**
    * **Syfte:** Detta ansluter den virtuella maskinen direkt till det lokala nätverket, vilket gör att den kan få sin egen IP-adress från routern och vara tillgänglig för andra enheter på nätverket, precis som en fysisk maskin.
    * **Installation:** Installerade Ubuntu Server på den virtuella maskinen med den nedladdade iso-filen.

## **3. Användar- och Behörighetshantering**

* **Åtgärd:** Skapade en ny användare utan root-privilegier för serveradministration.
* **Kommando (på Servern):** `sudo adduser beaver`

* **Åtgärd:** Gav den nya användaren administrativa rättigheter.
* **Kommando (på Servern):**

```bash
sudo usermod -aG sudo beaver
```

## **4. Konfiguration av Secure Shell (SSH)-åtkomst**

* **Åtgärd:** Genererade ett nytt SSH-nyckelpar på den lokala värddatorn.
* **Kommando (på Linux Mint-värd):**

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_beaver -N "skrev lösenordet här"
```

* **Åtgärd:** Kopierade den publika nyckeln till servern för att auktorisera den nya nyckeln för `beaver`-kontot.
* **Kommando (på Linux Mint-värd):** `ssh-copy-id -i ~/.ssh/id_ed25519_beaver.pub beaver@<serverns_ip_adress>`
* **Åtgärd:** Satte upp VirtualBox port forwarding så att jag kunde ansluta till servern via SSH från värddatorn.
* **Kommando (på Linux Mint-värd):** Ställde in port forwarding i VirtualBox från port 22 på servern till port 2222 på värddatorn.

```bash
nano ~/.ssh/config
```

* **Åtgärd:** La till följande block i SSH-konfigurationsfilen på värddatorn för att underlätta anslutning till servern.

```text
Host nest
    HostName localhost
    User beaver
    Port 2222
```

* **syfte:** Detta gör att jag kan ansluta till servern genom att helt enkelt skriva 'ssh nest' i terminalen på värddatorn.

## **5. Installera Apache på Ubuntu Server**

* **Åtgärd:** Installerade Apache på servern via apt.
* **Kommando (på Servern):**

```bash
sudo apt update
sudo apt upgrade
sudo apt install apache2

```

## **6. Ändra och flytta index.html**

* **Åtgärd:** ändrade `html-filen för att visa mitt github-användarnamn istället för "Username".
* **Åtgärd:** Använde scp för att överföra filen `index.html` från värddatorn till servern.
* **Kommando (på Linux Mint-värd):**

```bash
scp index.html nest:~/
```

* **kommando (på Servern):** Flyttade `index.html` till Apache's standardwebbkatalog.

```bash
sudo mv ~/index.html /srv/www/index.html
```

## **7. Hantera kataloger**

* **Åtgärd:** Skapade en katalog för webbplatsens filer enligt FHS 3.0 standard.
* **Kommando (på Servern):**

```bash
sudo mkdir -p /srv/www
```

## Konfigurera servern

* **Åtgärd:** Ändrade severns konfiguration så att den kollar på rätt directory och har rätt behörigheter.
* **Kommando (på servern genom SSH):**

```bash
sudo chown -R www-data:www-data /srv/www
sudo chmod -R 755 /srv/www
sudo systemctl reload apache2
```

* **åtgärd:** Öppnade configurationen i nano och gjorde ändringarna.
* **Kommando (på Servern):**

```bash
sudo nano /etc/apache2/sites-available/000-default.conf
```

* **åtgärd:** Ändrade Apache's konfiguration för att använda den nya katalogen som webbrot.
* Redigerade `/etc/apache2/sites-available/000-default.conf` och ändrade `DocumentRoot` till `/srv/www`.
* La till följande block i configurationen för att ge apache åtkomst till katalogen:

```text
<Directory /srv/www>
    Require all granted
</Directory>
```

## **8. Testa servern**

* **Åtgärd:** Startade om Apache för att tillämpa ändringarna.
* **Kommando (på Servern):**

```bash
sudo systemctl restart apache2
```

* **Åtgärd:** Testade att komma åt servern via webbläsaren på värddatorn genom att navigera till `http://localhost:8888` där jag hade ställt in port forwarding i VirtualBox från port 80 på servern till port 8888 på värddatorn.

* **Resultat:** Jag kunde se innehållet i `index.html` som jag hade flyttat till servern och det visas i skärmdumpen nedan.
* **Skärmdump:** ![Skärmdump av webbläsaren som visar index.html](apache.png)

## **9. Redogör för viktiga logg filer**

* **Åtgärd:** Jag kollade i Apache's loggfiler för att se om det fanns några fel eller varningar.
* **Kommando (på Servern):**

```bash
sudo tail -f /var/log/apache2/error.log
```

* **Resultat:** Jag kunde se att det inte fanns några fel eller kritiska varningar i loggfilen, vilket indikerar att servern körs korrekt och att mina ändringar inte har orsakat några problem. Jag hittade däremot en varning om att DNS servern inte kunde hitta IP-addressen genom DNS, vilket är förväntat eftersom jag inte har ställt in en DNS-post för servern. Detta påverkar dock inte serverns funktion som behövs för denna uppgift.

* **åtgärd:** Jag kollade även i access loggen för att se om det fanns några förfrågningar till servern.

```bash
beaver@nest:~$ sudo tail /var/log/apache2/access.log
10.0.2.2 - - [02/May/2026:11:34:02 +0000] "GET / HTTP/1.1" 200 1527 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:150.0) Gecko/20100101 Firefox/150.0"
```

* **Resultat:** Som förväntat kunde jag se en GET-förfrågan till servern i access loggen, vilket indikerar att min webbläsare har kommunicerat med servern och att den har svarat korrekt med statuskod 200.
