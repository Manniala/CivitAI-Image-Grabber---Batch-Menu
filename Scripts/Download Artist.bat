@echo off
cls
setlocal enabledelayedexpansion

REM === Define color codes ===
set "reset=[0m"
set "red_fg_strong=[91m"
set "green_fg_strong=[92m"
set "yellow_fg_strong=[93m"
set "blue_fg_strong=[94m"
set "cyan_fg_strong=[96m"
set "grey_fg_strong=[99m"

REM === ESC support for ANSI colors in Windows Terminal ===
for /f "delims=" %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"

REM === Read wait time ===
set /p WAIT_SECONDS=<"%~dp0wait_time.txt"

REM === Path to artist folder and log ===
set "ARTIST_PATH=%~dp0Artist\"
set "LOG_FILE=%~dp0Download Artist Log.txt"

echo.
echo %blue_fg_strong%Select an %green_fg_strong%Artist %blue_fg_strong%list to run:%reset%
echo %cyan_fg_strong%_____________________________________________________%reset%
echo.

REM === List artist files and any previous run time ===
set index=0
for %%F in ("%ARTIST_PATH%*.txt") do (
    set /a index+=1
    set "file[!index!]=%%~nxF"
    set "display[!index!]=%%~nF"
)

set "maxIndex=%index%"

for /L %%i in (1,1,%maxIndex%) do (
    set "entry=!file[%%i]!"
    set "timestamp="
    for /f "tokens=1,* delims==" %%a in ('findstr /i /c:"!entry!" "%LOG_FILE%" 2^>nul') do (
        if /i "%%a"=="!entry!" set "timestamp=%%b"
    )
    if defined timestamp (
        echo  %yellow_fg_strong%%%i.%reset% %grey_fg_strong% !display[%%i]!%green_fg_strong% !timestamp!%reset%
    ) else (
        echo %yellow_fg_strong% %%i.%reset% %grey_fg_strong% !display[%%i]! %red_fg_strong%Never run%reset%
    )
)

if %maxIndex% EQU 0 (
    echo No artist .txt files found!
    pause
    goto :eof
)

echo.
set /p choice=Enter number: 
if not defined choice (
    echo %red_fg_strong%No input given. Exiting...%reset%
    pause
    goto :eof
)

set /a choice_num=%choice% 2>nul
if %choice_num% GEQ 1 if %choice_num% LEQ %maxIndex% (
    set "selectedFile=!file[%choice_num%]!"
    echo.
    echo %yellow_fg_strong%Using file: %green_fg_strong%!selectedFile!%reset%
    echo.
) else (
    echo %red_fg_strong%Invalid selection: %choice%.%reset%
    pause
    goto :eof
)

REM === Load usernames from selected file ===
set i=0
for /f "usebackq tokens=* delims=" %%A in ("%ARTIST_PATH%!selectedFile!") do (
    set /a i+=1
    set "artist[!i!]=%%A"
)
set /a total=%i%

REM === Download loop ===
for /L %%i in (1,1,%total%) do (
    set "current=!artist[%%i]!"
    echo ---------------------------------
    echo %yellow_fg_strong%Downloading from: %green_fg_strong%!current!%reset%
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

REM === Log the run time ===
for /f "delims=" %%l in ('findstr /v /i /c:"!selectedFile!" "%LOG_FILE%" 2^>nul') do echo %%l >> "%LOG_FILE%.tmp"
>nul copy /y "%LOG_FILE%.tmp" "%LOG_FILE%" >nul
del "%LOG_FILE%.tmp" >nul 2>&1
echo !selectedFile!=%DATE% %TIME:~0,8%>>"%LOG_FILE%"

echo.
echo %green_fg_strong%All downloads complete...%reset%

goto menu
pause