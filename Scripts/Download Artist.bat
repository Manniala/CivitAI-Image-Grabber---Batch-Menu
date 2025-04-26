@echo off
cls
setlocal enabledelayedexpansion

REM === Define color codes ===
set "reset=[0m"
set "darkgray_fg_strong=[90m"
set "red_fg_strong=[91m"
set "green_fg_strong=[92m"
set "yellow_fg_strong=[93m"
set "blue_fg_strong=[94m"
set "cyan_fg_strong=[96m"
set "white_fg_strong=[97m"
set "grey_fg_strong=[99m"

REM === ESC support for ANSI colors in Windows Terminal ===
for /f "delims=" %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"

REM === Read wait time ===
set /p WAIT_SECONDS=<"%~dp0wait_time.txt"

REM === Read current wait time from Scripts\wait_time.txt ===
set WAIT_TIME_DEFAULT=Not Set 
if exist "Scripts\wait_time.txt" (
    set /p WAIT_TIME=<"Scripts\wait_time.txt"
) else (
    set WAIT_TIME=%WAIT_TIME_DEFAULT%
)

echo.
echo %cyan_fg_strong%Current Wait Time is set to: %green_fg_strong%%WAIT_TIME%%cyan_fg_strong%seconds%reset%

REM === Path to artist .txt folder ===
set "ARTIST_PATH=%~dp0Artist\"

REM === Find all .txt files in Scripts\Artist\ ===
echo.
echo %blue_fg_strong%Select an %green_fg_strong%Artist %blue_fg_strong%list to run:%reset%
echo %cyan_fg_strong%_____________________________________________________%reset%
echo.
set index=0

for %%F in ("%ARTIST_PATH%*.txt") do (
    set /a index+=1
    set "file[!index!]=%%~nxF"
    set "display[!index!]=%%~nF"
)

for /L %%i in (1,1,!index!) do (
    echo  %yellow_fg_strong% %%i.%reset% %grey_fg_strong%!display[%%i]!
)

if !index! EQU 0 (
    echo %red_fg_strong%No .txt files found in Scripts\Artist\%reset%
    echo.
    pause
    exit /b
)

echo.
set /p choice=%green_fg_strong%Enter number: %reset%
set "selectedFile=!file[%choice%]!"

if not defined selectedFile (
    echo %red_fg_strong%Invalid selection.%reset%
    pause
    exit /b
)

echo.
echo %yellow_fg_strong%Using file: %green_fg_strong%!selectedFile!%reset%
echo.

REM === Load artists from selected file ===
set i=0
for /f "usebackq tokens=* delims=" %%A in ("%ARTIST_PATH%!selectedFile!") do (
    set /a i+=1
    set "artist[!i!]=%%A"
)
set /a total=%i%

REM === Run download loop with delay and preview ===
for /L %%i in (1,1,%total%) do (
    set "current=!artist[%%i]!"
    echo ---------------------------------
    echo %yellow_fg_strong%Downloading from: %green_fg_strong%!artist[%%i]! %reset%
    echo ---------------------------------
    python "%~dp0..\civit_image_downloader.py" --timeout 60 --quality 1 --redownload 2 --mode 1 --username "!current!" --semaphore_limit 5 --retries 2
    echo.

    if %%i lss %total% (
        set /a next=%%i+1
        set "next_artist=!artist[%next%]!"
        echo %yellow_fg_strong%Waiting %red_fg_strong%!WAIT_SECONDS! %yellow_fg_strong%seconds before next artist: %green_fg_strong!!next_artist!!%reset%
        timeout /t !WAIT_SECONDS! /nobreak >nul
        echo.
    )
)

echo.
echo %green_fg_strong%All downloads complete...%reset%
pause
