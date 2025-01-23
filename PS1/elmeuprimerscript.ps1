# Get the current date
$data = Get-Date -Format "dd/MM/yyyy"
Write-Output $data

# Get the contents of the "Documents" directory
$documentsPath = [Environment]::GetFolderPath("MyDocuments")
Get-ChildItem -Path $documentsPath