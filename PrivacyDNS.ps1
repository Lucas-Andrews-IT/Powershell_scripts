# Set DNS server addresses
$dnsServer = "84.200.69.80", "84.200.70.40"

# Get current network adapter configuration
$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}

# Set DNS server addresses for IPv4 configuration
$ipv4Config = $adapter | Get-NetIPConfiguration -AddressFamily IPv4
$ipv4Config | Set-DnsClientServerAddress -ServerAddresses $dnsServer

# Display updated configuration
$adapter | Get-NetIPConfiguration
