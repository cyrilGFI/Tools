<#
	.SYNOPSIS
	Create a self signed certificate
	
	.DESCRIPTION
	Create a self signed certificate
	
	.PARAMETER certificateName
	
	.OUTPUTS
	
	.EXAMPLE
	CreateSelfSignedCertificate -certificateName toto -selfSignedCertPlainPwd 'mypass' -certPath '.' -certPathCer '.' -selfSignedCertNoOfMonthsUntilExpired "36"
#>
function CreateSelfSignedCertificate([string] $certificateName, [string] $selfSignedCertPlainPwd,
    [string] $certPath, [string] $certPathCer, [string] $selfSignedCertNoOfMonthsUntilExpired )
{
    #
    $Cert = New-SelfSignedCertificate -DnsName $certificateName -CertStoreLocation cert:\LocalMachine\My `
        -KeyExportPolicy Exportable -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" `
        -NotAfter (Get-Date).AddMonths($selfSignedCertNoOfMonthsUntilExpired) -HashAlgorithm SHA256

    #$CertPassword = ConvertTo-SecureString $selfSignedCertPlainPwd -AsPlainText -Force
    #Export-PfxCertificate -Cert ("Cert:\localmachine\my\" + $Cert.Thumbprint) -FilePath $certPath -Password $CertPassword -Force | Write-Verbose
    #Export-Certificate -Cert ("Cert:\localmachine\my\" + $Cert.Thumbprint) -FilePath $certPathCer -Type CERT | Write-Verbose

	certutil -p '$($selfSignedCertPlainPwd)' -exportPFX my $Cert.Thumbprint "$($certificateName).pfx" | Out-Null
}