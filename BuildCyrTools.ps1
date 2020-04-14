$envPath = [environment]::getfolderpath("mydocuments")
$Platform = $PSVersionTable.Platform
$Module = "CyrTools"

$ErrorActionPreference = "Stop" 
if ( -not (Test-Path $Module)){throw [System.Exception]::new("Module $($Module) non trouvé !!")}

if ([string]::IsNullOrWhiteSpace($Platform))
{
    $envPath += "\WindowsPowerShell\Modules"
    Copy-Item -r $Module $envPath
}

if ($Platform.ToUpper() -eq 'UNIX')
{
    $envPath += "/.local/share/powershell/Modules"
    Copy-Item -r $Module $envPath
}

if ($Platform.ToUpper() -eq 'WIN32NT')
{
    $envPath += "\PowerShell\Modules"
    Copy-Item -r $Module $envPath
}

Write-Warning "Module $($Module) Copié, lancer Import-Module $($Module)"