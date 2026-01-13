@echo off
title DESI HACKER : Internet Blocker
color 0a
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
echo !spaces!#         INTERNET BLOCK ANY APPLICATION         #
echo !spaces!#             DEVELOPER: [DESI HACKER]           #
echo !spaces!#         %date%     %time%         #
echo !spaces!#                                                #
echo !spaces!##################################################
echo.
echo !spaces!==== GITHUB: https://github.com/desihacker08 =====
echo !spaces!           -  Internet firewall network block  -
echo !spaces!==================================================
echo.
pause



:MENU
cls
echo ==========================================
echo        DESI HACKER Program
echo   Internet Control - Firewall Manager
echo     %date% %time% 
echo ==========================================
echo.
echo [1] Block Internet for a Program
echo [2] Unblock Internet for a Program
echo [3] Exit
echo.
set /p choice=Enter your choice (1/2/3): 

if "%choice%"=="1" goto BLOCK
if "%choice%"=="2" goto UNBLOCK
if "%choice%"=="3" exit
goto MENU

:BLOCK
cls
echo ------------------------------------------
echo   BLOCK INTERNET - Enter Program Path
echo ------------------------------------------
set /p progpath=Enter full path of EXE (e.g. C:\Program Files\App\app.exe): 
set /p rulename=Enter a Rule Name (e.g. Block_App): 
echo.
echo Blocking Internet for: %progpath%
netsh advfirewall firewall add rule name="%rulename%" dir=out action=block program="%progpath%" enable=yes
echo Done! Internet BLOCKED for %progpath%.
pause
goto MENU

:UNBLOCK
cls
echo ------------------------------------------
echo   UNBLOCK INTERNET - Delete Rule
echo ------------------------------------------
set /p rulename=Enter Rule Name to Remove (same as used before): 
echo.
echo Removing rule: %rulename%
netsh advfirewall firewall delete rule name="%rulename%"
echo Done! Internet UNBLOCKED for that program.
pause
goto MENU