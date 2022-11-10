@echo off

:START
REG QUERY HKLM\SOFTWARE\Brakar\Background /v BrakarBackground

IF %errorlevel%==1 GOTO INSTALL
IF %errorlevel%==0 GOTO DIE

:INSTALL
echo Installing....
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d C:\ProgramData\CustomScripts\BrakarBackground.png /f 
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Brakar\Background" /V BrakarBackground /T REG_DWORD /d "1" /F
GOTO DIE

:DIE
echo Installed
EXIT /b 1
