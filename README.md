# Local-Development-Environment
This project contains bash scripts and instructions for setting up a local development environment on windows with WSL + Docker + Docker-Sync + ezlaunchpad. 

# Windows 10

Enable Hyper-V

* Open PowerShell as Administrator and run: `Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All`

---
# Docker

* Install [Docker for Windows](https://www.docker.com/docker-windows)
* Update Docker Settings: `Expose daemon on tcp://localhost:2375 without TLS`
* Create a new Windows Firewall rule for port 2375
  * Open PowerShell as Administrator and run: `New-NetFirewallRule -DisplayName "Docker for Windows TCP" -Action Block -Direction Inbound -EdgeTraversalPolicy Block -Enabled True -LocalPort 2375 -Protocol TCP`

---	
# WSL

* Enable WSL in Windows Optional Feature
  * Open PowerShell as Administrator and run: `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`

* Windows (1709)
  * Open the Windows Store by visiting: http://aka.ms/wslstore
    * Install ubuntu
    * Run ubuntu: Search `ubuntu` and open
    * Follow the instructions for creating a new linux user account
    * Set the default user to root (Optional)
      * Open a Windows cmd prompt and run: `ubuntu config --default-user root`
  * Add `Ubuntu` shortcut to Start Menu (Pin to Start)

* Windows (1703)
  * Run cmd
     * lxrun /install /y
     * lxrun /uninstall /full /y (NOTE: start fresh)
  * Add `Bash on Ubuntu on Windows` shortcut to Start Menu
	
---
# Scripts

The following bash scripts will automate the installation process of Docker and ezlaunchpad. 

Launch WSL bash and run the following commands:

* Install Docker and Docker Compose
  * bash -c "$(curl -s [https://gitlab.com/snippets/1683061/raw](https://gitlab.com/snippets/1683061/raw))" && source ~/.bashrc
* Install Docker-Sync + Unison
  * curl https://gitlab.com/snippets/1686704/raw | bash
* Install ezlaunchpad with dependencies
  * curl https://gitlab.com/snippets/1683062/raw | bash
* Add custom docker aliases
  * curl -s https://gitlab.com/snippets/1683063/raw > ~/.bash_aliases && source ~/.bashrc





