# Autor: Alberto Trujillo.
# Data: January 23, 2025.
# Descripcio: Script per comparar diferents fragments de codi en PowerShell(rebent el nom per parametres).

Write-Host "Ingrese la ruta del directorio:"
$directorio = Read-Host

if (Test-Path $directorio -PathType Container) {
    $size = (Get-ChildItem $directorio -Recurse | Measure-Object -Sum Length).Sum / 1MB
    Write-Host "El directorio $directorio ocupa $size MB"
} else {
    Write-Host "El directorio $directorio no existe o no es válido."
}