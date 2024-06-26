$creds0 = Get-Credential -UserName fsociety\t0a.elliot -Message 'creds for tier 0 systems'

Invoke-Command -ComputerName dc,cl2 -Credential $creds0 -ScriptBlock {
    Write-Host $env:computername (Get-Date)
    Write-Host $env:computername now sleeping for 5 seconds
    Start-Sleep 5
    Write-Host $env:computername (Get-Date)
}

# operations done in parallels for multiple remote hosts