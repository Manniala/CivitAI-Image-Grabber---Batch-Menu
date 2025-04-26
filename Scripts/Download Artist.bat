@echo off
setlocal enabledelayedexpansion

REM Read wait time from Scripts\wait_time.txt
set /p WAIT_SECONDS=<"%~dp0wait_time.txt"

REM Loop through each artist in Download_Artist.txt (one per line)
for /f "usebackq tokens=* delims=" %%A in ("%~dp0Download_Artist.txt") do (
    set "artist=%%A"
    echo ---------------------------------
    echo %yellow_fg_strong%Downloading from: %green_fg_strong%!artist!%reset%
    echo ---------------------------------
    python "%~dp0..\civit_image_downloader.py" --mode 1 --username "!artist!" --redownload 2
    echo.
    echo %yellow_fg_strong%Waiting %red_fg_strong%!WAIT_SECONDS!%yellow_fg_strong%seconds before next artist...%reset%
    timeout /t !WAIT_SECONDS! /nobreak >nul
)

echo.
echo All downloads complete...
pause
