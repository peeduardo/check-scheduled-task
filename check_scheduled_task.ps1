param(
    [string]$TaskName,
    [int]$MaxMinutes
)

$TaskName = $TaskName -replace '"',''

function Exit-OpMon {
    param (
        [string]$Message,
        [int]$Code
    )
    Write-Output $Message
    exit $Code
}

function Get-TaskResultMessage {
    param([int]$Code)

    switch ($Code) {
        0   { "Sucesso" }
        1   { "Falha: chamada de funcao incorreta ou erro desconhecido" }
        2   { "Falha: arquivo nao encontrado" }
        10  { "Falha: ambiente incorreto" }
        267 { "Falha: diretorio invalido" }
        2147942402 { "Falha: acesso negado" }
        2147942667 { "Falha: nome do diretorio invalido" }
        default { "Codigo de resultado desconhecido: $Code" }
    }
}

try {
    $task = Get-ScheduledTask -TaskName $TaskName -ErrorAction Stop
} catch {
    Exit-OpMon "CRITICO - Nao foi possível encontrar a tarefa agendada '$TaskName'." 2
}

try {
    $history = Get-ScheduledTaskInfo -TaskName $TaskName
} catch {
    Exit-OpMon "CRITICO - Nao foi possivel obter informações sobre a tarefa agendada '$TaskName'." 2
}

if (-not $history.LastRunTime -or $history.LastRunTime -eq [datetime]::MinValue) {
    Exit-OpMon "CRITICO - A tarefa '$TaskName' nunca foi executada." 2
}

$minutesSinceLastRun = (New-TimeSpan -Start $history.LastRunTime -End (Get-Date)).TotalMinutes

# Estados adicionais
$taskState       = $task.State
$lastTaskResult  = $history.LastTaskResult
$lastTaskMessage = Get-TaskResultMessage $lastTaskResult
$lastRunTime     = $history.LastRunTime

if ($minutesSinceLastRun -le $MaxMinutes) {
    Exit-OpMon ("OK - A tarefa '{0}' foi executada pela ultima vez ha {1} minutos. Estado: {2} | Ultimo Resultado: {3} ({4}) | Ultima Execução: {5}" -f `
        $TaskName, [math]::Round($minutesSinceLastRun, 2), $taskState, $lastTaskResult, $lastTaskMessage, $lastRunTime) 0
} else {
    Exit-OpMon ("CRITICO - A tarefa '{0}' foi executada pela ultima vez ha {1} minutos. Estado: {2} | Ultimo Resultado: {3} ({4}) | Ultima Execucao: {5}" -f `
        $TaskName, [math]::Round($minutesSinceLastRun, 2), $taskState, $lastTaskResult, $lastTaskMessage, $lastRunTime) 2
}
    