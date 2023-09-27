function Import-GameJamSetup
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory)]
    [string]$ZipFilePath
  )

    # If the zip file path provided specifies a URL, download the file
    if ($ZipFilePath.StartsWith("http"))
    {
        $TempZipPath = Join-Path ([System.IO.Path]::GetTempPath()) "GameJamSetup-$([System.IO.Path]::GetRandomFileName()).zip"
        try
        {
          $Headers = @{'Cache-Control'='no-store'}
          Write-Host "Downloading $ZipFilePath -> $TempZipPath"
          Invoke-WebRequest -UseBasicParsing -Headers $Headers -Uri $ZipFilePath -OutFile $TempZipPath
          $ZipFileHash = (Get-FileHash $TempZipPath -Algorithm SHA256).Hash
          Write-Host " > Downloaded, SHA256 = $ZipFileHash"
        }
        catch
        {
          Write-Host -ForegroundColor Red "Unable to download host repository ZIP file from $ZipFilePath"
          return
        }
        
        # Continue with the zip path so we can extract the module locally
        $ZipFilePath = $TempZipPath
    }
  
    # Install to this folder, deleting anything that exists if necessary
    $ModulesFolder = Join-Path ($env:PSModulePath -split ';')[0] "GameJamSetup"
    Write-Host "Install $ZipFilePath/Module/** as a PowerShell module into $ModulesFolder"
    if (Test-Path $ModulesFolder) { Remove-Item -Recurse -Force $ModulesFolder }
    

    # If the path provided specifies a directory, assume that is the module directory and copy it. This
    # is useful for debugging. Otherwise, this is a zip file that contains the entire repository.
    if ((Get-Item $ZipFilePath).PSIsContainer)
    {
        Copy-Item $ZipFilePath $ModulesFolder -Recurse
    }
    else
    {
        Expand-ZipFileDirectory -ZipFilePath $ZipFilePath -DirectoryInZipFile "Module" -OutputPath $ModulesFolder
    }

    # Grab the newer version of the module
    Import-Module GameJamSetup -Force

}
