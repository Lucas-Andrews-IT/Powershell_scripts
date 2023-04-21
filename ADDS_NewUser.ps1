# Import the ActiveDirectory module
Import-Module ActiveDirectory

# This script assumes that you have an Excel file named users.xlsx located at C:\, with the following columns in the first worksheet:

# First Name
# Last Name
# Username
# Password (optional)
# Department
# The script reads each row of the worksheet, extracts the user data, and uses the New-ADUser cmdlet to create a new user account in Active Directory. If no password is provided in the Excel file, a random password is generated using alphanumeric characters.

# Once the script has finished creating the new user accounts, it closes the Excel file and quits the Excel application.


# Set the path to the Excel file
$excelFile = "C:\users.xlsx"

# Create an Excel application object
$excel = New-Object -ComObject Excel.Application

# Open the Excel file
$workbook = $excel.Workbooks.Open($excelFile)

# Select the first worksheet
$worksheet = $workbook.Sheets.Item(1)

# Get the maximum row and column counts
$rowCount = ($worksheet.UsedRange.Rows).Count
$colCount = ($worksheet.UsedRange.Columns).Count

# Loop through each row in the worksheet
for ($i = 2; $i -le $rowCount; $i++) {
    # Read the data from the worksheet
    $firstName = $worksheet.Cells.Item($i, 1).Value2
    $lastName = $worksheet.Cells.Item($i, 2).Value2
    $username = $worksheet.Cells.Item($i, 3).Value2
    $password = $worksheet.Cells.Item($i, 4).Value2
    $department = $worksheet.Cells.Item($i, 5).Value2

    # Generate a random password if none is provided
    if (!$password) {
        $password = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 10 | ForEach-Object {[char]$_})
    }

    # Create the new user account
    $displayName = "$firstName $lastName"
    $userPrincipalName = "$username@thesleepylabs.com"
    New-ADUser -Name $displayName -GivenName $firstName -Surname $lastName -UserPrincipalName $userPrincipalName -SamAccountName $username -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Department $department -Enabled $true
}

# Close the Excel file
$workbook.Close()
$excel.Quit()