


(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')))>$null


# set up non-admin user
$loginName="pgrunner"
$newPass="fr0bn1tz!X" #
$desc="plain user to run postgres"
$localHost=[ADSI]"WinNT://localhost"
$newUser=$localHost.Create("user",$loginName);
$newUser.setPassword($newPass);
$newUser.put("HomeDirectory","c:\users\$loginName");
$newUser.put("description",$desc);
$newUser.setInfo();


refreshenv

$editors = 'vim', 'notepadplusplus', 'emacs'
choco install -y --no-progress --limit-output @editors

$perl = 'StrawberryPerl'
choco install -y --no-progress --limit-output $perl



# setup for msys2

if ( $args -contains "NOMSYS2" )
{
	Write-Output "Skipping MSYS2 ..."
}
else
{
	choco install -y --no-progress --limit-output msys2
	c:\tools\msys64\usr\bin\bash -l '/c/vfiles/windows-uploads/msys2-packages.sh'
}

# setup for MSVC build

if ( $args -contains "NOMSVC" )
{
	Write-Output "Skipping Visual Studio ..."
}
else
{
	$utils = 'git', 'hg', 'patch', 'Wget', 'Less', 'sed', 'winflexbison', '7zip', 'gzip', 'zip', 'unzip', 'diffutils'

	# setup for MSVC utils
	choco install -y --no-progress --limit-output @utils
	$cbin = "c:\ProgramData\chocolatey\bin"
	Rename-Item -Path $cbin\win_bison.exe -NewName bison.exe
	Rename-Item -Path $cbin\win_flex.exe -NewName flex.exe

	refreshenv

	choco install -y --no-progress --limit-output visualstudio2019-workload-vctools --install-args="--add Microsoft.VisualStudio.Component.VC.CLI.Support"
	# choco install -y --no-progress --limit-output visualstudio2019-workload-nativedesktop --package-parameters "--includeOptional"
	# choco install -y --no-progress --limit-output visualstudio2019-workload-nativegame --package-parameters "--includeOptional"
}
