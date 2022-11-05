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
shutdown -t 5 -r
)
