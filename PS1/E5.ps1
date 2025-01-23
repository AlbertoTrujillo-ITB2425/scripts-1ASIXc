#Author: Alberto Trujillo
#Date: January 23, 2025
#Description: Script to list the contents of a directory
# Get the directory path from the user
param(
    [Parameter(Mandatory=$true)]
    [string]$directorio
)

try {
    if (Test-Path $directorio -PathType Container) {
        Write-Host "Contenido de ${directorio}:"
        Get-ChildItem $directorio
    } else {
        Write-Host "La ruta '$directorio' no es un directorio válido."
    }
} catch {
    Write-Host "Debes proporcionar la ruta de un directorio como argumento."
    Write-Host "Por ejemplo: .\script.ps1 C:\mis_documentos"
}