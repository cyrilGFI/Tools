<#
	.SYNOPSIS
	Créer un fichier Cbz
	
	.DESCRIPTION
	Créer un fichier Cbz de BD à partir d'un répertoire de jpg.
	
	.PARAMETER Datasource
	
	.PARAMETER Database
	
	.OUTPUTS
	
	.EXAMPLE
#>
function CreateCBZ ([string] $storageDir)
{
	Get-ChildItem $storageDir -Directory | ForEach-Object { Compress-Archive -CompressionLevel Optimal -DestinationPath "$($_.FullName)" -Path "$($_.FullName)\*"}
	Get-ChildItem $storageDir | Where-Object {$_.Extension -eq ".zip"} | ForEach-Object {$filenew = $_.BaseName + ".cbz";Rename-Item -Path $_.FullName -NewName $filenew}
}