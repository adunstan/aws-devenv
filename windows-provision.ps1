


(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')))>$null

# see https://stackoverflow.com/questions/46758437/how-to-refresh-the-environment-of-a-powershell-session-after-a-chocolatey-instal
# Make `refreshenv` available right away, by defining the $env:ChocolateyInstall
# variable and importing the Chocolatey profile module.
# Note: Using `. $PROFILE` instead *may* work, but isn't guaranteed to.
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# refreshenv is now an alias for Update-SessionEnvironment
# (rather than invoking refreshenv.cmd, the *batch file* for use with cmd.exe)

# set up non-admin user

Import-Module -Name c:\vfiles\windows-uploads\user-profile.psm1
Create-NewProfile -Username 'pgrunner' -Password 'fr0bn1tz!X'

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
	# msys2 outputs esc-[3J which clears the screen's scroll buffer. Nasty.
	# so we redirect the output
	# find the log in c:\Windows\System32 if needed
	choco install -y --no-progress --limit-output msys2 > msys2inst.log
	c:\tools\msys64\usr\bin\bash -l '/c/vfiles/windows-uploads/msys2-packages.sh'
}

# choco install -y postgresql12 --params '/Password:FooBar1234'
# see https://community.chocolatey.org/packages/postgresql12
# choco install -ia "--datadir d:\pgdata\12" postgresql12
# see https://www.enterprisedb.com/edb-docs/d/postgresql/installation-getting-started/installation-guide-installers/10/PostgreSQL_Installation_Guide.1.16.html

# setup for MSVC build

if ( $args -contains "NOMSVC" )
{
	Write-Output "Skipping Visual Studio ..."
}
else
{
	# the choco 'patch' package sucks, demands an admin password for everything
	# use patch from msys2 if necessary. Buildfarm doesn't require patch.
	$utils = 'git', 'hg', 'Wget', 'Less', 'sed', 'winflexbison', '7zip', 'gzip', 'zip', 'unzip', 'diffutils'

	# setup for MSVC utils
	choco install -y --no-progress --limit-output @utils
	$cbin = "c:\ProgramData\chocolatey\bin"
	Rename-Item -Path $cbin\win_bison.exe -NewName bison.exe
	Rename-Item -Path $cbin\win_flex.exe -NewName flex.exe

	refreshenv

	# use the includeOptional form if you need to support old commits
	# installs the 8.1 SDK which can be needed
	choco install -y --no-progress --limit-output visualstudio2019-workload-vctools --install-args="--add Microsoft.VisualStudio.Component.VC.CLI.Support"
	# choco install -y --no-progress --limit-output visualstudio2019-workload-nativedesktop --package-parameters "--includeOptional"
	# choco install -y --no-progress --limit-output visualstudio2019-workload-nativegame --package-parameters "--includeOptional"

	mkdir \prog
	cd \prog
	git clone https://github.com/PGBuildFarm/client-code.git bf

	Remove-Item alias:wget
	Remove-Item alias:curl
	wget -q -O ademacs.tgz http://bitbucket.org/adunstan/myemacs/get/master.tar.gz
	tar -z -C $env:APPDATA --strip-components=1 -xf ademacs.tgz
	tar -z -C \Users\pgrunner\AppData\Roaming --strip-components=1 -xf ademacs.tgz
}

Write-Output "Remember to change the pgrunner password."
