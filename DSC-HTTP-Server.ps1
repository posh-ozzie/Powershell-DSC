#HTTP Pull Server
#OK for test environment, dont use in Production
Configuration HTTPPullServer
{
    #Module Must Exist on Pull Server
    Import-DscResource -ModuleName xPSDesiredStateConfiguration

    Node WS000DSC
    {
        WindowsFeature DSCServiceFeature
        {
            Ensure = "Present"
            Name = "DSC-Service"
        }

        #WindowsFeature IISConsole #For GUI Servers - Core Server Comment Out
        #{
        #    Ensure = "Present"
        #    Name = "Web-Mgmt-Console"
        #}

        xDSCWebService PSDSCPullServer
        {
            Ensure = "Present"
            EndpointName = "PSDSCPullServer"
            Port = 8080
            PhysicalPath = "$env:SystemDrive\inetpub\wwwroot\PSDSCPullServer" #Location of Website Files
            CertificateThumbPrint = "AllowUnencryptedTraffic"
            ModulePath = "$env:ProgramFiles\WindowsPowershell\DscService\Modules"
            ConfigurationPath = "$env:ProgramFiles\WindowsPowershell\DscService\Configuration" #Configuration File Storage
            State = "Started"
            UseSecurityBestPractices = $false
            DependsOn = "[WindowsFeature]DSCServiceFeature"
        }
        xDSCWebService PSDSCReportingServer #PSDSCComnplianceServer on the MVA Course.
        {
            Ensure = "Present"
            EndpointName = "PSDSCReportingServer"
            Port = 9080
            PhysicalPath = "$env:SystemDrive\inetpub\wwwroot\PSDSCReportingServer" #Location of Website Files
            CertificateThumbPrint = "AllowUnencryptedTraffic"
            State = "Started"
            UseSecurityBestPractices = $false
            DependsOn = ("[WindowsFeature]DSCServiceFeature","[xDSCWebService]PSDSCPullServer")
        }
    }
}

#Generate MOF
HTTPPullServer -OutputPath C:\temp\MOFs