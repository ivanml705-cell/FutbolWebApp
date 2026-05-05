param(
    [string]$Workspace = "FutbolWebApp",
    [string]$VirtualDir = "FutbolWebApp"
)

$ErrorActionPreference = "Stop"

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal]::new($identity)
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Warning "Run this script from an elevated PowerShell to register the IIS/WebApp runtime."
}

Write-Host "Workspace:  $Workspace"
Write-Host "VirtualDir: $VirtualDir"
Write-Host "Open DataFlex Web Application Server Administrator and register this workspace if it is not listed."
Write-Host "AppHTML path: $(Resolve-Path .\AppHTML)"
