:user_configuration

:: Path to Flex SDK
set FLEX_SDK=E:\Tools\Flex SDK 4_6

:: Path to Android SDK
set ANDROID_SDK=E:\Tools\android-sdk


:validation
if not exist "%FLEX_SDK%\bin" goto flexsdk_fix
if not exist "%ANDROID_SDK%\platform-tools" goto androidsdk
goto succeed

:flexsdk_fix
if not exist "%localappdata%\flashdevelop\apps\flexsdk\4.6.0\bin" goto flexsdk
set FLEX_SDK="%localappdata%\flashdevelop\apps\flexsdk\4.6.0\"
goto succeed

:flexsdk
echo.
echo ERROR: incorrect path to Flex SDK in 'bat\SetupSDK.bat'
echo.
echo Looking for: %FLEX_SDK%\bin
echo.
if %PAUSE_ERRORS%==1 pause
exit

:androidsdk
echo.
echo ERROR: incorrect path to Android SDK in 'bat\SetupSDK.bat'
echo.
echo Looking for: %ANDROID_SDK%\platform-tools
echo.
if %PAUSE_ERRORS%==1 pause
exit

:succeed
set PATH=%PATH%;%FLEX_SDK%\bin
set PATH=%PATH%;%ANDROID_SDK%\platform-tools

