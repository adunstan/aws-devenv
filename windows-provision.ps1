


(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')))>$null

refreshenv

$editors = 'vim', 'notepadplusplus'
choco install -y --no-progress --limit-output @editors

$perl = 'ActivePerl'
choco install -y --no-progress --limit-output $perl

# setup for msys2
choco install -y --no-progress --limit-output msys2
c:\tools\msys64\usr\bin\bash -l '/c/vfiles/uploads/msys2-packages.sh'

# setup for MSVC build
$utils = 'git', 'hg', 'patch', 'Wget', 'Less', 'sed', 'winflexbison', '7zip', 'gzip', 'zip', 'unzip', 'diffutils'

# setup for MSVC utils
choco install -y --no-progress --limit-output @utils
$cbin = "c:\ProgramData\chocolatey\bin"
Rename-Item -Path $cbin\win_bison.exe -NewName bison.exe
Rename-Item -Path $cbin\win_flex.exe -NewName flex.exe

refreshenv

choco install -y --no-progress --limit-output visualstudio2019-workload-vctools --package-parameters "--includeOptional"
# choco install -y --no-progress --limit-output visualstudio2019-workload-nativedesktop --package-parameters "--includeOptional"
# choco install -y --no-progress --limit-output visualstudio2019-workload-nativegame --package-parameters "--includeOptional"

