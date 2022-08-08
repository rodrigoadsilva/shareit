$processes = Get-Counter '\Process(*)\% Processor Time'
$cpu_cores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
$tenpercent = ($cpu_cores*100)*0.10
foreach ($process in $processes.countersamples) {
    # $process.InstanceName
    if($process.cookedvalue -gt $tenpercent -and $process.InstanceName -notLike 'idle' -and $process.InstanceName -notLike '_total'){
       write-host "Nome do processo: $($process.InstanceName)"
       write-host "Uso de CPU: $($process.cookedvalue / $cpu_cores)"
    }
}