<#
    .SYNOPSIS
        Execute SSACLI using SSH
    .DESCRIPTION
    .Author 
    Rayon Bookal
#>

if (!(Get-Module -ListAvailable -Name Posh-SSH))
{
    Install-Module Posh-SSH
    Import-Module Posh-SSH
}


$MyCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User #need to create your object with pwd if needed
#https://blogs.msdn.microsoft.com/koteshb/2010/02/12/powershell-how-to-create-a-pscredential-object/

$SSACMD = "esxcli ssacli cmd -q 'Controller slot=0 array b encode preservedata=yes user=crypto password=xxxx'"


    $sshsession = New-SSHSession -ComputerName $ComputerName -Credential $MyCredential

    if ($sshsession.Connected)
    {
            $sshsessionresult = Invoke-SSHCommand -SessionId $sshsession.SessionId -Command $SSACMD
        	Remove-SSHSession -SessionId $sshsession.SessionId 
}
