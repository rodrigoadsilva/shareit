$processes = Get-Counter '\Process(*)\% Processor Time' # Get all currently runnig processes and their respective properties 

$cpu_cores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors # Get the number of logical processors

$tenpercent = ($cpu_cores*100)*0.10 # Stores the 10% proportional value based on the number of processors

foreach ($process in $processes.countersamples) { # Execution loop for each running process
    
    #If current process usage is greater than proportional for all processors, ignoring default processes "idle" and "_total"
    if($process.cookedvalue -gt $tenpercent -and $process.InstanceName -notLike 'idle' -and $process.InstanceName -notLike '_total'){
       
       write-host "Nome do processo: $($process.InstanceName)" # Show on console the process name

       write-host "Uso de CPU: $($process.cookedvalue / $cpu_cores)" # Show on console the process value

    }
}