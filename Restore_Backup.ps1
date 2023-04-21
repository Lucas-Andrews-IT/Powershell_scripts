# Get the path to the backup file
$backupPath = "C:\Backup\"

# Get the latest full backup file
$fullBackup = Get-ChildItem $backupPath -Filter "FullBackup*.bak" | Sort-Object LastWriteTime | Select-Object -Last 1

# Get the latest differential backup file
$differentialBackup = Get-ChildItem $backupPath -Filter "DifferentialBackup*.bak" | Sort-Object LastWriteTime | Select-Object -Last 1

# Restore the full backup
$restoreCommand = "RESTORE DATABASE MyDatabase FROM DISK='" + $fullBackup.FullName + "' WITH NORECOVERY"

# If there is a differential backup, restore it too
if ($differentialBackup) {
    $restoreCommand += ", DISK='" + $differentialBackup.FullName + "' WITH RECOVERY"
}

# Run the restore command
Invoke-Sqlcmd -ServerInstance "MyServer\MyInstance" -Database "master" -Query $restoreCommand

Write-Host "Database restore complete."
