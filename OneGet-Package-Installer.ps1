# This script will install/update a list of packages using 
# OneGet, the built in package manager to Windows 10
# If running script for the first time provide the -firstTime switch
# ie Package-Installer.ps1 -firstTime

Param(
    [switch]$firstTime = $false
)

$packages = "atom","path-copy-copy","Revo.Uninstaller","markdownpad2"

if($firstTime){
    Set-ExecutionPolicy RemoteSigned
    install-package –provider bootstrap chocolatey
    Write-Host "Setup completed..."
}

Write-Host "Installing Packages..."

foreach($p in $packages){
    Write-Host "Installing $p" 
    Install-Package $p -Confirm:$false -Force
}

Write-Host "Install Completed"
