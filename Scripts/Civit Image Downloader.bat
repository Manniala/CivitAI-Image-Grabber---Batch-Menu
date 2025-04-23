@echo off
setlocal enabledelayedexpansion

REM Change to parent directory of the current script
cd /d "%~dp0.."

REM Run the Python script
python civit_image_downloader.py

pause