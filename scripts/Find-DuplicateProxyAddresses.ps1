<#
.SYNOPSIS
Finds duplicate proxyAddresses values in Active Directory.
#>

Import-Module ActiveDirectory

$proxyObjects = Get-ADUser -Filter * -Properties proxyAddresses |
ForEach-Object {
    $sam = $_.SamAccountName
    foreach ($proxy in $_.proxyAddresses) {
        [PSCustomObject]@{
            SamAccountName = $sam
            ProxyAddress   = $proxy.ToLower()
        }
    }
}

$proxyObjects |
Group-Object ProxyAddress |
Where-Object { $_.Count -gt 1 } |
ForEach-Object {
    [PSCustomObject]@{
        ProxyAddress = $_.Name
        Count        = $_.Count
        Users        = ($_.Group.SamAccountName -join ", ")
    }
}
