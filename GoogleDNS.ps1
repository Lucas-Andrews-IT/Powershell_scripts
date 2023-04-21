# Get the current network adapter
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }

# Set the DNS server addresses
$dns = "8.8.8.8", "8.8.4.4"

# Set the new DNS server addresses
$dnsserver = $adapter | Get-DnsClientServerAddress
$dnsserver.ServerAddresses = $dns
Set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses $dnsserver.ServerAddresses

# Confirm the new DNS server addresses
Write-Host "New DNS server addresses:"
(Get-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex).ServerAddresses
