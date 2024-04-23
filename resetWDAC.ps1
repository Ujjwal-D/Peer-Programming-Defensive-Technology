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
      Restart-Computer
    }
    # calling the function.
    resetWDAC