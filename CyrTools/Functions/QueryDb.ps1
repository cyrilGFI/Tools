#Requires -RunAsAdministrator
function Set-ServerType([string] $Query, [string] $connectionString, [string] $ServerType, [string] $Database)
{
    switch ( $ServerType )
    {
        Oracle
        {
            Add-Type -AssemblyName "System.Data.OracleClient"
            $SqlConnection = New-Object System.Data.OracleClient.OracleConnection
            $SqlConnection.ConnectionString = $connectionString
            $Adapter = New-Object System.Data.OracleClient.OracleDataAdapter($Query, $SqlConnection)
            $Adapter.SelectCommand.CommandTimeout = 800
        }
        Oracle1
        {
            Add-Type -Path "E:\app\client\crichard\product\12.2.0\client_1\odp.net\managed\common\Oracle.ManagedDataAccess.dll"
            $SqlConnection = New-Object Oracle.ManagedDataAccess.Client.OracleConnection
            $SqlConnection.ConnectionString = $connectionString
            $Adapter = New-Object Oracle.ManagedDataAccess.Client.OracleDataAdapter($Query, $SqlConnection)
            $Adapter.SelectCommand.CommandTimeout = 800
        }
        SqlServer
        {
            $connectionString = "$($connectionString) Initial Catalog = $($Database)"
            $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
            $SqlConnection.ConnectionString = $connectionString
            $Adapter = New-Object System.Data.SqlClient.SqlDataAdapter($Query, $SqlConnection)
            $Adapter.SelectCommand.CommandTimeout = 800
        }
    }
    return $Adapter
}

<#
	.SYNOPSIS
	Query SQL Dbs
	
	.DESCRIPTION
	Query SQL database Oracle or SQLServer with query text or file.
	
	.PARAMETER DataSource
	
	.PARAMETER Database
	
	.OUTPUTS
	Recordset in System.Datatable parameter $table.
	
	.EXAMPLE
	QueryDb -DataSource "NMEXP" -User "nme" -ServerType "Oracle" -QueryText "select count(*) from type_membre"
    QueryDb -DataSource "NMEXP" -User "nme" -ServerType "Oracle" -Query "e:\myfile.sql"
    QueryDb -DataSource "NMEXP" -User "nme" -ServerType "Oracle1" -Query "e:\myfile.sql"
    QueryDb -DataSource "." -Database "CGOS" -User "sa" -ServerType "SqlServer" -QueryText "select name FROM master.dbo.sysdatabases"
    QueryDb -DataSource "." -Database "CGOS" -User "sa" -ServerType "SqlServer" -QueryText "select * from information_schema.tables"
    QueryDb -DataSource "192.9.27.155" -Database "CGOS" -User "sa" -ServerType "SqlServer" -Query "e:\mem.sql"
#>
function QueryDb([string]$DataSource, [string]$Database, [string] $User, [string] $Query, [string] $QueryText, [string] $ServerType)
{
    #ALTER LOGIN sa WITH PASSWORD = 'sa' UNLOCK, CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
    $Password = Read-Host "Mot de passe pour $($DataSource)" -AsSecureString
    $PlainUserPassword = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($Password))

    if ($null -eq $Query -or ([string]($Query)).length -lt 1)
    {
        if ($null -eq $QueryText -or ([string]($QueryText)).length -lt 1)
        {
            Write-Host("")
            Write-Host("Renseigner -Query ou -QueryText !!!") -ForegroundColor Yellow
            Write-Host("")
            return
        }
    }

    if ($null -ne $Query -and ([string]($Query)).length -gt 0)
    {
        $Query = Get-Content($Query)
        #Write-Host("queryText: "+$QueryText + " _ " + ([string]($QueryText)).length)
    }

    if ($null -ne $QueryText -and ([string]($QueryText)).length -gt 0)
    {
        $Query = $QueryText
        #Write-Host("query: "+$Query + " _ " + ([string]($Query)).length)
    }

    $connectionString = "Data Source = $DataSource; User Id = $User; Password= $PlainUserPassword;"
    $Adapter = Set-ServerType -Query $Query -connectionString $connectionString -ServerType $ServerType -Database $Database

    $global:table = New-Object System.Data.Datatable
    $StartTime = $(get-date)
    $result = $Adapter.Fill($table)
    $elapsedTime = $(get-date) - $StartTime
    $duree = "{0:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
    $Adapter.SelectCommand.Connection.Close()
    #$SqlConnection.Close()

    $null = $PlainUserPassword
    Write-Output ""
    Write-Output "Temps de requ�te: $($duree) / Nombre d'enregistrements: $result"
    Write-Output ($table | Select-Object -First 5 | Format-Table)
}
