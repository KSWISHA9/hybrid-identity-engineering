# Check for duplicate proxyAddresses values in Active Directory

$Users = Get-ADUser -Filter * -Properties proxyAddresses

$ProxyValues = foreach ($User in $Users) {
    foreach ($Proxy in $User.proxyAddresses) {
        [PSCustomObject]@{
            SamAccountName = $User.SamAccountName
            ProxyAddress   = $Proxy
        }
    }
}

$ProxyValues |
Group-Object ProxyAddress |
Where-Object { $_.Count -gt 1 } |
Select-Object Name,Count
