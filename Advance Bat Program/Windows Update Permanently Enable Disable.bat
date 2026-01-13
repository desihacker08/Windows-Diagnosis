@echo off
color 0a
title Windows Update Controller - Desi Hacker Solution
setlocal EnableDelayedExpansion

:: Check for Admin Rights
net session >nul 2>&1
if %errorLevel% neq 0 (
	echo Hello %USERNAME%
    echo [!] ERROR: YOU MUST RUN AS ADMINISTRATOR.
    echo Please right-click the file and 'Run as Administrator'.
    pause
    exit
)

:: Get console width
for /f "tokens=2 delims=:" %%a in ('mode con ^| find "Columns"') do set cols=%%a
set cols=!cols: =!

:: Banner width (36 chars)
set bannerWidth=46
set /a pad=(cols-bannerWidth)/2

:: Build spaces
set "spaces="
for /L %%i in (1,1,!pad!) do set "spaces=!spaces! "

:banner
cls
echo.
echo !spaces!##################################################
echo !spaces!#                                                #
echo !spaces!#        WINDOWS  UPDATE  ENABLE/DISABLE         #
echo !spaces!#             DEVELOPER: [DESI HACKER]           #
echo !spaces!#                                                #
echo !spaces!##################################################
echo.
echo !spaces!==== GITHUB: https://github.com/desihacker08 =====
echo !spaces!           -  WinDows Update Control  -
echo !spaces!==================================================
echo.
pause


:menu
cls
echo ================= MENU =================
echo 1. Disable Windows Update (Permanent)
echo 2. Enable Windows Update
echo 3. Exit
echo ========================================
set /p choice="Enter your choice (1/2/3): "

if "%choice%"=="1" goto disable
if "%choice%"=="2" goto enable
if "%choice%"=="3" exit
goto menu

:disable
call :loading "Disabling Windows Update..."
net stop wuauserv >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1

net stop bits >nul 2>&1
sc config bits start= disabled >nul 2>&1

net stop UsoSvc >nul 2>&1
sc config UsoSvc start= disabled >nul 2>&1

net stop dosvc >nul 2>&1
sc config dosvc start= disabled >nul 2>&1

call :flash ">>> WINDOWS UPDATE DISABLED PERMANENTLY! <<<"
pause
goto menu

:enable
call :loading "Enabling Windows Update..."
sc config wuauserv start= demand >nul 2>&1
net start wuauserv >nul 2>&1

sc config bits start= demand >nul 2>&1
net start bits >nul 2>&1

sc config UsoSvc start= demand >nul 2>&1
net start UsoSvc >nul 2>&1

sc config dosvc start= demand >nul 2>&1
net start dosvc >nul 2>&1

call :flash ">>> WINDOWS UPDATE ENABLED! <<<"
pause
goto menu

:: Loading animation
:loading
cls
setlocal ENABLEDELAYEDEXPANSION
set "msg=%~1"
for /l %%i in (1,1,3) do (
    echo %msg%
    echo.
    echo Loading.
    ping -n 1 localhost >nul
    cls
    echo %msg%
    echo.
    echo Loading..
    ping -n 1 localhost >nul
    cls
    echo %msg%
    echo.
    echo Loading...
    ping -n 1 localhost >nul
    cls
)
endlocal
exit /b

:: Flashing text effect
:flash
for /l %%i in (1,1,5) do (
    cls
    echo %~1
    powershell -c "[console]::beep(800,200)"
    ping -n 1 localhost >nul
    cls
    ping -n 1 localhost >nul
)
exit /b