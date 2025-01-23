

# Author: Alberto Trujillo.
# Date: January 23, 2025.
# Description: Script to calculate the size of directories within C:\Users.

Get-ChildItem "C:\Users" -Directory | ForEach-Object {
    # Measure the time taken to calculate the directory size
    $startTime = Measure-Command {
        $dir = $_.FullName 
        (Get-ChildItem $dir -Recurse | Measure-Object -Sum Length).Sum 
    }
    # Display the directory name and the time taken to calculate its size
    Write-Host "The directory $($_.FullName) occupies $($startTime.TotalSeconds) bytes"
}