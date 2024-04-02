# Repo: An0n-00/Spotify-ad-hosts
# URL: https://github.com/An0n-00/Spotify-ad-hosts
# Author: An0n-00
# License: GNU General Public License v3.0
# License URL: https://github.com/An0n-00/Spotify-ad-hosts/blob/main/LICENSE
# Usage: Run this script as an Administrator
############################################################################################################


$updateurl = "https://raw.githubusercontent.com/An0n-00/Spotify-ad-hosts/main/hosts"  # Update URL
$outputFile = "C:\Windows\System32\drivers\etc\hosts" # Output file

Clear-Host
Write-Host " ____              _   _  __            _       _ 
/ ___| _ __   ___ | |_(_)/ _|_   _     / \   __| |
\___ \| '_ \ / _ \| __| | |_| | | |   / _ \ / _` |
 ___) | |_) | (_) | |_| |  _| |_| |  / ___ \ (_| |
|____/| .__/ \___/ \__|_|_|  \__, | /_/   \_\__,_|
      |_|                    |___/                
 ____  _            _     
| __ )| | ___   ___| | _____ _ __                 
|  _ \| |/ _ \ / __| |/ / _ \ '__|                
| |_) | | (_) | (__|   <  __/ |                   
|____/|_|\___/ \___|_|\_\___|_|                   "

Write-Host "`n`nGeneral Information:"
Write-Host "This script only works only on Windows systems (as of now). `nYou need to run this script as an Administrator to modify the hosts file and you need an active internet connection to download the latest Spotify ad-hosts file. If one of these factors is not met, the script will not work properly" -NoNewline
[int] $i = 0
do {
    $i++
    Start-Sleep -Milliseconds 2000
    Write-Host "." -NoNewline
}until ($i -eq 3)
Write-Host "`n"
$continue_1 = Read-Host "Are you sure, you want to continue? (Y/N)"
if ($continue_1 -ne "Y" -and $continue_1 -ne "y") {
    Write-Host "Exiting..." -ForegroundColor Red
    Start-Sleep -Seconds 2
    exit
}

# Check for admin rights
function Test-IsAdmin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# If not running as admin, restart the script as admin
if (-NOT (Test-IsAdmin)) {
    Write-Host "This script must be run as an Administrator. Please re-run this script as an Administrator." -ForegroundColor Red
    Read-Host "`nPress Enter to exit"
    exit
}

Clear-Host
Write-Host "Spotify-ad-hosts Installer"
Write-Host "`nThis script will download the latest Spotify ad host file and append it to your hosts file. (Internet connection required)"
Write-Host "`nPlease note that this Script is not able to check your version of the Spotify ad-hosts file, so it will append the content to the end of the existing file. Meaning, if you have an old version of the Spotify ad-hosts file, you will have duplicates in your hosts file. To avoid this, please manually remove the old Spotify ad-hosts file before running this script. (The host file is located in C:\Windows\System32\drivers\etc\hosts )"
Write-Host "`n`nThe author of this script does not take any responsibility for the hosts and the consequences of blocking them. For more information read the license on Github https://github.com/An0n-00/Spotify-ad-hosts/blob/main/LICENSE"

$continue = Read-Host "`nAre you sure you want to continue? (Y/N)"
if ($continue -ne "Y" -and $continue -ne "y") {
    Write-Host "Exiting..." -ForegroundColor Red
    Start-Sleep -Seconds 2
    exit
}

# Retrieve the content from the URL
$response = Invoke-WebRequest -Uri $updateurl
# Append the content to the hosts file with a newline at the beginning
Add-Content -Path $outputFile -Value ("`n`n`n" + $response.Content)

Write-Host "Success!" -ForegroundColor Green
Write-Host "Please note that you may need to restart your browser or flush your DNS cache to apply the changes."

Read-Host "Would you like to flush your DNS cache now? (Y/N)"
if ($continue -eq "Y" -or $continue -eq "y") {
    ipconfig /flushdns | Out-Null
    Write-Host "Success!" -ForegroundColor Green
}

Write-Host "Dont forget to update the hosts file regularly to keep the ad hosts up to date (This repo is recieving monthly updates!). And remember BEFORE you update, remove the old hosts!`nIf you encounter in any issues, do not hesitate to open an issue in: https://github.com/An0n-00/Spotify-ad-hosts/issues"

Read-Host "`nPress Enter to exit"
Write-Host "Enjoy your ad-and-tracker-free Spotify experience! ;)"
Start-Sleep -Seconds 4