$registryPath = "HKLM:\SOFTWARE\Brakar\Background"
$Name = "$Env:username"
$value = "True"
$img = "C:\ProgramData\CustomScripts\BrakarBackground.png"
$ScriptLoc = "C:\ProgramData\CustomScripts\BackgroundInstall.ps1"

 # Source URL
$url = "https://www.brakar.no/wp-content/uploads/2022/11/destop-gronn-skyline.png"
  


if (!(Test-Path $registryPath)) 
{ 
New-Item -Path $registryPath -ItemType Directory -Force -Confirm:$false 
} 

 # Checking for background image
 # Downloads background image if it doesnt exist
IF(!(Test-Path $img)){
   Write-Host "File doesnt exist, downloading...." -ForegroundColor Yellow

 # Download the file
   Invoke-WebRequest -Uri $url -OutFile $img
   Start-Sleep -Seconds 2
}
# If the file exists, continue
IF(Test-Path $img){
    Write-Host "Background exists. Proceeding." -ForegroundColor Green   
    }



IF(!(Test-Path $ScriptLoc)){
   Write-Host "File doesnt exist, downloading...." -ForegroundColor Yellow
   # Creates the local scr
$content = @' 
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
'@ 
 
 # create custom folder and write PS script 
$path = "C:\ProgramData\CustomScripts"
if (!(Test-Path $path)) 
{ 
New-Item -Path $path -ItemType Directory -Force -Confirm:$false 
}
Out-File -FilePath "C:\ProgramData\CustomScripts\BackgroundInstall.ps1" -Encoding unicode -Force -InputObject $content -Confirm:$false 

   Start-Sleep -Seconds 2
}




# If the file exists, continue
IF(Test-Path $img){
    Write-Host "Background exists. Proceeding." -ForegroundColor Green   
    }







     # Checks the registry
 # If reg key doesnt exist, create it...
$regCheck = Get-Item -Path $registryPath
If($regCheck.GetValue("$Env:username") -eq $value) {
#New-Item -Path $registryPath -Name "Background"
  Write-Host "Registry key $registryPath exists with $Name and set to '$value'" -ForegroundColor Green
  exit

}

 # Checks the registry
 # If reg key doesnt exist, create it...
$regCheck = Get-Item -Path $registryPath
If($regCheck.GetValue("$Env:username") -eq $null){
New-ItemProperty -Path $registryPath -Name $Name -Value $value
    Write-Host "Registry key $registryPath created with $Name and set to '$value'" -ForegroundColor Yellow
    # register script as scheduled task 
$loggedonuser = Get-WMIObject -class Win32_ComputerSystem | Select-Object -ExpandProperty username 
$Trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:UserName
$trigger.Delay = "PT10S"
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ex bypass -file `"C:\ProgramData\CustomScripts\BackgroundInstall.ps1`"" 
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd
Register-ScheduledTask -TaskName "BrakarBackground $Env:username" -Trigger $Trigger -User $loggedonuser -Action $Action -Force -RunLevel Highest -Settings $Settings
Write-Host “Task $taskName was created” -ForegroundColor Yellow 

}
