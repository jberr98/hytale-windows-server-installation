@echo OFF
:: Hytale Server bat script for Windows server
:: It relies on an empty folder. Gets the basics to setup a Hytale server.

set DOWNLOAD_URL=https://downloader.hytale.com/hytale-downloader.zip

echo Downloading Hytale downloader
curl -O %DOWNLOAD_URL%

tar -xf hytale-downloader.zip
del hytale-downloader.zip

echo Starting Hytale Downloader
.\hytale-downloader-windows-amd64.exe -download-path hytale-server.zip

echo Unarchiving server
tar -xf hytale-server.zip
del hytale-server.zip

:: Script used for Windows. Doesn't need Linux binary in this case.
del hytale-downloader-linux-amd64

:: Just outputs the hytale downloader version, not necessary
.\hytale-downloader-windows-amd64.exe -version > version.txt

:: Creates bat file that starts the server with: Caching to boot the server faster, minimum amount of memory 128Mb, authenticated server and makes the server use the port 5520
echo java -XX:AOTCache=Server\HytaleServer.aot -Xms128M -jar Server/HytaleServer.jar --assets Assets.zip --auth-mode authenticated --backup --bind 0.0.0.0:5520 > start_server.bat

echo Done! Server ready

pause
