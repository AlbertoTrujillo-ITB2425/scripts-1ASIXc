#Definicio directoris
$directoriOriginal = "$env:USERPROFILE\Desktop\original"
$directoriCopia = "$env:USERPROFILE\Desktop\còpia"

# Crea el directori còpia si no existeix
if (-Not (Test-Path -Path $directoriCopia)) {
    New-Item -ItemType Directory -Path $directoriCopia
}

# Copia el contingut del directori original al directori còpia
Copy-Item -Path "$directoriOriginal\*" -Destination $directoriCopia -Recurse

# Missatge de confirmacio 
Write-Host "El contingut ha estat copiat de '$directoriOriginal' a '$directoriCopia'."