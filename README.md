# OneGet-Package-Installer.ps1 

**Requires Windows 10**

Sets up and downloads a list of packages, you can download the script and modify the list to your needs. This will also update packages, may be handy to run as a scheduled task.

Execute the below code when running for the first time. This will add [Chocolatey](https://chocolatey.org/ "Chocolatey"), a Package Manager, to OneGet.

```
OneGet-Package-Installer.ps1 -firstTime
```

Subsequent runs only need the below

```
OneGet-Package-Installer.ps1
```
