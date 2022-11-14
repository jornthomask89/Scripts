 # create custom folder and write PS script 
$path = $(Join-Path $env:ProgramData CustomScripts) 
if (!(Test-Path $path)) 
{ 
New-Item -Path $path -ItemType Directory -Force -Confirm:$false 
} 
# Source URL

$backgroundCheck = ""


IF(!(Test-Path $imgurl)){
$url = "https://www.brakar.no/wp-content/uploads/2022/11/destop-gronn-skyline.png"
$dest = "C:\ProgramData\CustomScripts\BrakarBackground.png"
   Write-Host "File doesnt exist, downloading...." -ForegroundColor Yellow
   Invoke-WebRequest -Uri $url -OutFile $dest
   Start-Sleep -Seconds 2
}
IF(!(Test-Path $imgurl)){
   Write-Host "File doesnt exist, downloading...." -ForegroundColor Yellow
   Invoke-WebRequest -Uri $imgurl -OutFile $dest
   Start-Sleep -Seconds 2
}




$registryPath = "HKLM:\SOFTWARE\Brakar\Background"
if (!(Test-Path $registryPath)) 
{ 
New-Item -Path $registryPath -ItemType Directory -Force -Confirm:$false 
} 

# register script as scheduled task - SYSTEM 
$Trigger = New-ScheduledTaskTrigger -AtLogOn
$User = "SYSTEM"
$tasknameSys = "BrakarBackground UserControl"
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ex bypass -file `"C:\ProgramData\CustomScripts\BackgroundCheck.ps1`"" 
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd
Register-ScheduledTask -TaskName $tasknameSys -Trigger $Trigger -User $User -Action $Action -Force -RunLevel Highest -Settings $Settings
Write-Host “Task $taskNameSys was created” -ForegroundColor Yellow 

