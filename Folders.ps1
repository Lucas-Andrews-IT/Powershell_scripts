# Load the Excel COM object
$excel = New-Object -ComObject Excel.Application

# Open the Excel file
$workbook = $excel.Workbooks.Open("C:\Folders.xlsx")

# Select the worksheet you want to use
$worksheet = $workbook.Worksheets.Item("Sheet1")

# Set the starting row and column
$row = 2
$col = 1

# Loop through the rows in the worksheet
while ($worksheet.Cells.Item($row,$col).Value2 -ne $null) {
    # Get the folder name from the worksheet
    $folderName = $worksheet.Cells.Item($row,$col).Value2

    # Create the folder
    New-Item -ItemType Directory -Path $folderName

    # Check for subfolders
    $subfolders = $worksheet.Cells.Item($row,$col+1).Value2

    if ($subfolders -ne $null) {
        # Split the subfolders into an array
        $subfolderArray = $subfolders -split ','

        # Loop through the subfolders and create them
        foreach ($subfolder in $subfolderArray) {
            $subfolderPath = Join-Path -Path $folderName -ChildPath $subfolder
            New-Item -ItemType Directory -Path $subfolderPath
        }
    }

    # Move to the next row
    $row++
}

# Close the Excel file
$workbook.Close()

# Quit Excel
$excel.Quit()