[DscLocalConfigurationManager()]
Configuration LCMPUSH
{
    Node $ComputerName
    {
        Settings
        {
            AllowModuleOverwrite = $true
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RefreshMode = 'Push'
        }
    }
}

$ComputerName = 'WS000DSC'

#Create MOF
LCMPUSH -OutputPath C:\temp\MOFs