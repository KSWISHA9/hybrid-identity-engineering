# Verify on-premises AD user identity attributes

param(
    [string]$SamAccountName
)

Get-ADUser $SamAccountName -Properties UserPrincipalName,mail,proxyAddresses,ObjectGUID |
Select-Object SamAccountName,UserPrincipalName,mail,proxyAddresses,ObjectGUID
