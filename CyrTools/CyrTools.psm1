<#
    #######            Pour Créer un Manifest de Module                ########
	# Cette commande s'exécute à la racine
	New-ModuleManifest -Path CyrTools.psd1 -Author 'Cyril Richard' -CompanyName '' -RootModule CyrTools.psm1 -Description "Utilitaires divers" -FunctionsToExport @('DriveC','CreateSelfSignedCertificate','CreateCbz', 'QueryDb') -ModuleVersion '1.1.0'
#>

#region Template Functions
$functionPath = "$($PSScriptRoot)\Functions\"
$functionList = Get-ChildItem -Path $functionPath -Name
foreach($function in $functionList)
{
	.$functionPath\$function
}
#endregion Template Functions

<#
. $PSScriptRoot\CreateCbz.ps1
. $PSScriptRoot\QueryDb.ps1
#>