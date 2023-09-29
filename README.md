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

6. Set up Git

```
git config --global user.name "FIRST_NAME LAST_NAME"
git config --global user.email "MY_NAME@example.com"
```

7. Check out project

```
if (-not (Test-Path "D:\GameJam")) { New-Item "D:\GameJam" -ItemType Directory | Out-Null }
Set-Location "D:\GameJam"
git clone https://github.com/Sorjak/gamejam23
```

8. Open the project

```
Start-Process "D:\GameJam\gamejam23\GameJam23\GameJam23.uproject"
```

# Once you're set up

To update and open the project, close Unreal then:

```
Set-ExecutionPolicy Bypass -Scope Process -Force ; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Update-GameJamPC "https://github.com/karlgluck/gamejampc/raw/main/gamejam23.config"
Set-Location "D:\GameJam\gamejam23"
git pull
Start-Process "D:\GameJam\gamejam23\GameJam23\GameJam23.uproject"
```


## Switching to P4

```
$BasePath = "D:\p4"
if (-not (Test-Path $BasePath)) { New-Item $BasePath -ItemType Directory | Out-Null }
Set-Location $BasePath
p4 set P4PORT="IP"
p4 set P4CLIENT="WORKSPACE_NAME"
p4 set P4USER="Temecula"
p4 set P4CHARSET="utf8"
p4 set P4IGNORE=".p4ignore"
p4 client "WORKSPACE_NAME"
p4 sync
Start-Process "$BasePath\UEProject\GameJam23.uproject"
```

How to commit:
```
p4 submit
```
