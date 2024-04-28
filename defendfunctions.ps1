function testWDAC
{ 
    
    # unauthorized file. Invoke-ScriptAnalyzer -Path C:\Users\vagrant\Documents\combineddefend.ps1
   
    Start-Process -FilePath "C:\keyfinder.exe" 
    $NameofApp = "keyfinder"

    $Runs = Get-Process | Where-Object { $_.ProcessName -eq $NameofApp }

    if ($Runs) 
    {
        Write-Host "$NameofApp runs which means WDAC is not blocking this app."

    }
    else 
    {
        Write-Host "$NameofApp does not run which means WDAC is blocking this app."

    }
    
} 

##Reference: https://learn.microsoft.com/en-us/windows/security/application-security/application-control/windows-defender-application-control/deployment/wdac-deployment-guide 
## Update the path to your WDAC policy XML. 
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

#### Reference:https://learn.microsoft.com/en-us/windows/security/application-security/application-control/windows-defender-application-control/deployment/deploy-wdac-policies-with-script
# Path to the policy binary file.
function enableWDAC
{

    $PolicyBinary =  "C:\Users\vagrant\Desktop\{A244370E-44C9-4C06-B551-F6016E563076}.cip"

    # Destination folder for the policy binary file
    $DestinationFolder = $env:windir + "\System32\CodeIntegrity\CIPolicies\Active\"

    # Copy the policy binary file to the destination folder
    Copy-Item -Path $PolicyBinary -Destination $DestinationFolder -Force

    # Use gpupdate to refresh policy settings
    Write-Host "Refreshing Group Policy settings..."
    gpupdate /force
    Write-Host "Group Policy settings refreshed."
}
function resetWDAC {
        
        # Getting the Policy GUID to reset the WDAC block policy
      $PolicyXMLFile = "C:\Users\vagrant\Desktop\MyWDACPolicy.xml"
      [xml]$WDACPolicy = Get-Content -Path $PolicyXMLFile

      if(($WDACPolicy.SiPolicy.PolicyID) -ne $null)
      {
        $PolicyID = $WDACPolicy.SiPolicy.PolicyID
      }

      # Removing the policy.
      
      Remove-Item -Path "C:\Windows\System32\CodeIntegrity\CiPolicies\Active\$PolicyID.cip"
       Write-Host "Resetting WDAC Policy .........."
       Write-Host "Restarting Computer............"

       # Wait for 3 seconds
      Start-Sleep -Seconds 3
      Restart-Computer
}


cd C:\Users\vagrant\Documents


if($args[0] -eq "testwdac")
{
    
    testWDAC
}
elseif($args[0] -eq "setupwdac"){SetupWDAC}
elseif($args[0] -eq "enablewdac"){enableWDAC}
elseif($args[0] -eq "resetwdac"){resetWDAC}
else{Write-Output "Argument not recognised."}

