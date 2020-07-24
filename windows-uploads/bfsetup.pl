

use strict;

### VS 2017 - the default
my $studio_year = '2017';
my $sdk_version = '10.0.17134.0';
my $msvc_version = '14.15.26726';
my $studio_version = '15.0';
my $build_bin = '15.0';

### VS 2019;

my $vcyear = $ARGV[0];


if ( $vcyear eq '2019' )
{
	$studio_year = '2019';
	$sdk_version = '10.0.18362.0';
	$msvc_version = '14.26.28801';
	$studio_version = '16.0';
	$build_bin = 'Current';
}

print "Studio year = $studio_year\nsdk: $sdk_version\nmsc: $msvc_version\n";


my $vcenv64 = <<'ENV64';
      PERL5LIB => 'c:/prog/bf/p5lib',
      INCLUDE  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\ATLMFC\include;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\include;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\include\um;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\ucrt;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\shared;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\um;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\winrt;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\cppwinrt',
      LIB  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\ATLMFC\lib\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\lib\x64;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\lib\um\x64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.17134.0\ucrt\x64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.17134.0\um\x64;',
      LIBPATH  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\ATLMFC\lib\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\lib\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\lib\x86\store\references;C:\Program Files (x86)\Windows Kits\10\UnionMetadata\10.0.17134.0;C:\Program Files (x86)\Windows Kits\10\References\10.0.17134.0;',
      Path  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\bin\HostX64\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\CommonExtensions\Microsoft\TestWindow;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\bin\Roslyn;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\x64\;C:\Program Files (x86)\Windows Kits\10\bin\10.0.17134.0\x64;C:\Program Files (x86)\Windows Kits\10\bin\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\\MSBuild\15.0\bin;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\;C:\Perl64\site\bin;C:\Perl64\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Amazon\cfn-bootstrap\;C:\ProgramData\chocolatey\bin;C:\Program Files (x86)\vim\vim80;C:\Program Files\Git\cmd;C:\tools\sed\bin;C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja;C:\prog\3p64\bin',
      Platform  =>  'x64',
      UCRTVersion  =>  '10.0.17134.0',
      UniversalCRTSdkDir  =>  'C:\Program Files (x86)\Windows Kits\10',
      VCIDEInstallDir  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\VC',
      VCINSTALLDIR  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC',
      VCToolsInstallDir  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726',
      VCToolsRedistDir  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Redist\MSVC\14.15.26706',
      VCToolsVersion  =>  '14.15.26726',
      VisualStudioVersion  =>  '15.0',
      VSCMD_ARG_app_plat  =>  'Desktop',
      VSCMD_ARG_HOST_ARCH  =>  'x64',
      VSCMD_ARG_TGT_ARCH  =>  'x64',
      VSCMD_VER  =>  '15.0',
      VSINSTALLDIR  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools',
      WindowsLibPath  =>  'C:\Program Files (x86)\Windows Kits\10\UnionMetadata\10.0.17134.0;C:\Program Files (x86)\Windows Kits\10\References\10.0.17134.0',
      WindowsSdkBinPath  =>  'C:\Program Files (x86)\Windows Kits\10\bin',
      WindowsSdkDir  =>  'C:\Program Files (x86)\Windows Kits\10',
      WindowsSDKLibVersion  =>  '10.0.17134.0',
      WindowsSdkVerBinPath  =>  'C:\Program Files (x86)\Windows Kits\10\bin\10.0.17134.0',
      WindowsSDKVersion  =>  '10.0.17134.0',
      WindowsSDK_ExecutablePath_x64  =>  'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\x64',
      WindowsSDK_ExecutablePath_x86  =>  'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools',
ENV64

my $vcenv32 = <<'ENV32';
      PERL5LIB => 'c:/prog/bf/p5lib',
      INCLUDE  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\ATLMFC\include;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\include;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\include\um;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\ucrt;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\shared;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\um;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\winrt;C:\Program Files (x86)\Windows Kits\10\include\10.0.17134.0\cppwinrt',
      LIB  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\ATLMFC\lib\x86;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\lib\x86;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\lib\um\x86;C:\Program Files (x86)\Windows Kits\10\lib\10.0.17134.0\ucrt\x86;C:\Program Files (x86)\Windows Kits\10\lib\10.0.17134.0\um\x86;',
      LIBPATH  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\ATLMFC\lib\x86;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\lib\x86;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\lib\x86\store\references;C:\Program Files (x86)\Windows Kits\10\UnionMetadata\10.0.17134.0;C:\Program Files (x86)\Windows Kits\10\References\10.0.17134.0;',
      Path  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726\bin\HostX64\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\CommonExtensions\Microsoft\TestWindow;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\bin\Roslyn;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\x64\;C:\Program Files (x86)\Windows Kits\10\bin\10.0.17134.0\x64;C:\Program Files (x86)\Windows Kits\10\bin\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\\MSBuild\15.0\bin;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\;C:\Perl64\site\bin;C:\Perl64\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Amazon\cfn-bootstrap\;C:\ProgramData\chocolatey\bin;C:\Program Files (x86)\vim\vim80;C:\Program Files\Git\cmd;C:\tools\sed\bin;C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja;C:\prog\3p64\bin',
      Platform  =>  'x86',
      UCRTVersion  =>  '10.0.17134.0',
      UniversalCRTSdkDir  =>  'C:\Program Files (x86)\Windows Kits\10',
      VCIDEInstallDir  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\VC',
      VCINSTALLDIR  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC',
      VCToolsInstallDir  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.15.26726',
      VCToolsRedistDir  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Redist\MSVC\14.15.26706',
      VCToolsVersion  =>  '14.15.26726',
      VisualStudioVersion  =>  '15.0',
      VSCMD_ARG_app_plat  =>  'Desktop',
      VSCMD_ARG_HOST_ARCH  =>  'x86',
      VSCMD_ARG_TGT_ARCH  =>  'x86',
      VSCMD_VER  =>  '15.0',
      VSINSTALLDIR  =>  'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools',
      WindowsLibPath  =>  'C:\Program Files (x86)\Windows Kits\10\UnionMetadata\10.0.17134.0;C:\Program Files (x86)\Windows Kits\10\References\10.0.17134.0',
      WindowsSdkBinPath  =>  'C:\Program Files (x86)\Windows Kits\10\bin',
      WindowsSdkDir  =>  'C:\Program Files (x86)\Windows Kits\10',
      WindowsSDKLibVersion  =>  '10.0.17134.0',
      WindowsSdkVerBinPath  =>  'C:\Program Files (x86)\Windows Kits\10\bin\10.0.17134.0',
      WindowsSDKVersion  =>  '10.0.17134.0',
      WindowsSDK_ExecutablePath_x64  =>  'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\x64',
      WindowsSDK_ExecutablePath_x86  =>  'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools',
ENV32

do {

	s!\\2017\\!\\$studio_year\\!g;
	s!(?<=\D)10\.0\.17134\.0(?=\D)!$sdk_version!g;
	s!(?<=\D)14\.15\.26726(?=\D)!$msvc_version!g;
	s!(?<=\\)15\.0(?=\\bin)!$build_bin!g;
	s!(?<=\D)15\.0(?=\D)!$studio_version!g;

} foreach ($vcenv64, $vcenv32);


local $/ = undef;

open (my $handle, "<" , "build-farm.conf.sample") || die "$!";

my $conf64 = <$handle>;

close $handle;

my $conf32 = $conf64;

# perl reminder: re flags:
# m makes ^ and $ match start/end of lines instead of start/end of string
# s makes . match embedded newlines

do
{
	s/CHANGEME/testvc64/g;
	s!build_root =>.*!build_root => '/prog/bf/root',!,
	s/using_msvc.*/using_msvc => 1,/;
	# looks like line noise - fill in all the env settings in place
	s/(?<=\%extra_buildenv.=.[(].).*?(?=[)];)/$vcenv64/s;
	s/tcl.*=>.*/tcl => undef,/;
	s/python.*=>.*/python => undef,/;
	s/perl.*=>.*/perl => 'c:\\perl64',/;
	s/zlib.*=>.*/zlib => 'c:\\prog\\3p64',/;
    # use git's gnu tar
	s/tar_log_command.=>.*/tar_log_command => '"c:\Program Files\Git\usr\bin\tar" -z -cf runlogs.tgz *.log',/;
	
} foreach ($conf64);

$conf64 .= "\n\n=comment\n\n$vcenv64\n\n=cut\n";

do
{
	s/CHANGEME/testvc32/g;
	s!build_root =>.*!build_root => '/prog/bf/root',!,
	s/using_msvc.*/using_msvc => 1,/;
	# looks like line noise - fill in all the env settings in place
	s/(?<=\%extra_buildenv.=.[(].).*?(?=[)];)/$vcenv32/s;
	s/tcl.*=>.*/tcl => undef,/;
	s/python.*=>.*/python => undef,/;
	s/perl.*=>.*/perl => undef,/; 
	s/zlib.*=>.*/zlib => undef,/;
    # use git's gnu tar
	s/tar_log_command.=>.*/tar_log_command => '"c:\Program Files\Git\usr\bin\tar" -z -cf runlogs.tgz *.log',/;
	
} foreach ($conf32);




mkdir "root";

open($handle, ">" ,"testvc64.conf");
print $handle $conf64;
close $handle;

open($handle, ">" ,"testvc32.conf");
print $handle $conf32;
close $handle;


