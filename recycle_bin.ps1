# List items in the Recycle Bin

# Help from:
# http://tfl09.blogspot.com/2007/01/manipulating-recycle-bin-in-powershell.html

# Tested on Windows 7; Powershell v2; C: drive
# Must run as Administrator for full control

# Execute this command in PowerShell beforehand
# if PowerShell will not let you run the script:
# Set-ExecutionPolicy Unrestricted



# Method 1

Set-Location C:\'$Recycle.Bin'
# Single quotation is necessary, otherwise it
# tries to find C:\.Bin

Get-ChildItem -Force -Recurse
# Some files cannot be viewed unless running
# as Administrator



# Method 2

$objShell = New-Object -Com Shell.Application
# Creates COM object

$objFolder = $objShell.Namespace(0xA)
# Namespace creates and returns folder object;
# must specify which folder to point to
# 0xA is used since C:\$Recycle.Bin doesn't work

$objFolder.Items()
# Does not list recursively
