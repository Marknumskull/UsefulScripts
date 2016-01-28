<#
.SYNOPSIS
    Watches a folder for changes, when changes are detected it moves files to a destination
.DESCRIPTION

.PARAMETER folderToWatch
    Specifies a relative path to a folder to watch for changes
.PARAMETER destinationFolder
    Specifies a relative path to a destination folder where files will get copied to
.PARAMETER fileListLocation
    Specifies a relative path to a text file containing the relative paths of
    files in the FolderToWatch to move to the DestinationFolder. The file paths
    should be added on separate lines.
.PARAMETER stopIISProcess
    This script was originally written by me to watch build file changes in asp.net applications
    and copy library files to an external probing folder. If this switch is present
    the IIS Process will be killed to allow the files to be moved.
.PARAMETER fileFilter
    Optional - Filter to apply to files in FolderToWatch eg if you are only interested ins
    watching .txt files enter a FileFilter of "*.txt"
.EXAMPLE
    C:\PS> .\WebFolderWatcher.ps1 -FolderToWatch "\folder\watching"
    -DestinationFolder "\folder\destination"
    -FileListLocation "\files.txt"
    -FileFilter = "*.dll"
.NOTES
    Author: Mark Smith
    Date:   January 28, 2016
#>

param(
    [Parameter(Mandatory=$True)]
    [string]$folderToWatch,
    [Parameter(Mandatory=$True)]
    [string]$destinationFolder,
    [Parameter(Mandatory=$True)]
    [string]$fileListLocation,
    [Parameter(Mandatory=$False)]
    [switch]$stopIISProcess,
    [Parameter(Mandatory=$False)]
    [string]$fileFilter = "*"
)

function GetLastModifiedDate{
    return Get-ChildItem -Path $PSScriptRoot\$folderToWatch -Filter $fileFilter | Sort-Object LastWriteTime | Select -Expand "LastWriteTime" | Select-Object -Last 1
}

function stopIISProcessProcess{
    iisreset /STOP
    try{
        Stop-Process (Get-Process | Where-Object {$_.ProcessName -eq "inetmgr"} | select -expand Id) -Force
        }
        catch{
            # process already stopped
        }

       Write-Host "IIS Process killed"
}

function CopyFiles{
    Move-Item -Path (Get-Content $PSScriptRoot\$fileListLocation) -Destination $destinationFolder -Force
    Write-Host "Files Copied"
}


[DateTime]$storedDate = GetLastModifiedDate

Write-Host "Starting to watch folder $PSScriptRoot\$folderToWatch"

while($true){
    [DateTime]$latestDate = GetLastModifiedDate

    if($latestDate -gt $storedDate){
        Write-Host "File modified"

        if($stopIISProcess.IsPresent)
          {stopIISProcessProcess}

        CopyFiles

        if($stopIISProcess.IsPresent)
        {iisreset /START}

        $storedDate = $latestDate
        Write-Host "Files copied reset, watching for more changes..."
    }
}
