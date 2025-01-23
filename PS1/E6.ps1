# Author: Alberto Trujillo
# Description: Script to determine the letter grade based on a numeric score
# Date: January 23, 2025

# Prompt the user to enter the score
Write-Host "Enter your score (0-10):"
[int]$score = Read-Host

# Determine the grade based on the score using if-else
if ($score -ge 9) {
    "Your grade is A"
} elseif ($score -ge 7) {
    "Your grade is B"
} elseif ($score -ge 5) {
    "Your grade is C+"
} elseif ($score -ge 3) {
    "Your grade is C-"
} elseif ($score -ge 0) { 
    "Your grade is D"
} else { 
    "Invalid score. Please enter a number between 0 and 10."
}