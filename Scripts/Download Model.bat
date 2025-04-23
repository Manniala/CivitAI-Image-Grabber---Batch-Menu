@echo off
setlocal enabledelayedexpansion

REM Change to parent directory of the current script
cd /d "%~dp0.."

REM Read the contents of Download_Model_ID.txt into a variable
set "model_ids="
for /f "usebackq delims=" %%A in ("Scripts\Download_Model_ID.txt") do (
    set "model_ids=%%A"
)

REM Run the Python script
python civit_image_downloader.py --mode 2 --model_id "!model_ids!" --quality 1 --redownload 2

pause