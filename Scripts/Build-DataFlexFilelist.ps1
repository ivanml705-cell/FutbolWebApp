$ErrorActionPreference = "Stop"

$recordSize = 128
$recordCount = 4096
$rootFieldSize = 40
$logicalFieldSize = 32
$displayFieldSize = 40
$output = Join-Path $PSScriptRoot "..\Data\Filelist.cfg"
$bytes = New-Object byte[] ($recordSize * $recordCount)

function Write-Field {
    param(
        [byte[]]$Buffer,
        [int]$Offset,
        [string]$Value,
        [int]$Size
    )

    $encoded = [System.Text.Encoding]::ASCII.GetBytes($Value)
    if ($encoded.Length -gt $Size) {
        throw "Filelist value '$Value' is longer than $Size bytes."
    }

    [Array]::Copy($encoded, 0, $Buffer, $Offset, $encoded.Length)
}

Write-Field -Buffer $bytes -Offset 0 -Value "filelist.cfg" -Size $rootFieldSize

$entries = @(
    @{ Number = 1;   Root = "ODBC_DRV:entrenador";      Logical = "entrenador";      Display = "entrenador" },
    @{ Number = 2;   Root = "ODBC_DRV:jugador";         Logical = "jugador";         Display = "jugador" },
    @{ Number = 3;   Root = "ODBC_DRV:posicion";        Logical = "posicion";        Display = "posicion" },
    @{ Number = 4;   Root = "ODBC_DRV:equipo";          Logical = "equipo";          Display = "equipo" },
    @{ Number = 5;   Root = "ODBC_DRV:liga";            Logical = "liga";            Display = "liga" },
    @{ Number = 6;   Root = "ODBC_DRV:hijoentrenador";  Logical = "hijoentrenador";  Display = "hijoentrenador" },
    @{ Number = 7;   Root = "ODBC_DRV:hijojugador";     Logical = "hijojugador";     Display = "hijojugador" },
    @{ Number = 8;   Root = "ODBC_DRV:jugadorposicion"; Logical = "jugadorposicion"; Display = "jugadorposicion" },
    @{ Number = 9;   Root = "ODBC_DRV:nietodehijos";    Logical = "nietodehijos";    Display = "nietodehijos" },
    @{ Number = 253; Root = "ODBC_DRV:CodeType";        Logical = "CodeType";        Display = "CodeType" },
    @{ Number = 254; Root = "ODBC_DRV:CodeMast";        Logical = "CodeMast";        Display = "CodeMast" },
    @{ Number = 263; Root = "ODBC_DRV:WebAppSession";   Logical = "WebAppSession";   Display = "WebAppSession" }
)

foreach ($entry in $entries) {
    $offset = [int]$entry.Number * $recordSize
    Write-Field -Buffer $bytes -Offset $offset -Value $entry.Root -Size $rootFieldSize
    Write-Field -Buffer $bytes -Offset ($offset + $rootFieldSize) -Value $entry.Logical -Size $logicalFieldSize
    Write-Field -Buffer $bytes -Offset ($offset + $rootFieldSize + $logicalFieldSize) -Value $entry.Display -Size $displayFieldSize
}

[System.IO.File]::WriteAllBytes((Resolve-Path -LiteralPath (Split-Path $output)).Path + "\Filelist.cfg", $bytes)
Write-Host "Generated $output"
