@echo off

echo.
echo %yellow_fg_strong% If you get an error, you may need to run
echo %green_fg_strong% pip install requests beautifulsoup4%reset%
echo.

python Scripts\fetch_model_titles.py

pause
