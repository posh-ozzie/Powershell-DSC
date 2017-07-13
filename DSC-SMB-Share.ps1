#Create the folder
New-item -Path C:\DSCSMB -ItemType Directory
#Set the Permissions
New-SmbShare -Name DSCSMB -Path C:\DSCSMB -ReadAccess EVERYONE -FullAccess Administrator -Description "SMB share for DSC"