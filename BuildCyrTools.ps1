$envPath = [environment]::getfolderpath("mydocuments")
$Platform = $PSVersionTable.Platform
$Module = "CyrTools"
$endMessage = "Module $($Module) Copié, lancer Import-Module $($Module)"

$ErrorActionPreference = "Stop" 
if ( -not (Test-Path $Module)){throw [System.Exception]::new("Module $($Module) non trouvé !!")}

if ([string]::IsNullOrWhiteSpace($Platform))
{
    $envPath += "\WindowsPowerShell\Modules"
    Copy-Item -r $Module $envPath -Force
    Write-Warning $endMessage
    return
}

if ($Platform.ToUpper() -eq 'UNIX')
{
    $envPath += "/.local/share/powershell/Modules"
    Copy-Item -r $Module $envPath -Force
    Write-Warning $endMessage
    return
}

if ($Platform.ToUpper() -eq 'WIN32NT')
{
    $envPath += "\PowerShell\Modules"
    Copy-Item -r $Module $envPath -Force
    Write-Warning $endMessage
    return
}