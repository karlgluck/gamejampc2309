# gamejampc
win10 developer pc auto-setup scripts

1. `Win + x` , `a`, `enter`

2. accept prompt to start admin powershell

3. `cd ~/Downloads`

4. Copy + Run:

```
Set-ExecutionPolicy Bypass -Scope Process -Force ; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 ; (Invoke-WebRequest -UseBasicParsing -Method Get -Uri "https://raw.githubusercontent.com/karlgluck/gamejampc/main/Import-GameJamSetup.ps1" -Headers @{'Cache-Control'='no-store'}).Content | Invoke-Expression ; Import-GameJamSetup -ZipFilePath "https://github.com/karlgluck/gamejampc/archive/refs/heads/main.zip"
```

5. Run the update function for the game jam

```
Update-GameJamPC "https://github.com/karlgluck/gamejampc/raw/main/gamejam23.config"
```
