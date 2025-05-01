@echo off
setlocal EnableDelayedExpansion


title CivitAI Download Launcher Menu v1.21

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

REM -----------------------
REM Backup Sequence
REM -----------------------

:: Set paths
set "SCRIPT_DIR=%~dp0Scripts"
set "CFG_FILE=%SCRIPT_DIR%\backup.cfg"
set "DB_FILE=tracking_database.sqlite"
set "BACKUP_DIR=%~dp0backup"

:: Check if config file exists
if not exist "%CFG_FILE%" (
    echo Config file not found: %CFG_FILE%
    pause
    exit /b
)

:: Read config value
set /p BACKUP_ENABLED=<"%CFG_FILE%"

:: Perform backup if enabled
if "%BACKUP_ENABLED%"=="Enabled " (
    echo %yellow_fg_strong%Backup %green_fg_strong%enabled%yellow_fg_strong%. Creating backup...%reset%

    :: Ensure backup folder exists
    if not exist "%BACKUP_DIR%" (
        mkdir "%BACKUP_DIR%"
    )

    :: Get current date and time
    for /f %%a in ('wmic os get LocalDateTime ^| find "."') do set dt=%%a
    set "YYYY=!dt:~0,4!"
    set "MM=!dt:~4,2!"
    set "DD=!dt:~6,2!"
    set "HH=!dt:~8,2!"
    set "Min=!dt:~10,2!"
    set "Sec=!dt:~12,2!"

    set "TIMESTAMP=!YYYY!-!MM!-!DD!_!HH!-!Min!-!Sec!"

    :: Compose backup filename
    set "BACKUP_FILE=%BACKUP_DIR%\!TIMESTAMP!_tracking_database.sqlite"

    copy /Y "%~dp0%DB_FILE%" "!BACKUP_FILE!" >nul
    echo %yellow_fg_strong%Backup complete:%yellow_fg_strong% %green_fg_strong%!BACKUP_FILE!%reset%
    TIMEOUT /T 4
) else (
   ::echo Backup is disabled.
   goto menu
)

:menu

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


REM === Read current wait time from Scripts\Backup.cfg ===
set BACKUP_DEFAULT=Not Set
if exist "Scripts\Backup.cfg" (
    set /p BACKUP_MODE=<"Scripts\Backup.cfg"
) else (
    set BACKUP_MODE=%BACKUP_DEFAULT%
)

REM === Determine color based on BACKUP_MODE ===
if /i "%BACKUP_MODE%"=="Enabled " (
    set BACKUP_COLOR=%green_fg_strong%
) else if /i "%BACKUP_MODE%"=="Disabled " (
    set BACKUP_COLOR=%red_fg_strong%
) else (
    set BACKUP_COLOR=%yellow_fg_strong%
)





echo.
echo %cyan_fg_strong%Current Wait Time is set to: %green_fg_strong%%WAIT_TIME%%cyan_fg_strong%seconds%reset%
REM === Display the result ===
echo %cyan_fg_strong%Database Backup is currently: %BACKUP_COLOR%%BACKUP_MODE%%cyan_fg_strong% %reset%
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


