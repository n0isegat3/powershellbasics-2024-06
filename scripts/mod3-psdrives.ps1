Get-PSProvider

Get-PSDrive

Set-Location .\Desktop

Set-Location D:

Set-Location HKCU:

Get-ChildItem
dir
ls

Set-Location .\SOFTWARE
Get-ChildItem

Set-Location cert:
Get-ChildItem
Set-Location CurrentUser
set-location ..
Set-Location .\\CurrentUser
set-location .\CurrentUser
set-location C:
Set-Location Cert:\CurrentUser
Set-Location .\My
Get-ChildItem


New-SelfSignedCertificate -Subject test2 -CertStoreLocation Cert:\CurrentUser\my -NotAfter '2025-06-26'

Get-ChildItem | select -f 1 -prop *
Get-ChildItem | Get-Member

# Export-PfxCertificate
Get-ChildItem | Where-Object { $_.subject -eq 'cn=test1' } | Select-Object -Property Thumbprint

Get-ChildItem | Where-Object { $_.subject -eq 'cn=test1' } | Select-Object -ExpandProperty Thumbprint
(Get-ChildItem | Where-Object { $_.subject -eq 'cn=test1' }).Thumbprint

$pfxData = (Get-ChildItem | Where-Object { $_.subject -eq 'cn=test1' }).Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx, (ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force))
$pfxData
[system.io.file]::WriteAllBytes('C:\Temp\exported.pfx', $PfxData)

Export-PfxCertificate `
    -Cert (Get-ChildItem | Where-Object { $_.subject -eq 'cn=test1' }) `
    -Password (ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force) `
    -FilePath C:\temp\exportedAgain.pfx



New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
Get-PSDrive
Set-Location HKU:
Get-ChildItem

New-PSDrive -Name MyDesktop -PSProvider FileSystem -Root C:\Users\t2a.elliot\Desktop
Get-PSDrive
Set-Location mydesktop:
Set-Location C:
Remove-PSDrive -Name MyDesktop

New-PSDrive -Name shareOnDC -PSProvider FileSystem -Root \\dc\share
Set-Location shareOnDC:
gci

New-PSDrive -Name Z -PSProvider FileSystem -Root \\dc\share -Persist
cd Z:
gci