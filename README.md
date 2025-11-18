🖥️ check_scheduled_task.ps1

Este arquivo é um script PowerShell desenvolvido para monitorar tarefas agendadas do Windows (Scheduled Tasks) e retornar resultados compatíveis com ferramentas de monitoramento como OpMon, Nagios, Zabbix, Centreon e similares.

Ele verifica se a tarefa existe, se foi executada recentemente e se o último resultado indica sucesso ou falha.

🚀 Funcionalidade

O script realiza:

Verificação da existência da tarefa agendada

Obtenção do estado atual (Ready, Running, etc.)

Coleta do último horário de execução

Leitura do código de retorno (LastTaskResult)

Conversão do código para mensagem amigável

Cálculo do tempo desde a última execução

Saída padronizada para monitoramento

Retornos:

Código	Status
0	OK
2	CRITICO
📌 Como usar

Execute no PowerShell:

.\check_scheduled_task.ps1 -TaskName "NomeDaTask" -MaxMinutes 30

Parâmetros
Parâmetro	Tipo	Descrição
TaskName	string	Nome da tarefa agendada
MaxMinutes	int	Tempo máximo aceitável desde a última execução
🧾 Exemplos de saída
✔ OK
OK - A tarefa 'BackupDiario' foi executada pela ultima vez ha 12 minutos. Estado: Ready | Ultimo Resultado: 0 (Sucesso)

❌ CRITICO
CRITICO - A tarefa 'BackupDiario' foi executada pela ultima vez ha 187 minutos. Estado: Ready | Ultimo Resultado: 2 (Falha: arquivo nao encontrado)

🧠 Códigos interpretados

O script traduz automaticamente os códigos mais comuns do Agendador de Tarefas:

Código	Significado
0	Sucesso
1	Erro desconhecido
2	Arquivo não encontrado
10	Ambiente incorreto
267	Diretório inválido
2147942402	Acesso negado
2147942667	Nome de diretório inválido
Qualquer outro	Código desconhecido
🛠 Requisitos

Windows 10/11 ou Windows Server

PowerShell 5.1 ou superior

Permissões para consultar tarefas agendadas
