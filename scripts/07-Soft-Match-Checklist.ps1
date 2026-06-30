# Soft Match Checklist
# Soft match typically uses matching SMTP/proxyAddresses values to connect an on-prem AD object to an existing cloud object.

Write-Host "Soft Match Validation Checklist" -ForegroundColor Cyan
Write-Host "1. Confirm cloud user exists."
Write-Host "2. Confirm on-prem user has matching primary SMTP/proxyAddresses value."
Write-Host "3. Confirm no duplicate proxyAddresses exist."
Write-Host "4. Run delta sync."
Write-Host "5. Validate cloud object is now synced from on-prem AD."
