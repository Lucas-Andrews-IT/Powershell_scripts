# Import the ActiveDirectory module
Import-Module ActiveDirectory

# Uninstall AD DS
Uninstall-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Remove -Restart

# Remove all users
Get-ADUser -Filter * | Remove-ADUser -Confirm:$false

# Remove all groups
Get-ADGroup -Filter * | Remove-ADGroup -Confirm:$false

# Remove all organizational units
Get-ADOrganizationalUnit -Filter * | Remove-ADOrganizationalUnit -Confirm:$false

# Remove all automatic installation files for AD DS
Remove-Item -Path "C:\Windows\NTDS" -Recurse -Force
Remove-Item -Path "C:\Windows\SYSVOL" -Recurse -Force

# Prompt for new administrator account details
$adminName = Read-Host -Prompt "Enter the name for the new administrator account"
$adminUsername = Read-Host -Prompt "Enter the username for the new administrator account"
$adminPassword = Read-Host -Prompt "Enter the password for the new administrator account" -AsSecureString
$adminOU = Read-Host -Prompt "Enter the distinguished name of the OU where the new administrator account should be created"

# Create the new administrator account
New-ADUser -Name $adminName -SamAccountName $adminUsername -UserPrincipalName "$adminUsername@yourdomain.com" -AccountPassword $adminPassword -Enabled $true -ChangePasswordAtLogon $true -PasswordNeverExpires $false -Path $adminOU
Add-ADGroupMember -Identity "Administrators" -Members $adminUsername
