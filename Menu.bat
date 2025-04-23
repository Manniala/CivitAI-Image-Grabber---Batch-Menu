@echo off
setlocal EnableDelayedExpansion

:Menu

title CivitAI Download Launcher Menu

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

REM Display title with color
echo %blue_fg_strong% Select a menu item to run %reset%
echo %cyan_fg_strong%_____________________________%reset%
echo.

REM Loop through .bat files ending in -menu.bat
for %%f in (Scripts/*.bat) do (
    set "file[!index!]=%%~nf"
    echo %yellow_fg_strong% !index!%reset%. %grey_fg_strong%%%~nf%reset%
    set /a index+=1
)

REM Prompt user for a choice
set /a maxIndex=index-1
echo %cyan_fg_strong%_____________________________%reset%
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


