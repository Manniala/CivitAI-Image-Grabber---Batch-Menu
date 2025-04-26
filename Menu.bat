@echo off
setlocal EnableDelayedExpansion

:Menu

title CivitAI Download Launcher Menu v1.2

REM Define color codes
set "reset=[0m"
set "darkgray_fg_strong=[90m"
set "red_fg_strong=[91m"
set "green_fg_strong=[92m"
set "yellow_fg_strong=[93m"
set "blue_fg_strong=[94m"
set "cyan_fg_strong=[96m"
set "white_fg_strong=[97m"
set "grey_fg_strong=[99m"

REM Initialize menu index
cls
set /a index=1

REM === Read current wait time from Scripts\wait_time.txt ===
set WAIT_TIME_DEFAULT=Not Set 
if exist "Scripts\wait_time.txt" (
    set /p WAIT_TIME=<"Scripts\wait_time.txt"
) else (
    set WAIT_TIME=%WAIT_TIME_DEFAULT%
)

echo.
echo %cyan_fg_strong%Current Wait Time is set to: %green_fg_strong%%WAIT_TIME%%cyan_fg_strong%seconds%reset%
echo.

REM Display title with color
echo %blue_fg_strong%Select a menu item to run %reset%
echo %cyan_fg_strong%_____________________________________________________%reset%
echo.

REM Loop through .bat files ending in -menu.bat
for %%f in (Scripts/*.bat) do (
    set "file[!index!]=%%~nf"
    echo %yellow_fg_strong% !index!%reset%. %grey_fg_strong%%%~nf%reset%
    set /a index+=1
)

REM Prompt user for a choice
set /a maxIndex=index-1
echo %cyan_fg_strong%_____________________________________________________%reset%
echo.
set /p choice=%green_fg_strong%Select an option (1-%maxIndex%): %reset%


REM Check if the choice is valid and run the corresponding .bat file
if %choice% GEQ 1 if %choice% LEQ %maxIndex% (
    set "selectedFile=!file[%choice%]!"
    call "Scripts\!selectedFile!.bat"
) else (
    echo %red_fg_strong%Invalid selection. Exiting.%reset%
)



goto Menu

endlocal


