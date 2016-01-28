# FolderWatcher.ps1

This is a script I originally wrote to watch ASP.Net bin folders for changes to dlls. When a change was detected it then copied across a list of files, defined in a text file, to an external library folder.

As this was created with web files in mind, it can also stop and restart IIS by supplying a -stopIISProcess flag. For general folder watching and copying you won't need this extra functionality, but for my needs and anyone else that uses ASP.Net and IIS they may find that quite useful as you cannot copy and move files if IIS still have locks on them.

For general useage information you can call the below

```
Get-Help .\WebFolderWatcher.ps1 -detailed
```

As well as the script there is also an example text file. This will contain a list of relative files you wish to copy from a folder to a destination folder. This file should be a .txt file with each file add on a new line

```
\src\Azert.HttpClient.Framework\bin\Debug\Azert.HttpClient.Framework.dll
\src\Azert.HttpClient.Framework\bin\Debug\Azert.HttpClient.Framework.dll.config
\src\Azert.HttpClient.Framework\bin\Debug\Azert.HttpClient.Framework.pdb
```


#### All paths are relative to the script

When the script is ran it will watch the folder defined, when a change is detected it will grab the file list from the above text file and copy each to the destination folder.

### Customisation

If you simply need a script that reacts to folder changes and does something else, pull this script down and change to meet your requirements.
