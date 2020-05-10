<#
	.SYNOPSIS
	Créer un lecteur virtuel C:
	
	.DESCRIPTION
	Créer un lecteur virtuel C: (utile sous Linux)
	
	.OUTPUTS
	
	.EXAMPLE
#>
function DriveC
{
	New-PSDrive -Name 'C' -PSProvider 'FileSystem' -Root '/' -Scope 'Global' -ErrorAction Stop
	Set-Location C:
}