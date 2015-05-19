# Help from:
# http://technet.microsoft.com/en-us/library/jj590751.aspx
# http://technet.microsoft.com/en-us/library/ee617195.aspx
# http://technet.microsoft.com/en-us/library/jj649850.aspx
# http://blogs.technet.com/b/askds/archive/2012/09/20/windows-server-2012-shell-game.aspx

# Tested on Windows Server 2012 Datacenter (Server Core Installation)
# Used to install Active Directory from Powershell only
# Not to be used without proper editing

# Used to rename the server (and restart right after)
Rename-Computer  –NewName  "<<name>>"  –Restart

# List available interfaces
# (Find the one with InterfaceAlias: Ethernet)
Get–NetIPAddress

# Change server IP address
New–NetIPAddress  –InterfaceIndex  <<interface number>>  –IPAddress  <<IP>>  –PrefixLength <<CIDR>>  –DefaultGateway  <<gateway>>

# Install AD, DHCP, DNS
Install–WindowsFeature  AD–Domain–Services,DHCP,DNS  –IncludeManagementTools

# Create DHCP range
Add–DHCPServerV4Scope  –Name  "<<scope name>>"  –StartRange  <<starting IP>>  –EndRange  <<ending IP>>  –SubnetMask  <<subnet>>

# Create AD Forest Domain
Install–ADDSForest  –DomainName  "<<domain name>>"

# Create DNS primary zone
Add–DNSServerPrimaryZone  –NetworkID  "<<IP with CIDR>>"  –ReplicationScope  "Forest"


# Install GUI

# See available GUI options
Get–WindowsFeature  Server–Gui*

# Get file from Installation disc (required to install GUI)
dism  /get–wiminfo  /wimfile:d:\sources\install.wim

# Install Index
# The WIM file lists four index images, which are the four 
# different types of Windows Server 2012 available. 
# Index 4 is the Data Center with GUI version.
Install–WindowsFeature  Server–Gui–Mgmt–Infra,Server–Gui–Shell  –source:wim:d:\sources\install.wim:4


# Restart after
Restart–Computer
