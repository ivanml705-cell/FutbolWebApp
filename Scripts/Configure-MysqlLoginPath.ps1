param(
    [string]$MysqlConfigEditor = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql_config_editor.exe",
    [string]$LoginPath = "FutbolWebApp",
    [string]$HostName = "127.0.0.1",
    [int]$Port = 3306,
    [string]$User = "root"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $MysqlConfigEditor)) {
    throw "mysql_config_editor.exe not found at '$MysqlConfigEditor'."
}

& $MysqlConfigEditor set `
    "--login-path=$LoginPath" `
    "--host=$HostName" `
    "--port=$Port" `
    "--user=$User" `
    --password

if ($LASTEXITCODE -ne 0) {
    throw "Could not configure MySQL login path '$LoginPath'."
}

& $MysqlConfigEditor print "--login-path=$LoginPath"
