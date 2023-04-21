# Prompt for password length and complexity
$passwordLength = Read-Host -Prompt "Enter the desired length for the password"
$passwordComplexity = Read-Host -Prompt "Enter the desired complexity for the password (1 = lowercase letters only, 2 = lowercase and uppercase letters, 3 = lowercase and uppercase letters plus numbers, 4 = lowercase and uppercase letters plus numbers and special characters)"

# Define character sets based on complexity level
$lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
$uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
$numbers = "0123456789"
$specialCharacters = "!@#$%^&*-_+"

$characterSet = ""
switch ($passwordComplexity) {
    1 { $characterSet = $lowercaseLetters }
    2 { $characterSet = $lowercaseLetters + $uppercaseLetters }
    3 { $characterSet = $lowercaseLetters + $uppercaseLetters + $numbers }
    4 { $characterSet = $lowercaseLetters + $uppercaseLetters + $numbers + $specialCharacters }
}

# Generate a random password
$password = ""
for ($i = 1; $i -le $passwordLength; $i++) {
    $randomCharacter = Get-Random -InputObject $characterSet.ToCharArray()
    $password += $randomCharacter
}

# Display the password to the user
Write-Host "Generated password: $password"