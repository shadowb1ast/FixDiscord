@echo off
chcp 65001 >nul

cd /d "%~dp0"

set BIN=%~dp0bin\
set PARAMETERS=

if not exist "%BIN%winws.exe" (
    echo Ошибка: Файл winws.exe не найден!
    exit /b
)

if not exist "list-general.txt" (
    echo Ошибка: Файл list-general.txt не найден!
    exit /b
)

if not exist "%BIN%quic_initial_www_google_com.bin" (
    echo Ошибка: Файл quic_initial_www_google_com.bin не найден!
    exit /b
)

if not exist "%BIN%tls_clienthello_www_google_com.bin" (
    echo Ошибка: Файл tls_clienthello_www_google_com.bin не найден!
    exit /b
)

set PARAMETERS=%PARAMETERS% --wf-tcp=80,443
set PARAMETERS=%PARAMETERS% --wf-udp=443,50000-50100
set PARAMETERS=%PARAMETERS% --filter-udp=443 --hostlist="list-general.txt"
set PARAMETERS=%PARAMETERS% --dpi-desync=fake --dpi-desync-repeats=3
set PARAMETERS=%PARAMETERS% --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin"
set PARAMETERS=%PARAMETERS% --new
set PARAMETERS=%PARAMETERS% --filter-udp=50000-50100 --ipset="ipset-discord.txt"
set PARAMETERS=%PARAMETERS% --dpi-desync-any-protocol
set PARAMETERS=%PARAMETERS% --dpi-desync-cutoff=d2
set PARAMETERS=%PARAMETERS% --filter-tcp=80 --hostlist="list-general.txt"
set PARAMETERS=%PARAMETERS% --dpi-desync=fake,split --dpi-desync-autottl=1
set PARAMETERS=%PARAMETERS% --dpi-desync-fooling=badseq
set PARAMETERS=%PARAMETERS% --filter-tcp=443 --hostlist="list-general.txt"
set PARAMETERS=%PARAMETERS% --dpi-desync=fake,split --dpi-desync-autottl=1
set PARAMETERS=%PARAMETERS% --dpi-desync-repeats=3
set PARAMETERS=%PARAMETERS% --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"

start "poshel naxyi rkn by claustrophob" /min "%BIN%winws.exe" %PARAMETERS%
