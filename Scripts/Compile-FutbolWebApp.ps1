param(
    [string]$Compiler = "C:\Program Files\DataFlex 25.0\Bin64\DfCompConsole.exe",
    [string]$Workspace = ".\FutbolWebApp.sws",
    [string]$Source = ".\AppSrc\FutbolWebApp.src"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Compiler)) {
    throw "DataFlex compiler not found at '$Compiler'."
}

& $Compiler $Source -x $Workspace -c -i1 -e2 -w
if ($LASTEXITCODE -ne 0) {
    throw "DataFlex compilation failed."
}
