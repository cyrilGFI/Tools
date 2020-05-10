<#
	.SYNOPSIS
	Créer un fichier Cbz
	
	.DESCRIPTION
	Créer un fichier Cbz de BD à partir d'un répertoire de jpg.
	
	.PARAMETER StorageDir
	
	.OUTPUTS
	
	.EXAMPLE
#>
function CreateCBZ ([string] $StorageDir)
{
	if ([string]::IsNullOrWhiteSpace($StorageDir)) {throw [system.exception]::new("Pas de Répertoire spécifié !!");return}
	#Get-ChildItem $storageDir -Directory | ForEach-Object { Compress-Archive -CompressionLevel Optimal -DestinationPath "$($_.FullName)" -Path "$($_.FullName)\*"}
	#Get-ChildItem $storageDir | Where-Object {$_.Extension -eq ".zip"} | ForEach-Object {$filenew = $_.BaseName + ".cbz";Rename-Item -Path $_.FullName -NewName $filenew}
	$zipName = Split-Path $Storagedir -Leaf
	Compress-Archive -Path $StorageDir -DestinationPath "./$($zipName).zip"
	Rename-Item "$($zipName).zip" "$($zipName).cbz"
}