function Invoke-ProcessRestarter {
    param(
        [Parameter(Mandatory)][string]$nameOfProcess
    )


    #$nameOfProcess = Read-Host 'enter the name of process to restart'

    Write-Verbose 'Script started'
    if ((Get-Process $nameOfProcess -ErrorAction SilentlyContinue | Measure-Object).count -gt 0) {
        Get-Process -Name $nameOfProcess  | Stop-Process
    }
    else {
        Write-Host "No process with name $nameOfProcess is running."
    }

    # Invoke-CimMethod -ClassName win32_process -MethodName create -Arguments @{commandline=$nameOfProcess} -ErrorAction Stop

    Write-Verbose 'Before starting the process'
    try {
        Start-Process $nameOfProcess -ErrorAction Stop
    }
    catch {
        Write-Host "Something wrong when starting process $nameOfProcess"
    }

    Write-Host 'All done, finished!'
}

function Invoke-HelloWorld {
    write-host 'hi jan'
}
