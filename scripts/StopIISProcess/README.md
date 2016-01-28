# Kill-IIS-Process.ps1

Quite often when stopping IIS, it leaves behind the IIS Watcher Process, this can prevent you from deleting/moving files that this process is hanging onto.

I made this script as when developing I'm often running IIS and need to copy, move or delete files. I found that very often I couldn't even after stopping IIS. The only to guarantee was to manually kill the inetmgr.exe process as well.

Running this script as Administrator will stop IIS and kill the process if still running, leaving you free to move files around at your will. Just don't forget to run iisreset /Start afterwards :)
