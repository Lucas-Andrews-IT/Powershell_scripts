# Prompt the user for the new user's name
$Username = Read-Host "Enter the new username"

# Prompt the user for the new user's password
$Password = Read-Host "Enter the new password" -AsSecureString

# Prompt the user for the full name of the new user
$FullName = Read-Host "Enter the full name of the new user"

# Create the new user account
New-LocalUser -Name $Username -Password $Password -FullName $FullName

# Remove the new user from the Administrators group
Remove-LocalGroupMember -Group "Administrators" -Member $Username
