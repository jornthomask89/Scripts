reg query HKLM\SOFTWARE\Brakar\FWEK /v ActivationStatus
if %ERRORLEVEL% EQU 0 goto :EXISTS



REG QUERY HKLM\SOFTWARE\Brakar\FWEK /v ActivationStatus

IF %errorlevel%==0 GOTO INSTALL

:INSTALL
@echo off
FOR /F "skip=1" %%A IN ('wmic path SoftwareLicensingService get OA3xOriginalProductKey') DO  (
SET "ProductKey=%%A"
goto InstallKey
)
:InstallKey
IF [%ProductKey%]==[] (
EXIT /b 1
) ELSE (
changepk.exe /ProductKey %ProductKey%
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\FIRMANAVN\FWEK\ /V ActivationStatus /T REG_DWORD /d "1" /F
shutdown -t 30 -r
)
