<#
.SYNOPSIS
Reviews important AD attributes used for hybrid identity matching.
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$SamAccountName
)

Import-Module ActiveDirectory

Get-ADUser -Identity $SamAccountName -Properties UserPrincipalName,mail,proxyAddresses,ObjectGUID,Enabled,DistinguishedName |
Select-Object Name,SamAccountName,Enabled,UserPrincipalName,mail,proxyAddresses,ObjectGUID,DistinguishedName
