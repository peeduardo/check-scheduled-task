Script utilizado para monitorar uma tarefa agendada no Windows, verificando:

Existência da task

Última execução

Estado atual

Código de retorno (LastTaskResult)

Tempo desde a última execução

Retorna mensagens no padrão OpMon/Nagios:

Código	Significado
0	OK
2	CRITICO

Exemplo de uso:

.\Check-ScheduledTask.ps1 -TaskName "BackupDiario" -MaxMinutes 60


Exemplo de saída:

OK - A tarefa 'BackupDiario' foi executada pela ultima vez ha 12 minutos. Estado: Ready | Ultimo Resultado: 0 (Sucesso)

📦 Instalação & Uso
1. Clone o repositório
git clone https://github.com/SeuUsuario/windows-monitoring-scripts.git

2. Acesse a pasta de scripts
cd windows-monitoring-scripts/scripts

3. Execute qualquer script
.\NomeDoScript.ps1 -Parametros

🛠 Compatibilidade

Windows 10/11

Windows Server 2012 R2 ou superior

PowerShell 5.1 ou PowerShell 7

Permissão para executar scripts (Set-ExecutionPolicy)

🤝 Contribuições

Contribuições são bem-vindas!
Você pode:

Abrir issues

Sugerir novos scripts

Enviar pull requests

Propor melhorias no código ou documentação
