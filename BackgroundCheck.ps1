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
 

   Start-Sleep -Seconds 2
}




# If the file exists, continue
IF(!(Test-Path $img)){
$url = "https://www.brakar.no/wp-content/uploads/2022/11/destop-gronn-skyline.png"
$dest = "C:\ProgramData\CustomScripts\BrakarBackground.png"
   Write-Host "File doesnt exist, downloading...." -ForegroundColor Yellow
   Invoke-WebRequest -Uri $url -OutFile $dest
   Start-Sleep -Seconds 2
}
IF(!(Test-Path $ScriptLoc)){
   Write-Host "File doesnt exist, downloading...." -ForegroundColor Yellow
$url = "https://raw.githubusercontent.com/jornthomask89/Scripts/main/BackgroundInstall.ps1"
$dest = "C:\ProgramData\CustomScripts\BackgroundInstall.ps1"
   Invoke-WebRequest -Uri $imgurl -OutFile $dest
   Start-Sleep -Seconds 2
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
