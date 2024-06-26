$cred0 = New-Object -TypeName pscredential -ArgumentList (
    'fsociety\t0a.elliot',
    (ConvertTo-SecureString -AsPlainText -Force -String (Get-ItemPropertyValue -Path HKCU:\SOFTWARE\CredsStore -Name creds0))
)

Enter-PSSession -ComputerName dc -Credential $cred0



<#
prep on the client:
New-Item -Path HKCU:\SOFTWARE\CredsStore
New-ItemProperty -Path HKCU:\SOFTWARE\CredsStore -Name creds0 -Value 'P@ssw0rd'
#>