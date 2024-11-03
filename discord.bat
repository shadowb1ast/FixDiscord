@echo off
chcp 65001 >nul
cd /d "%~dp0"

set BIN=%~dp0bin\
set LOGFILE=%~dp0log.txt

if not exist "%BIN%winws.exe" (
    echo Ошибка: Файл winws.exe не найден! >> "%LOGFILE%"
    exit /b
)

if not exist "list-discord.txt" (
    echo Ошибка: Файл list-discord.txt не найден! >> "%LOGFILE%"
    exit /b
)

if not exist "%BIN%quic_initial_www_google_com.bin" (
    echo Ошибка: Файл quic_initial_www_google_com.bin не найден! >> "%LOGFILE%"
    exit /b
)

if not exist "%BIN%tls_clienthello_www_google_com.bin" (
    echo Ошибка: Файл tls_clienthello_www_google_com.bin не найден! >> "%LOGFILE%"
    exit /b
)

echo Запуск приложения %date% %time% >> "%LOGFILE%"
start "poshel naxyi rkn" /min "%BIN%winws.exe" --wf-tcp=443 --wf-udp=443,50000-50100 ^
--filter-udp=443 --hostlist="list-discord.txt" --dpi-desync=fake --dpi-desync-repeats=1 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-50100 --ipset="ipset-discord.txt" --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=1 --new ^
--filter-tcp=443 --hostlist="list-discord.txt" --dpi-desync=fake,split --dpi-desync-autottl=1 --dpi-desync-repeats=1 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" >> "%LOGFILE%" 2>&1

echo Завершение скрипта %date% %time% >> "%LOGFILE%"
