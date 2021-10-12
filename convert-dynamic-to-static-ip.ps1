$interfaceAlias = (Get-NetAdapter).Name 
$defaultGateway = (Get-NetIPConfiguration).IPv4DefaultGateway.NextHop 
$dnsAddresses = (Get-NetIPConfiguration -InterfaceAlias $interfaceAlias).DnsServer.ServerAddresses  
$ipAddress = (Get-NetIPConfiguration).IPv4Address.IPAddress  

Set-NetIPInterface -InterfaceAlias $interfaceAlias -Dhcp Disabled 
New-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $ipAddress -PrefixLength 24 -DefaultGateway $defaultGateway 
Set-DnsClientServerAddress -InterfaceAlias $interfaceAlias -ServerAddresses $dnsAddresses

.\register-azure-devops-agent.ps1