function KillIisProcess{
    iisreset /STOP
    try{
        Stop-Process (Get-Process | Where-Object {$_.ProcessName -eq "inetmgr"} | select -expand Id) -Force
        }
        catch{
          # no IIS Process Watcher running
        }

       Write-Host "IIS Process killed"
}

KillIisProcess
