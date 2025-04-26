@echo off
:edit_Artist
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

REM === Path to Artist folder ===
set "ARTIST_PATH=%~dp0Artist\"

echo.
echo.
echo.
echo %blue_fg_strong%Select a %green_fg_strong%Artist %blue_fg_strong%list to edit:%reset%
echo %cyan_fg_strong%_____________________________________________________%reset%
echo.

set index=0

for %%F in ("%ARTIST_PATH%*.txt") do (
    set /a index+=1
    set "file[!index!]=%%~nxF"
    set "display[!index!]=%%~nF"
)

set "maxIndex=%index%"

for /L %%i in (1,1,%maxIndex%) do (
    echo  %yellow_fg_strong% %%i.%reset% %grey_fg_strong%!display[%%i]!
)

if %maxIndex% EQU 0 (
    echo.
    echo No Artist .txt files found!
    pause
    exit /b
)

echo.
set /p choice=Enter number: 

REM === Validate range ===
if %choice% GEQ 1 if %choice% LEQ %maxIndex% (
    set "selectedFile=!file[%choice%]!"
    echo Opening: !selectedFile!
    start "" "%ARTIST_PATH%!selectedFile!"
) else (
    echo.
    echo %red_fg_strong%Invalid selection. Exiting...%reset%
    echo.
    pause
    goto edit_Artist
    exit /b
)
