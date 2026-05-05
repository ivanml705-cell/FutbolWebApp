param(
    [string]$LoginPath = "FutbolWebApp",
    [string]$Database = "futbol",
    [string]$RuntimeUser = "futbol_app",
    [string]$MySqlExe = ""
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($MySqlExe)) {
    $candidates = @(
        "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
        "C:\Program Files\MySQL\MySQL Workbench 8.0 CE\mysql.exe"
    )

    $MySqlExe = $candidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
}

if ([string]::IsNullOrWhiteSpace($MySqlExe) -or -not (Test-Path -LiteralPath $MySqlExe)) {
    throw "mysql.exe not found. Pass -MySqlExe with the full MySQL client path."
}

$safeDatabase = $Database.Replace("``", "````")
$safeUser = $RuntimeUser.Replace("'", "''")

$sql = @"
CREATE USER IF NOT EXISTS '$safeUser'@'localhost' IDENTIFIED BY '';
CREATE USER IF NOT EXISTS '$safeUser'@'127.0.0.1' IDENTIFIED BY '';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX, DROP, REFERENCES ON ``$safeDatabase``.* TO '$safeUser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX, DROP, REFERENCES ON ``$safeDatabase``.* TO '$safeUser'@'127.0.0.1';
FLUSH PRIVILEGES;
"@

& $MySqlExe "--login-path=$LoginPath" "--execute=$sql"
if ($LASTEXITCODE -ne 0) {
    throw "Failed to configure MySQL runtime user '$RuntimeUser'."
}

Write-Host "Configured MySQL runtime user '$RuntimeUser' for database '$Database'."
