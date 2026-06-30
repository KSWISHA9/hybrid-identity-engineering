<#
.SYNOPSIS
Gets the ImmutableID-style Base64 value from an on-premises AD user's ObjectGUID.

.DESCRIPTION
This script retrieves an Active Directory user's ObjectGUID and converts it to Base64.
This is useful when reviewing hard match scenarios in Microsoft Entra hybrid identity environments.

.NOTES
Use carefully. Do not assign ImmutableID values without validating the target cloud object.
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$SamAccountName
)

Import-Module ActiveDirectory

$user = Get-ADUser -Identity $SamAccountName -Properties ObjectGUID

[PSCustomObject]@{
    SamAccountName = $user.SamAccountName
    ObjectGUID     = $user.ObjectGUID
    ImmutableID    = [System.Convert]::ToBase64String($user.ObjectGUID.ToByteArray())
}
