@echo off
REG QUERY "HKCU\Control Panel\Brakar\Background" /v BrakarBackground

IF %errorlevel%==1 (GOTO INSTALL) ELSE (GOTO DIE)

:INSTALL
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d C:\ProgramData\CustomScripts\BrakarBackground.png /f 
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 
REG ADD "HKEY_CURRENT_USER\Control Panel\Brakar\Background" /V BrakarBackground /T REG_SZ /d "True" /F
GOTO DIE

:DIE
EXIT /b 1
