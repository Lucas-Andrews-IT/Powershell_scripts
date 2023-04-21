# Set up update configuration
$UpdateSession = New-Object -ComObject Microsoft.Update.Session
$UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
$Updates = $UpdateSearcher.Search("IsInstalled=0")

# Download and install updates
if ($Updates.Updates.Count -eq 0) {
    Write-Output "No updates available."
} else {
    foreach ($Update in $Updates.Updates) {
        $UpdateTitle = $Update.Title
        $UpdateSize = $Update.MaxDownloadSize
        Write-Output "Downloading update: $UpdateTitle ($UpdateSize bytes)"
        $UpdateDownloader = $UpdateSession.CreateUpdateDownloader()
        $UpdateDownloader.Updates = $Update
        $UpdateDownloader.Download()
        Write-Output "Installing update: $UpdateTitle"
        $UpdateInstaller = $UpdateSession.CreateUpdateInstaller()
        $UpdateInstaller.Updates = $Update
        $InstallResult = $UpdateInstaller.Install()
        Write-Output "Installation result: $($InstallResult.ResultCode)"
    }
}
