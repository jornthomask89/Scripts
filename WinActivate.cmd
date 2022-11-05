@echo off
REG QUERY HKLM\SOFTWARE\Brakar\FWEK /v ActivationStatus

IF %errorlevel%==1 (GOTO INSTALL) ELSE (GOTO EXIT)

:INSTALL
FOR /F "skip=1" %%A IN ('wmic path SoftwareLicensingService get OA3xOriginalProductKey') DO  (
SET "ProductKey=%%A"
goto InstallKey
)
:InstallKey
IF [%ProductKey%]==[] (
EXIT /b 1
) ELSE (
changepk.exe /ProductKey %ProductKey%
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Brakar\FWEK\ /V ActivationStatus /T REG_DWORD /d "1" /F
shutdown -t 30 -r
)

:EXIT
EXIT /b 0
