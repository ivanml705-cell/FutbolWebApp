param(
    [string]$Name = "FutbolWebApp_MySQL",
    [string]$DriverName = "MySQL ODBC 9.7 Unicode Driver",
    [string]$Server = "127.0.0.1",
    [int]$Port = 3306,
    [string]$Database = "futbol",
    [ValidateSet("User", "System")]
    [string]$DsnType = "User"
)

$ErrorActionPreference = "Stop"

$existing = Get-OdbcDsn -Name $Name -DsnType $DsnType -ErrorAction SilentlyContinue
if ($existing) {
    Remove-OdbcDsn -Name $Name -DsnType $DsnType
}

Add-OdbcDsn `
    -Name $Name `
    -DriverName $DriverName `
    -DsnType $DsnType `
    -SetPropertyValue @(
        "SERVER=$Server",
        "PORT=$Port",
        "DATABASE=$Database",
        "NO_SCHEMA=1"
    )

Get-OdbcDsn -Name $Name -DsnType $DsnType
