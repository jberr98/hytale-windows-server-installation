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
.\hytale-downloader-windows-amd64.exe -version > downloader-version.txt
:: Just outputs the hytale server version, not necessary
.\hytale-downloader-windows-amd64.exe -print-version > game-version.txt

mkdir Backups

:: Creates bat file that starts the server with: Caching to boot the server faster, minimum amount of memory 4G, authenticated server and makes the server use the port 5520
echo java -XX:AOTCache=Server\HytaleServer.aot -Xms4G -jar Server/HytaleServer.jar --assets Assets.zip --auth-mode authenticated --backup --backup-dir .\Backups --bind 0.0.0.0:5520 > start_server.bat

:: Creates bat script to update the server
(
echo @echo OFF
echo echo Starting update process
echo .\hytale-downloader-windows-amd64.exe -download-path hytale-server.zip
echo tar -xf hytale-server.zip
echo del hytale-server.zip
echo.
echo :: Just outputs the hytale downloader version, not necessary
echo .\hytale-downloader-windows-amd64.exe -version ^> downloader-version.txt
echo :: Just outputs the hytale server version, not necessary
echo .\hytale-downloader-windows-amd64.exe -print-version ^> game-version.txt
echo.
echo echo Update finished
echo pause
) > update_server.bat

:: Prevents people from unknowingly uploading their credentials by accident, you can ignore or delete the file if you are not planning on uploading the server, but recommend leaving it just in case
echo .hytale-downloader-credentials.json > .gitignore

echo Done! Server ready

pause

