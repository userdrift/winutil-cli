function Set-WinUtilDNS {
    <#

    .SYNOPSIS
        Sets the DNS of all interfaces that are in the "Up" state. It will lookup the values from the DNS.Json file

    .PARAMETER DNSProvider
        The DNS provider to set the DNS server to

    .EXAMPLE
        Set-WinUtilDNS -DNSProvider "google"

    #>
    param($DNSProvider)
    if($DNSProvider -eq "Default") {return}
    try {
        $_path = "$PSScriptRoot\..\..\config\dns.json"
        $_raw = Get-Content -Path $_path -Raw | ConvertFrom-Json

        $Adapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
        Write-Host "Ensuring DNS is set to $DNSProvider on the following interfaces"
        Write-Host $($Adapters | Out-String)

        Foreach ($Adapter in $Adapters) {
            if($DNSProvider -eq "DHCP") {
                Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ResetServerAddresses
            } else {
                $sync = $_raw.$DNSProvider
                Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ServerAddresses ($sync.Primary, $sync.Secondary)
                if ($sync.PSObject.Properties.Name -contains "Primary6") {
                    Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ServerAddresses ($sync.Primary6, $sync.Secondary6)
                }
            }
        }
    } catch {
        Write-Warning "Unable to set DNS Provider due to an unhandled exception"
        Write-Warning $psitem.Exception.StackTrace
    }
}
