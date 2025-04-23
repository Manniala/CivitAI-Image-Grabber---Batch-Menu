@echo off
set "base=image_downloads\Model_ID_Search"

for /d %%A in ("%base%\model_*") do (
    set "folder=%%~nxA"
    call :create_url "%%A" "%%~nxA"
)
goto :eof

:create_url
setlocal
set "dir=%~1"
set "name=%~2"
set "id=%name:model_=%"
(
    echo [InternetShortcut]
    echo URL=https://civitai.com/models/%id%
) > "%base%\Model ID %id%.url"
endlocal
goto :eof
