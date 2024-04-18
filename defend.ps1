function testWDAC
{ 
    # unauthorized file.
   
    Start-Process -FilePath "C:\keyfinder.exe" -Wait
    $NameofApp = "keyfinder.exe"

    $Runs = Get-Process | Where-Object { $_.ProcessName -eq $NameofApp }

    if ($Runs) 
    {
        Write-Host "$NameofApp runs which means WDAC is blocking this app."

    }
    else 
    {
        Write-Host "$NameofApp does not run which means WDAC is blocking this app."

    }
} 
Invoke-ScriptAnalyzer defend.ps1
testWDAC
