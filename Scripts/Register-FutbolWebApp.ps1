param(
    [string]$Workspace = "FutbolWebApp",
    [string]$VirtualDir = "FutbolWebApp",
    [string]$SiteName = "Default Web Site"
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")
$appHtml = Join-Path $repoRoot "AppHTML"
$programPath = Join-Path $repoRoot "Programs\FutbolWebApp.exe"
$logPath = Join-Path $repoRoot "Programs\WebApp.log"
$appCmd = Join-Path $env:SystemRoot "System32\inetsrv\appcmd.exe"
$registryPath = "HKLM:\SOFTWARE\Data Access Worldwide\DataFlex\25.0\WebApp Server\Web Applications\$Workspace"

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal]::new($identity)
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    throw "Run this script from an elevated PowerShell to register IIS and DataFlex WebApp runtime."
}

if (-not (Test-Path -LiteralPath $programPath)) {
    throw "Compiled WebApp executable not found at '$programPath'. Run Scripts\Compile-FutbolWebApp.ps1 first."
}

if (-not (Test-Path -LiteralPath $appCmd)) {
    throw "IIS appcmd.exe not found at '$appCmd'."
}

New-Item -Path $registryPath -Force | Out-Null
New-ItemProperty -Path $registryPath -Name Disable -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $registryPath -Name LogAccess -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $registryPath -Name MaxLogEntries -Value 1000 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $registryPath -Name LogFile -Value $logPath -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name ProgramPath -Value $programPath -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name MinPool -Value 2 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $registryPath -Name MaxPool -Value 5 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $registryPath -Name UseConnectorPool -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $registryPath -Name PurgePoolInterval -Value 24 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $registryPath -Name OperationMode -Value "Local" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name ProgramParameters -Value "" -PropertyType String -Force | Out-Null

& icacls $appHtml /grant "IIS_IUSRS:(OI)(CI)RX" | Out-Null

& $appCmd list app "$SiteName/$VirtualDir" | Out-Null
if ($LASTEXITCODE -eq 0) {
    & $appCmd delete app "$SiteName/$VirtualDir" | Out-Null
}

& $appCmd add app "/site.name:$SiteName" "/path:/$VirtualDir" "/physicalPath:$appHtml" | Out-Null
& $appCmd set app "$SiteName/$VirtualDir" "/applicationPool:DefaultAppPool" | Out-Null

Start-Service -Name W3SVC
Restart-Service -Name DFWAS250 -Force

Write-Host "Registered $Workspace"
Write-Host "URL: http://localhost/$VirtualDir/Index.html"
