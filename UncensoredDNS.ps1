$adapter = Get-NetAdapter | where {$_.Status -eq "Up"}

# Set the IPv4 DNS server address
Set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses "91.239.100.100","89.233.43.71"

# Set the IPv6 DNS server address
Set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses "2001:67c:28a4::","2001:67c:28a4:1::1"

Write-Host "DNS settings updated to uncensoreddns for adapter $($adapter.Name)"
