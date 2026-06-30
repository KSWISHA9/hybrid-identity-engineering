# Hard Match Checklist
# Hard match uses ImmutableID to link a cloud object to an on-prem AD object.

Write-Host "Hard Match Validation Checklist" -ForegroundColor Cyan
Write-Host "1. Get on-prem AD ObjectGUID."
Write-Host "2. Convert ObjectGUID to ImmutableID."
Write-Host "3. Set cloud object ImmutableID."
Write-Host "4. Run delta sync."
Write-Host "5. Validate the cloud object is linked to the on-prem object."
