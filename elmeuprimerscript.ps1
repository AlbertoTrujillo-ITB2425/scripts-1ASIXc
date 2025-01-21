$data = Get-Date -Format "dd/MM/yyyy"
Write-Output $data
# Script per mostrar el contingut del directori "Documents"
$documentsPath = [Environment]::GetFolderPath("MyDocuments")
Get-ChildItem -Path $documentsPath