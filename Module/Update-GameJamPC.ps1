function Update-GameJamPC
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory)]
    [string]$ConfigFilePath
  )

  # Download remote config files
  if ($ConfigFilePath.StartsWith("http"))
  {
        $TempConfigPath = Join-Path ([System.IO.Path]::GetTempPath()) "GameJamSetup-$([System.IO.Path]::GetRandomFileName()).config"
        try
        {
          $Headers = @{'Cache-Control'='no-store'}
          Write-Host "Downloading $ConfigFilePath -> $TempConfigPath"
          Invoke-WebRequest -Headers $Headers -Uri $ConfigFilePath -OutFile $TempConfigPath
          $FileHash = (Get-FileHash $TempConfigPath -Algorithm SHA256).Hash
          Write-Host " > Downloaded, SHA256 = $FileHash"
        }
        catch
        {
          Write-Host -ForegroundColor Red "Unable to download host repository ZIP file from $ConfigFilePath"
          return
        }
        
        # Continue with the actual file path
        $ConfigFilePath = $TempConfigPath
  }

  Install-Chocolatey
  Install-ChocolateyPackageConfig -Path $ConfigFilePath
}
