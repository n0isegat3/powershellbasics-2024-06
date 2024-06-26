$operation = 'terminate','show'


$selectedoperation = $operation | Out-GridView -PassThru -Title 'SELECT WHAT TO DO'



switch ($selectedoperation) {
    'terminate' {Get-Process | Out-GridView -PassThru -Title 'SELECT PROCESS TO KILL' | Stop-Process -WhatIf}
    'show' {Get-Process | Out-GridView -PassThru -Title 'SELECT PROCESS TO SHOW' | Select-Object -Property name,id,si}
}