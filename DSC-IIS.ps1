Configuration WebServerConfig 
{
    Node $ComputerName 
    {
            WindowsFeature IIS{
            Name = 'web-server'
            Ensure = 'Present'
        }
    }
}

$ComputerName = 'WS000IIS'

WebServerConfig $ComputerName -OutputPath C:\temp\MOFs
