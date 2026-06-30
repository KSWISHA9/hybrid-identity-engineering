<#
.SYNOPSIS
Finds duplicate UserPrincipalName values in Active Directory.
#>

Import-Module ActiveDirectory

Get-ADUser -Filter * -Properties UserPrincipalName |
Where-Object { $_.UserPrincipalName } |
Group-Object UserPrincipalName |
Where-Object { $_.Count -gt 1 } |
ForEach-Object {
    [PSCustomObject]@{
        UserPrincipalName = $_.Name
        Count             = $_.Count
        Users             = ($_.Group.SamAccountName -join ", ")
    }
}
