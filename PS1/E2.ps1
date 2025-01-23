# Data: January 23, 2025
# Author: Alberto Trujillo
# Description: Script to modify the $Env:PATH variable to include a new directory

# Get paths to desktop and documents
$desktop = [Environment]::GetFolderPath('Desktop')
$docs    = [Environment]::GetFolderPath('MyDocuments')
$script  = Join-Path $docs 'E1.ps1'
$target  = Join-Path $desktop 'scripts'

# Create script directory if it doesn't exist
New-Item -ItemType Directory -Path $target -Force

# Move script to new directory
Move-Item $script $target

# Update PATH environment variable
$Env:Path += ";$target"
