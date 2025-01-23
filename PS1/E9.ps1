# Author: Alberto Trujillo.
# Date: January 23, 2025.
# Description: Script to compare different code fragments in PowerShell (receives directory name as parameter).

Write-Host "Ingrese la ruta del directorio:"
$directorio = Read-Host

if (Test-Path $directorio -PathType Container) {
    $size = (Get-ChildItem $directorio -Recurse | Measure-Object -Sum Length).Sum / 1MB
    Write-Host "El directorio $directorio ocupa $size MB"
} else {
    Write-Host "El directorio $directorio no existe o no es válido."
}