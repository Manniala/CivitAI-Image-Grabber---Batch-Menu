@echo off
setlocal EnableDelayedExpansion

set "CFG_FILE=Scripts\Backup.cfg"

REM Ensure the Scripts folder exists
if not exist "Scripts" (
    mkdir "Scripts"
)

REM If config file doesn't exist, create it with Disabled
if not exist "%CFG_FILE%" (
    echo|set /p=Disabled > "%CFG_FILE%"
)

REM Read current state and trim it
set "CURRENT_STATE="
for /f "usebackq tokens=* delims=" %%A in ("%CFG_FILE%") do set "CURRENT_STATE=%%A"

REM Remove any stray carriage return or space characters
set "CURRENT_STATE=!CURRENT_STATE: =!"
set "CURRENT_STATE=!CURRENT_STATE:`r=!"

REM Debug output
echo [DEBUG] Current state is: [!CURRENT_STATE!]

REM Toggle logic
if /i "!CURRENT_STATE!"=="Enabled" (
    echo|set /p=Disabled > "%CFG_FILE%"
    echo Toggled to Disabled.
) else (
    echo|set /p=Enabled > "%CFG_FILE%"
    echo Toggled to Enabled.
)

endlocal
