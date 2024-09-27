# Path where the initial git repo will be downloaded to
# This is just a temporary git repo and can be deleted once
# its used
$gitRepoPath = "$env:USERPROFILE\Downloads\wsl-terminal-settings"

# Online git repo's public URL
$gitRepoURL = "https://github.com/mg104/wsl-terminal-settings.git"

# Location of the windows terminal settings json in git repo
$sourceTerminalSettingsJSONPath = "$gitRepoPath\wsl-terminal-settings.json"

# Location of the windows terminal settings json in current windows
# PC. This JSON determines the settings of your current windows terminal
$targetTerminalSettingsJSONPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# Location of the xml file in the git repo
$sourceTaskConfigXMLPath = "$gitRepoPath\wsl-shutdown-windows-task-config.xml"

# Location of the updated XML file 
$targetTaskConfigXMLPath = "$gitRepoPath\updated-wsl-shutdown-windows-task-config.xml"

# Privilege Level of running the wsl shutdown task
$WSLShutdownTaskPrivilegeLevel = "LeastPrivilege"

# Location of the shutdown script file
$WSLShutdownScriptPath = "$gitRepoPath\wsl-shutdown.ps1"

# Cloning the git repo to local
& git clone $gitRepoURL $gitRepoPath
Write-Host "Pulled the latest changes from the git repository"

# Command to replace the windows terminal profile from
# downloaded git repo to the windows terminal settings json
# path
Copy-Item -Path $sourceTerminalSettingsJSONPath -Destination $targetTerminalSettingsJSONPath -Force
Write-Host "Installed the latest Windows Terminal settings"

# Modifying the windows task config XML file before installing it
$xmlContent = Get-Content $sourceTaskConfigXMLPath -Raw
$xmlContent = $xmlContent -replace 'insertAuthorName', $env:USERNAME
$xmlContent = $xmlContent -replace 'insertWSLShutdownScriptPath', $WSLShutdownScriptPath
$xmlContent = $xmlContent -replace 'insertPrivilegeLevel', $WSLShutdownTaskPrivilegeLevel
$xmlContent | Out-File $targetTaskConfigXMLPath -Encoding Unicode

# Command to install the automated task to shutdown wsl.exe
# upon running "exit" in the wsl terminal, so that all pending
# processes are shutdown and later on wsl.exe can be relaunched
# without difficulty
schtasks /create /tn "WSL-Shutdown-Task" /xml $targetTaskConfigXMLPath /f
Write-Host "Setup complete"
