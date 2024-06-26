# WMI - Windows Management Instrumentation
# CIM - Common information model
# WMI -> database <- CIM

# WMI: Get-WMIobject
# CIM: Get-CIMInstance

# Invoke-WmiMethod
# Invoke-CimMethod

# database
# namespaces ( ~ groups of tables)
# classes ( ~ tables)
# objects/instances ( ~ rows)

Get-WmiObject -Class win32_bios
Get-WmiObject -Class win32_product

Get-CimInstance -ClassName win32_bios
Get-CimInstance -ClassName win32_product

Get-CimInstance -ClassName msvm_computersystem -Namespace 'root\virtualization\v2'
Get-WmiObject -Class __NAMESPACE -List

# WMI - WQL - WMI Query Lang.
# select * from win32_logicaldisk where deviceid=C:
Get-CimInstance win32_logicaldisk -Filter 'deviceid="C:"'
Get-CimInstance win32_logicaldisk -Filter 'drivetype="3"'

Get-CimInstance -Query 'select * from win32_logicaldisk'
Get-CimInstance -Query 'select * from win32_logicaldisk where deviceid="C:"'
Get-CimInstance -Query 'select deviceid,drivetype,size from win32_logicaldisk where deviceid="C:"'

Invoke-WmiMethod -Class win32_process -Name create -ArgumentList 'notepad'
Invoke-CimMethod -ClassName win32_process -MethodName Create -Arguments @{commandline = 'notepad' }

Get-CimInstance -ComputerName dc -ClassName win32_process #require perms for current user

$cimCreds = Get-Credential -Message 'provide creds for DC cim auth'
$cimSession = New-CimSession -ComputerName dc -Credential $cimCreds
Get-CimInstance -CimSession $cimSession -ClassName win32_process
Invoke-CimMethod -CimSession $cimSession -ClassName win32_process -Arguments @{commandline = 'notepad' } -MethodName create
