This is a repo to automatically:
* Add a task to the Windows Task Scheduler to automatically shut down wsl.exe when you enter "exit" in the Debian terminal (or close your terminal by pressing on "X" on top-right corner). Windows sometimes doesn't shut down wsl fully and therefore this is needed to not cause any problems if you relaunch the WSL after closing it
* Make WSL debian your default Windows terminal profile (so that WSL Debian opens by default when you open your windows terminal)
* Add a few default appearance changes to the Debian terminal (font, font size, etc)

Pre-requisites:
* My Windows Terminal profile was exported from my windows machine, and I already had Jetbrains Mono Nerd Font and Jetbrains Mono Nerd Font Propo installed. So to be safe, please install the entire Jetbrains font library in your machine to avoid any errors

Steps:
* Clone the repo to your local
* Go into the git repo and run the file `wsl-terminal-config-and-shutdown-task-setup-script.ps1` in Windows Powershell
