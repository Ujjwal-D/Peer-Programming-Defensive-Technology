## Reference: https://learn.microsoft.com/en-us/windows/security/application-security/application-control/windows-defender-application-control/deployment/wdac-deployment-guide

## Update the path to your WDAC policy XML

function SetupWDAC{
 $WDACPolicyXMLFile = $env:USERPROFILE + "\Desktop\MyWDACPolicy.xml"
 [xml]$WDACPolicy = Get-Content -Path $WDACPolicyXMLFile
 if (($WDACPolicy.SiPolicy.PolicyID) -ne $null) ## Multiple policy format (For Windows builds 1903+ only, including Server 2022)
 {
     $PolicyID = $WDACPolicy.SiPolicy.PolicyID
     $PolicyBinary = $PolicyID+".cip"
 }
 else ## Single policy format (Windows Server 2016 and 2019, and Windows 10 1809 LTSC)
 {
     $PolicyBinary = "SiPolicy.p7b"
 }

  
 ## Binary file will be written to the desktop
 ConvertFrom-CIPolicy -XmlFilePath $WDACPolicyXMLFile -BinaryFilePath $env:USERPROFILE\Desktop\$PolicyBinary


$PolicyName= "Lamna_FullyManagedClients_Audit"
$LamnaPolicy=$env:userprofile+"\Desktop\"+$PolicyName+".xml"
$EventsPolicy=$env:userprofile+"\Desktop\EventsPolicy.xml"
$EventsPolicyWarnings=$env:userprofile+"\Desktop\EventsPolicyWarnings.txt"

New-CIPolicy -FilePath $EventsPolicy -Audit -Level FilePublisher -Fallback SignedVersion,FilePublisher,Hash -UserPEs -MultiplePolicyFormat 3> $EventsPolicyWarnings
 }

 SetupWDAC
 
