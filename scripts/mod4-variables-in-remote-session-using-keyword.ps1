<# PowerShell Remoting
- network communication
- via Windows Remote Management (WS-Man) => connection is done over port 5985,5986
- on server by default enabled to receive the connection
- on client by default disabled to receive the connection
- enabled by Enable-PSRemoting (or by GPO, registry, etc., Microsoft Intune)
- to be able to use it you need to have administrator privileges on the target
- remoting using interactive or non-interactive approach
#>

Enter-PSSession -ComputerName dc -Credential (Get-Credential)

# runas /user:FSOCIETY\t0a.elliot powershell.exe

$myCreds = Get-Credential
Enter-PSSession -ComputerName dc -Credential $myCreds



$myCreds = Get-Credential
Enter-PSSession -ComputerName dc -Credential $myCreds
Enter-PSSession -ComputerName dc -Credential $myCreds
Enter-PSSession -ComputerName dc -Credential $myCreds

$myCreds = Get-Credential
New-PSSession -ComputerName dc -Credential $myCreds
New-PSSession -ComputerName dc -Credential $myCreds -Name sessiontoDC
Get-PSSession
Remove-PSSession -Id 7
Get-PSSession
Get-PSSession -Name sessiontoDC


$sessionToDC = New-PSSession -ComputerName dc -Credential $myCreds
Get-PSSession
$sessionToDC | Get-PSSession
#$sessionToDC | Remove-PSSession
$sessionToDC | Disconnect-PSSession
$sessionToDC | Get-PSSession
$sessionToDC | Connect-PSSession
$sessionToDC | Get-PSSession
$sessionToDC | Disconnect-PSSession
Enter-PSSession -Session $sessionToDC

# arguments, using

# integrated remoting
Get-Process -ComputerName dc
Get-WmiObject -Class win32_bios -ComputerName dc -Credential $myCreds # remote WMI, over RCP tcp135, dynamic RPC range

# remoting using invoke-command
Invoke-Command -ComputerName dc -Credential $myCreds -ScriptBlock {
    Get-Process
}
Invoke-Command -ComputerName dc -Credential $myCreds -ScriptBlock {
    Get-WmiObject -Class win32_bios
}
$sessionToDC = New-PSSession -ComputerName dc -Credential $myCreds
Invoke-Command -Session $sessionToDC -ScriptBlock {
    hostname
}


$text1 = 'string data stored in text1'
$text1
Write-Host $text1 -ForegroundColor Green
Invoke-Command -Session $sessionToDC -ScriptBlock {
    Write-Host $text1 -ForegroundColor Green
}
Invoke-Command -Session $sessionToDC -ScriptBlock {
    Write-Host $args -ForegroundColor Green
} -ArgumentList $text1

$text2 = 'string data stored in text2'
Write-Host $text2 -ForegroundColor Green
Invoke-Command -Session $sessionToDC -ScriptBlock {
    Write-Host $args -ForegroundColor Green
} -ArgumentList $text1, $text2

Invoke-Command -Session $sessionToDC -ScriptBlock {
    Write-Host ($args | Select-Object -First 1) -ForegroundColor Green
} -ArgumentList $text1, $text2

Invoke-Command -Session $sessionToDC -ScriptBlock {
    Write-Host ($args | Select-Object -First 1) -ForegroundColor Green
    Write-Host ($args | Select-Object -First 1 -skip 1) -ForegroundColor Green
} -ArgumentList $text1, $text2

$processes = Get-Process
$processes | Select-Object -First 1
$processes | Select-Object -First 1 -Skip
$processes[0]
$processes[1]
$processes[-1]
$processes[-2]

Invoke-Command -Session $sessionToDC -ScriptBlock {
    Write-Host $args[0] -ForegroundColor Green
    Write-Host $args[1] -ForegroundColor Green
} -ArgumentList $text1, $text2

Invoke-Command -Session $sessionToDC -ScriptBlock {
    Write-Host $args[0] -ForegroundColor Green
    Write-Host $args[1] -ForegroundColor Green
} -ArgumentList $text2, $text1

Invoke-Command -Session $sessionToDC -ScriptBlock {
    Write-Host $using:text1 -ForegroundColor Green
    Write-Host $using:text2 -ForegroundColor Green
}



Get-Process | Where-Object { $_.WorkingSet64 -gt 100MB }

Invoke-Command -Session $sessionToDC -ScriptBlock {
    Get-Process | Where-Object { $_.WorkingSet64 -gt 100MB }
}

Invoke-Command -Session $sessionToDC -ScriptBlock {
    Get-Process
} | Where-Object { $_.WorkingSet64 -gt 100MB }

Invoke-Command -Session $sessionToDC -ScriptBlock { Get-Process } | Where-Object { $_.WorkingSet64 -gt 100MB }



Invoke-Command -Session $sessionToDC -ScriptBlock {
    Invoke-Command -ComputerName app -ScriptBlock {
        hostname
    }
}
