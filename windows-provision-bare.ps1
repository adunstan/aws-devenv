
# set up non-admin user
$loginName="pgrunner"
$newPass="fr0bn1tz!X" # should be changed
$desc="plain user to run postgres"
$localHost=[ADSI]"WinNT://localhost"
$newUser=$localHost.Create("user",$loginName);
$newUser.setPassword($newPass);
$newUser.put("HomeDirectory","c:\users\$loginName");
$newUser.put("description",$desc);
$newUser.setInfo();

# $password = ConvertTo-SecureString $newPass -AsPlainText -Force
# $credential = New-Object System.Management.Automation.PSCredential ('\pgrunner', $password)
# $credential.UserName

# Get-PSSessionConfiguration -Name Microsoft*  | Format-List -Property *
# Set-PsSessionConfiguration -Name Microsoft.PowerShell -ShowSecurityDescriptorUI

#$GetProcessJob = Start-Job -Credential $credential -ScriptBlock { gci env:* | sort-object name }
#Wait-Job $GetProcessJob
#$GetProcessResult = Receive-Job -Job $GetProcessJob
#$GetProcessResult
