
# Path to the policy binary file
$PolicyBinary =  "C:\Users\vagrant\Desktop\{A244370E-44C9-4C06-B551-F6016E563076}.cip"

# Destination folder for the policy binary file
$DestinationFolder = $env:windir + "\System32\CodeIntegrity\CIPolicies\Active\"

# Copy the policy binary file to the destination folder
Copy-Item -Path $PolicyBinary -Destination $DestinationFolder -Force

# Use gpupdate to refresh policy settings
Write-Host "Refreshing Group Policy settings..."
gpupdate /force
Write-Host "Group Policy settings refreshed."
