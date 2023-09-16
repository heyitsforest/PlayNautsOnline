@echo off
setlocal enabledelayedexpansion

echo https://github.com/heyitsforest/PlayNautsOnline

set /p os="1. Linux, 2. Windows or 3. Mac? Enter (1/2/3): "

if !os! equ 1 (
set "csvFilePath=Manifests/Linux_Manifests_230881.txt"
set "appId=204300"
set "depotId=230881"
set os="Linux"
) else if !os! equ 2 (
set "csvFilePath=Manifests/Windows_Manifests_204301.txt"
set "appId=204300"
set "depotId=204301"
set os="Windows"
) else if !os! equ 3 (
set "csvFilePath=Manifests/Mac_Manifests_204302.txt"
set "appId=204300"
set "depotId=204302"
set os="Mac"
) else (
    echo Try again. Please enter 1, 2, or 3.
    goto :eof
)

echo Starting with !os!...


set /p username="Steam username (this will log you out): "
set /p password="Steam password: "

pause

set "logFilePath=AwesomenautsArchiver.log"

if exist "%csvFilePath%" (

    del "%logFilePath%" 2>nul

    for /f "tokens=1,* delims=," %%a in (%csvFilePath%) do (
        REM Get the first column (manifestId)
        set "manifestId=%%a"

        REM Echo the result to the log file
        echo Downloading "-app !appId! -depot !depotId! -manifest !manifestId!" >> "%logFilePath%"


	dotnet DepotDownloader.dll -app !appId! -depot !depotId! -manifest !manifestId! -username !username! -password !password! -dir depots/Awesomenauts/!os!/!manifestId! -remember-password

    )
) else (
    echo CSV file not found: %csvFilePath%
)

REM Add a "pause" command to keep the CMD window open
pause

endlocal
