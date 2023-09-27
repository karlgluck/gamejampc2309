# gamejamcomputer
win10 developer pc auto-setup scripts

1. `Win + x` , `a`, `enter`

2. accept prompt to start admin powershell

3. `cd ~/Downloads`

4. Copy + Run:

```
Set-ExecutionPolicy Bypass -Scope Process -Force ; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 ; (Invoke-WebRequest -UseBasicParsing -Method Get -Uri "https://raw.githubusercontent.com/karlgluck/gamejamcomputer/main/Import-GameJamSetup.ps1" -Headers @{'Cache-Control'='no-store'}).Content | Invoke-Expression ; Import-GameJamSetup -ZipFilePath "https://github.com/karlgluck/gamejamcomputer/archive/refs/heads/main.zip"
```
