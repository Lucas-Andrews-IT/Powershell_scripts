# Install AD DS roles and services
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Prompt for domain name and NetBIOS name
$domainName = Read-Host "Enter the name of the new domain (e.g. contoso.com)"
$netBiosName = Read-Host "Enter the NetBIOS name for the new domain (e.g. CONTOSO)"

# Install AD DS and create a new forest
Install-ADDSForest -DomainName $domainName -DomainNetbiosName $netBiosName -InstallDns -Force

# Prompt for domain admin credentials
$adminUserName = Read-Host "Enter the username for the domain administrator account"
$adminPassword = Read-Host "Enter the password for the domain administrator account" -AsSecureString
$adminCreds = New-Object System.Management.Automation.PSCredential ($adminUserName, $adminPassword)

# Prompt for default OU
$defaultOU = Read-Host "Enter the distinguished name of the default organizational unit (OU)"

# Create a new AD user
$firstName = Read-Host "Enter the first name of the new user"
$lastName = Read-Host "Enter the last name of the new user"
$username = Read-Host "Enter the username of the new user"
$password = Read-Host "Enter the password for the new user" -AsSecureString
$newUser = New-ADUser -Name "$firstName $lastName" -SamAccountName $username -AccountPassword $password -Enabled $true -Path $defaultOU -Credential $adminCreds

# Output confirmation message
Write-Host "AD DS roles and services have been installed, and a new user has been created."
