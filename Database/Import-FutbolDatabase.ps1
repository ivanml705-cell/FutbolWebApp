param(
    [string]$MysqlExe = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    [string]$HostName = "127.0.0.1",
    [int]$Port = 3306,
    [string]$User = "root",
    [string]$LoginPath = "",
    [string]$Database = "futbol",
    [string]$SqlPath = "..\futbolBD.sql",
    [switch]$PromptPassword
)

$ErrorActionPreference = "Stop"

$resolvedSql = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot $SqlPath)

if (-not (Test-Path -LiteralPath $MysqlExe)) {
    throw "mysql.exe not found at '$MysqlExe'."
}

if ($LoginPath) {
    $baseArgs = @("--login-path=$LoginPath")
}
else {
    $baseArgs = @(
        "--host=$HostName",
        "--port=$Port",
        "--user=$User",
        "--protocol=tcp"
    )

    if ($PromptPassword) {
        $baseArgs += "--password"
    }
}

& $MysqlExe @baseArgs --execute="CREATE DATABASE IF NOT EXISTS $Database CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
if ($LASTEXITCODE -ne 0) {
    throw "Could not create database '$Database'. Check that MySQL is running and credentials are valid."
}

Get-Content -LiteralPath $resolvedSql -Raw | & $MysqlExe @baseArgs "--database=$Database"
if ($LASTEXITCODE -ne 0) {
    throw "Could not import '$resolvedSql' into database '$Database'."
}

Write-Host "Database '$Database' imported from $resolvedSql"
