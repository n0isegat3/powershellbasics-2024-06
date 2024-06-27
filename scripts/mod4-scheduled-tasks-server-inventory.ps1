'dc' | Out-File C:\Temp\servers.txt
'app' | Out-File C:\temp\servers.txt -Append

$servers = get-content C:\Temp\servers.txt
$servers | Measure-Object
$serverCreds = Get-Credential
$partialTaskName = 'Defender'

$servers | ForEach-Object {
    Invoke-Command -ComputerName $_ -Credential $serverCreds -ScriptBlock {
        Write-Host "Enumerating Scheduled Task with Partitial Name $($using:partialTaskName) on $($env:COMPUTERNAME)" -ForegroundColor Yellow
        Get-ScheduledTask -TaskName "*$($using:partialTaskName)*"
    }
}