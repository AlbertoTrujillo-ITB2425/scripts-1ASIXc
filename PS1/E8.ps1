# Autor: Alberto Trujillo.
# Data: January 23, 2025.
# Descripció: Script per comparar diferents fragments de codi en PowerShell.


Get-ChildItem "C:\Users" -Directory | ForEach-Object {
    $startTime = Measure-Command {
        $dir = $_.FullName
        (Get-ChildItem $dir -Recurse | Measure-Object -Sum Length).Sum
    }
    Write-Host "El directori $($_.FullName) ocupa un tamany de $($startTime.TotalSeconds) bytes"
 }
 