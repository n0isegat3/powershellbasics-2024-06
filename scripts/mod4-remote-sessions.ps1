New-PSSession -ComputerName dc -Credential $creds0
Get-PSSession
Enter-PSSession -Session (Get-PSSession -Name WinRM32)


New-PSSession -ComputerName dc -Credential $creds0 -Name DcSpecificSession123
Get-PSSession
Enter-PSSession -Session (Get-PSSession -Name DcSpecificSession123)


$mySession1 = New-PSSession -ComputerName dc -Credential $creds0
Get-PSSession
Enter-PSSession -Session $mySession1
$mySession1 | Enter-PSSession




$mySession1 | Disconnect-PSSession
Get-PSSession
$mySession1 | Enter-PSSession
Get-PSSession
$mySession1 | Remove-PSSession
Get-PSSession



#just change enter-pssession to invoke-command
$mySession2 = New-PSSession -ComputerName dc -Credential $creds0
Get-PSSession
Invoke-Command -Session $mySession2 -ScriptBlock {$env:COMPUTERNAME}
Invoke-Command -Session $mySession2 -ScriptBlock {Get-Date}
Invoke-Command -Session $mySession2 -ScriptBlock {Get-Process}
Get-PSSession
$mySession2 | Remove-PSSession
Get-PSSession