@echo off
setlocal enabledelayedexpansion

REM Change to parent directory of the current script
cd /d "%~dp0.."

REM Read the contents of Download_Artist.txt into a variable
set "artist="
for /f "usebackq delims=" %%A in ("Scripts\Download_Artist.txt") do (
    set "artist=%%A"
)

REM Run the Python script
python civit_image_downloader.py --mode 1 --username "!artist!" --quality 1 --redownload 2 --semaphore_limit 10

pause