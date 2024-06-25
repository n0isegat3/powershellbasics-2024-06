

Get-Process | Select-Object -First 1 -Property processname, id, PM

Get-Process | Select-Object -First 1 -Property *


get-service | Select-Object -first 1 -Property *

get-disk | Select-Object -first 1 -Property *

get-service | Select-Object -first 5 -skip 10



get-disk
get-disk | Get-Member
get-disk | select-object -Property number, friendlyname


Get-Process -Name cmd
Get-Process -Id 96

Get-Process | Get-Member
Get-Process | Select-Object -First 3 -Property handlecount

# get all process with handlecount greater than 2000... filter defined using parameters
Get-Process | Where-Object -Property handlecount -gt -Value 2000
Get-Process | Where-Object -gt -Value 2000 -Property handlecount

# get all process with handlecount greater than 2000... filter defined using filterscript
Get-Process | Where-Object -FilterScript { $PSItem.HandleCount -gt 2000 }
Get-Process | Where-Object -FilterScript { $_.HandleCount -gt 2000 }


# get all process with handlecount greater than 1000 and less then 2000... filter defined using parameters
# !!! NOT POSSIBLE

# get all process with handlecount greater than 1000 and less then 2000... filter defined using parameters
Get-Process | Where-Object -FilterScript { $PSItem.HandleCount -gt 1000 -and $PSItem.HandleCount -lt 2000 }
Get-Process | Where-Object -FilterScript { $_.HandleCount -gt 1000 -and $_.HandleCount -lt 2000 }



'jan' -ceq 'JAN'
'jan' -clike "JA*"

1 -eq 2
10 -lt 2


<# scriptblock
{}
#>

Get-Process | Select-Object -Property Name

'justastring' | Select-Object -Property name

Get-Service | Select-Object -first 1 -Property *

Get-Service | Select-Object -Property Name



Get-Process -name notepad | Select-Object -First 1 | select-object -property sessionid | Stop-Process

Stop-Process -SessionId 2

Get-Process | Select-Object -First 1 | Get-Member
Get-Process | Select-Object -First 1 | Select-Object -Property Name | Get-Member


Get-Content -Path .\processesToStop.txt | Select-Object -First 2
Get-Content -Path .\processesToStop.txt | Select-Object -First 2 | Select-Object -Property @{name = 'Name'; expression = { $_ } } | Format-List
Get-Content -Path .\processesToStop.txt | Select-Object -First 1 | Select-Object -Property @{name = 'Name'; expression = { $_ } } | Stop-Process


Get-Content -Path .\computers.txt | Select-Object -First 1 | Select-Object -Property @{name = 'ComputerName'; expression = { $_ } } | Format-List

Get-Content -Path .\computers.txt | Select-Object -First 1 | Select-Object -Property @{name = 'ComputerName'; expression = { $_ } } | Get-Process
Get-Content -Path .\computers.txt | Select-Object -First 1 | Select-Object -Property @{name = 'ComputerName'; expression = { $_ } } | Get-Process
Get-Content -Path .\computers.txt | Select-Object -First 1 | Select-Object -Property @{n = 'ComputerName'; e = { $_ } } | Get-Process

Get-Process -ComputerName dc

# CALCULATED PROPERTY
@{name = ''; expression = {} }
@{n = ''; e = {} }



# LIMITING
Get-Process | Select-Object -Property Name -Unique

# SORTING
Get-Process | Get-Member
Get-Process | Select-Object -First 1 -Property *
Get-Process | Sort-Object -Property PrivateMemorySize64 -Descending
Get-Process | sort -prop PrivateMemorySize64 -desc


# GROUPING
Get-Process | Group-Object -Property ProcessName
Get-ChildItem -Path C:\Windows\system32 | Group-Object -Property Extension

# MEASURE
Get-Process | Measure-Object
Get-Process | Measure-Object -Property HandleCount -Sum
Get-Process | Measure-Object -Property HandleCount -Sum -Average -Maximum -Minimum
Get-Process | Select-Object -Property Name -Unique | Measure-Object

# FILTERING
Get-Process | Where-Object -FilterScript { $_.HandleCount -eq 0 }
Get-Process | Where-Object { $_.HandleCount -eq 0 }
Get-Process | Where-Object -Property HandleCount -Value 0 -EQ

# SAVING RESULTS
Get-Process | Select-Object -Property Name, Id, HandleCount | Out-File .\processDetails.txt
Get-Process | Select-Object -Property Name, Id, HandleCount | Out-File .\processDetails.txt -Append
Get-Process | Select-Object -Property Name, Id, HandleCount | Out-File .\processDetails.txt -Encoding utf8

Get-Printer
Get-Process | Select-Object -Property Name, Id, HandleCount | Out-Printer -Name 'Microsoft Print to PDF'

Get-Printer -Name *PDF* | Where-Object { $_.DriverName -like "*PDF*" } | Select-Object -ExpandProperty name
(Get-Printer -Name *PDF* | Where-Object { $_.DriverName -like "*PDF*" }).Name
Get-Process | Select-Object -Property Name, Id, HandleCount | Out-Printer -Name (Get-Printer -Name *PDF* | Where-Object { $_.DriverName -like "*PDF*" }).Name

Get-Process | Select-Object -Property Name, Id, HandleCount | Export-Csv -Path .\processDetails.csv
Get-Process | Select-Object -Property Name, Id, HandleCount | Export-Csv -Path .\processDetails.csv -NoTypeInformation

Get-Process | Select-Object -Property Name, Id, HandleCount -First 3 | Export-Csv -Path .\processDetails-appended.csv -NoTypeInformation
Get-Process | Select-Object -Property Name, Id, HandleCount -Last 4 | Export-Csv -Path .\processDetails-appended.csv -NoTypeInformation -Append
Get-Process | Select-Object -Property Name, Id, HandleCount -Last 4 |
Export-Csv -Path .\processDetails-appended.csv -NoTypeInformation -Append -Encoding utf8

Get-Process | Select-Object -Property Name, Id, HandleCount -First 2 | ConvertTo-Json | Out-File .\processDetails.json
Get-Process | Select-Object -Property Name, Id, HandleCount -First 2 | ConvertTo-Json -Compress -Depth 100 | Out-File .\processDetails.json

Get-Process | Select-Object -Property Name, Id, HandleCount -First 2 | ConvertTo-Html | Out-File .\processDetails.html

Get-Process | Select-Object -Property Name, Id, HandleCount -First 2 |
ConvertTo-Html -Title 'Proc Details' -PreContent 'These are details for processes' -PostContent (Get-Date)  |
Out-File .\processDetails.html

# LOAD/IMPORT DATA
Get-Content .\processDetails.txt -Encoding utf8

Import-Csv -Path .\processDetails.csv -Encoding utf8

Get-Process | Select-Object -Property Name, Id, HandleCount | Get-Member
Get-Process | Select-Object -Property Name, Id, HandleCount | Export-Csv -Path .\processDetails.csv
Import-Csv -Path .\processDetails.csv | Get-Member

Get-Process | Select-Object -Property Name, Id, HandleCount | Export-Csv -Path .\processDetails.csv -Delimiter "`t"
Import-Csv -Path .\processDetails.csv -Delimiter "`t"
Import-Csv -Path .\processDetails.csv -Delimiter "`t" | Select-Object -Property Name -First 2

Get-Content -Path .\processDetails.json -Raw | ConvertFrom-Json | Format-List

# FORMATTING OUTPUT
Get-Process | Select-Object -First 3

Get-Process | Select-Object -First 3 | Format-List -Property *

Get-Process | Select-Object -First 100 | Format-Wide -Property Id -Column 20
Get-Process | Select-Object -First 100 | Format-Wide -Property Id -Column 60 # this is bad! too many columns! output is trimmed!

Get-Process | Select-Object -First 3 | Format-Table -Property Name, Id, HandleCount, VirtualMemorySize -AutoSize

Get-Service | Get-Member
Get-Service | Select-Object -First 20 | Format-Table -Property Status, Name, DisplayName, CanShutdown, Site, ServiceType, StartType, SeviceHandle, MachineName, DependentServices -Wrap -AutoSize

Get-Process | Select-Object -First 3 | Out-GridView
Get-Process | Select-Object -First 3 | Out-GridView -OutputMode Multiple -Title 'Select processes' | Select-Object -Property id

'blue', 'red', 'green' | Out-GridView -Title 'select your favorite color' -OutputMode Single
