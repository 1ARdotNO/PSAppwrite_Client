\
 apt-get update && \
 apt-get install wget -y && \
 apt-get install software-properties-common -y && \
 wget -q https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb && \
 dpkg -i packages-microsoft-prod.deb && \
 apt-get update && \
 apt-get install -y powershell
 
#install powershell modules
pwsh -command "install-module pselasticsearch -force"
pwsh -command "install-module core -force"
pwsh -command "Install-Module -Name PowerShellForGitHub -force"