<#
    #######            Pour Créer un Module                ########
	# Créer un rép du nom du module puis générer les commandes suivantes à partir du rép source :
	New-Item -Path .\Scripts -Name AzureTools -ItemType Directory
	New-Item -Path .\Scripts\AzureTools -Name AzureTools.psm1
	# Cette commande s'exécute à la racine
	New-ModuleManifest -Path CyrTools.psd1 -Author 'Cyril Richard' -CompanyName '' -RootModule CyrTools.psm1 -Description "Utilitaires divers" -FunctionsToExport @('DriveC','CreateSelfSignedCertificate','CreateCbz', 'QueryDb') -ModuleVersion '1.1.0'
#>

#region Template Functions
. $PSScriptRoot\DriveC.ps1
. $PSScriptRoot\CreateSelfSignedCertificate.ps1
. $PSScriptRoot\CreateCbz.ps1
. $PSScriptRoot\QueryDb.ps1
#endregion Template Functions