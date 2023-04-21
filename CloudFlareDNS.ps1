# Get the current network adapter configuration
$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}

# Set the DNS server addresses to use Cloudflare DNS
$dnsServers = "1.1.1.1", "1.0.0.1"

# Set the DNS server addresses for the IPv4 protocol on the current network adapter
Set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses $dnsServers

# Display the new DNS settings
Get-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex
