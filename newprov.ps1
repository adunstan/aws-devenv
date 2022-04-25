
# provision without choco

# find latest msys2 installer at:
# https://github.com/msys2/msys2-installer/releases/latest

$global:progressPreference = 'silentlyContinue'

echo "getting msys2 installer"
wget https://github.com/msys2/msys2-installer/releases/download/2022-01-28/msys2-x86_64-20220128.exe -outfile msys2-installer.exe -UseBasicParsing

# msys2 outputs esc-[3J which clears the screen's scroll buffer. Nasty.
# so we redirect the output
echo "running msys2 installer"
msys2-installer --root c:/tools/msys64 --accept-licenses --confirm-command install >msys2inst.log

function Setup-Pgrunner {

# install Carbon utilities package

echo "installing Carbon"
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
# temporarily trust PSGallery
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module -Name 'Carbon' -AllowClobber
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Untrusted

# set up a non-privileged user and create their profile directories

echo "setting up pgrunnernuser"

Import-Module -Name c:\vfiles\windows-uploads\user-profile.psm1
Create-NewProfile -Username 'pgrunner' -Password 'fr0bn1tz!X'

# grant them a couple of useful permissions

Import-Module Carbon
Grant-CPrivilege -Identity pgrunner -Privilege SeCreateSymbolicLinkPrivilege
Grant-CPrivilege -Identity pgrunner -Privilege SeBatchLogonRight


}

# uncomment if pgrunner is needed
# Setup-Pgrunner

# install Strawberry Perl
echo "getting strawberry perl installer"
wget https://strawberryperl.com/download/5.32.1.1/strawberry-perl-5.32.1.1-64bit.msi -outfile strawberry.msi -UseBasicParsing
echo "installing strawberry perl"
msiexec /i strawberry.msi /quiet /passive /log strawberry.log

# install required packages for building on msys
echo "installing required msys2 packages"
c:\tools\msys64\usr\bin\bash -l '/c/vfiles/windows-uploads/nmsys.sh'
