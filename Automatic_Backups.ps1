# Define backup paths and filenames
$backupPath = "C:\Backup"
$fullBackupFile = "full_backup_$(Get-Date -Format 'yyyyMMdd').bak"
$differentialBackupFile = "differential_backup_$(Get-Date -Format 'yyyyMMdd').bak"

# Create backup folder if it doesn't exist
if (!(Test-Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath
}

# Schedule full backup once a month
$fullBackupSchedule = New-ScheduledTaskTrigger -Monthly -At "12:00PM" -DaysOfMonth 1
$fullBackupAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -Command `"`$sqlcmdArgs = '-S <server_name> -E -Q `"`$sql = 'BACKUP DATABASE <database_name> TO DISK=''$backupPath\$fullBackupFile'' WITH FORMAT, INIT`"; Invoke-Sqlcmd `$sqlcmdArgs `$sql`""
$fullBackupTask = New-ScheduledTask -Action $fullBackupAction -Trigger $fullBackupSchedule -Description "Full Backup Task"
Register-ScheduledTask -TaskName "Full Backup Task" -InputObject $fullBackupTask

# Schedule differential backup every 7 days
$differentialBackupSchedule = New-ScheduledTaskTrigger -Weekly -At "12:00PM" -DaysOfWeek Monday
$differentialBackupAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -Command `"`$sqlcmdArgs = '-S <server_name> -E -Q `"`$sql = 'BACKUP DATABASE <database_name> TO DISK=''$backupPath\$differentialBackupFile'' WITH DIFFERENTIAL, NOFORMAT, NOINIT`"; Invoke-Sqlcmd `$sqlcmdArgs `$sql`""
$differentialBackupTask = New-ScheduledTask -Action $differentialBackupAction -Trigger $differentialBackupSchedule -Description "Differential Backup Task"
Register-ScheduledTask -TaskName "Differential Backup Task" -InputObject $differentialBackupTask

# Remove differential backups older than 2 weeks
Get-ChildItem $backupPath -Filter "differential_backup_*.bak" | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-14) } | Remove-Item -Force

# Run the scheduled tasks in the background and start up automatically
Start-ScheduledTask -TaskName "Full Backup Task"
Start-ScheduledTask -TaskName "Differential Backup Task"
