@echo off
set "base=image_downloads\Username_Search"

for /d %%A in ("%base%\*") do (
    set "folder=%%~nxA"
    call :create_url "%%A" "%%~nxA"
)
goto :eof

:create_url
setlocal
set "dir=%~1"
set "name=%~2"
(
    echo [InternetShortcut]
    echo URL=https://civitai.com/user/%name%
) > "%base%\%name%.url"

endlocal
goto :eof