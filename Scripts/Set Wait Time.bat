@echo off
echo.
set /p wait="Enter wait time in seconds between downloads: "
echo %wait% > "%~dp0wait_time.txt"
echo.
echo %yellow_fg_strong%Wait time saved to Scripts\wait_time.txt: %green_fg_strong%%wait%%reset% %yellow_fg_strong%seconds%reset%
echo.
pause
