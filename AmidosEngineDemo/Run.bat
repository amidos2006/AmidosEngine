@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat

:desktop-run
echo.
echo Starting AIR Debug Launcher with screen size '%SCREEN_SIZE%'
echo.
echo (hint: edit 'Run.bat' to test on device or change screen size)
echo.
adl "%APP_XML%" "%APP_DIR%"
if errorlevel 1 goto error
goto end

:error
pause
