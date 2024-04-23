# This is a basic script layout for handling command line arguments in PowerShell

param (
    [string]$cmd = $null  # Capture the first command line argument
)

function testWDAC {
    Write-Host "Testing Windows Defender Application Control..."
    try {
        Start-Process -FilePath "C:\keyfinder.exe" -Wait -ErrorAction Stop
        Write-Host "keyfinder.exe runs which means WDAC is NOT effectively blocking this app."
    }
    catch {
        Write-Host "keyfinder.exe does not run which means WDAC is effectively blocking this app."
    }
}


function anotherFunction {
    Write-Host "This is another function..."
}

# Handling the command line argument
switch ($cmd) {
    'testWDAC' {
        testWDAC
    }
    'anotherCommand' {
        anotherFunction
    }
    default {
        Write-Host "No valid command provided or command not recognized."
    }
}

cd "C:\Users\vagrant\Documents"
Get-ChildItem
.\defend.ps1 testWDAC
