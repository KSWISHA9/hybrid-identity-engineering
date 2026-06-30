# Convert an on-premises AD ObjectGUID to ImmutableID format

param(
    [string]$SamAccountName
)

$User = Get-ADUser $SamAccountName -Properties ObjectGUID

[Convert]::ToBase64String($User.ObjectGUID.ToByteArray())
