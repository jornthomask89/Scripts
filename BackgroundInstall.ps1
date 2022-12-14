#Test and Add Registry Path
$registryPath = "HKCU:\Control Panel\Brakar\Background"
$Name = "BrakarBackground"
$value = "True"
$WallpaperReg = "HKCU:\Control Panel\Desktop"
$BGname = "Wallpaper"
$BGvalue = "C:\ProgramData\CustomScripts\BrakarBackground.png"


if (!(Test-Path $registryPath)) 
{ 
New-Item -Path $registryPath -ItemType Directory -Force -Confirm:$false 
} 


 # Checks the registry
$regCheck = Get-Item -Path $registryPath
If($regCheck.GetValue("$Name") -eq $value) {
  Write-Host "Registry key $registryPath exists with $Name and set to '$value'" -ForegroundColor Green
  exit
}
 # Checks the registry
$regCheck = Get-Item -Path $registryPath
If($regCheck.GetValue("$Name") -eq $null) {
  Write-Host "Registry key $registryPath created with $Name and set to '$value'" -ForegroundColor Yellow
  New-ItemProperty -Path $registryPath -Name $Name -Value $value
}

Start-Sleep -Seconds 4.5
RUNDLL32.EXE USER32.DLL, UpdatePerUserSystemParameters 1, True
