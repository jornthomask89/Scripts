# Source URL
$url = "https://www.brakar.no/wp-content/uploads/2022/11/destop-gronn-skyline.png"

# Destation file
$dest = "C:\ProgramData\CustomScripts\BrakarBackground.jpg"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest


Start-Sleep -Seconds 15

Start-Process powershell .\SetBackground.ps1