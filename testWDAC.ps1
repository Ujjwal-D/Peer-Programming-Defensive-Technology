## Reference: https://learn.microsoft.com/en-us/windows/security/application-security/application-control/windows-defender-application-control/deployment/audit-wdac-policies

function testWDAC {
    # Attempt to start an unauthorized application
    try {
        Start-Process -FilePath "C:\keyfinder.exe" -Wait -ErrorAction Stop
        Write-Host "keyfinder.exe runs which means WDAC is NOT effectively blocking this app."
    }
    catch {
        Write-Host "keyfinder.exe does not run which means WDAC is effectively blocking this app."
    }
}
testWDAC


$PolicyName= "Lamna_FullyManagedClients_Audit"
$LamnaPolicy=$env:userprofile+"\Desktop\"+$PolicyName+".xml"
$EventsPolicy=$env:userprofile+"\Desktop\EventsPolicy.xml"
$EventsPolicyWarnings=$env:userprofile+"\Desktop\EventsPolicyWarnings.txt"

New-CIPolicy -FilePath $EventsPolicy -Audit -Level FilePublisher -Fallback SignedVersion,FilePublisher,Hash -UserPEs -MultiplePolicyFormat 3> $EventsPolicyWarnings