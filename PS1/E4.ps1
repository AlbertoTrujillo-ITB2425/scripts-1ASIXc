# Data: January 23, 2025
# Author: Alberto Trujillo
# Description: Script to determine if a path is a file or a directory

param(
    [string]$path
)

# Check if the path is provided
if (-not [string]::IsNullOrEmpty($path)) { 
    # Check if the path is a file
    if (Test-Path -Path $path -PathType Leaf) {
        Write-Host "$path is a regular file."
    } 
    # Check if the path is a directory
    elseif (Test-Path -Path $path -PathType Container) {
        Write-Host "$path is a directory."
    } 
    else {
        Write-Host "The specified path does not exist or is not a valid file or directory."
    }
} else {
    Write-Host "Please provide a path as an argument to the script."
}