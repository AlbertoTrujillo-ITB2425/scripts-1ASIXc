# Autor: Alberto Trujillo
# Description: Script to determine the letter grade based on a numeric score
# Date: January 23, 2025

# Prompt the user to enter the score
Write-Host "Enter your score (0,10):"
[int]$score = Read-Host

#Determine the grade based on the score
switch ($score) {
    {$_ -in 0..2}{"Your grade is D"}
    {$_ -in 3..4}{"Your grade is C-"}
    {$_ -in 5..6} {"Your grade is C+"}
    {$_ -in 7..8} {"Your grade is B"}
    {$_ -in 9..10} {"Your grade is A"}
    default {"Invalid score. Please enter a number Between 0 and 10."}
}
