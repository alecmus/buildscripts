:: call the x64 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

:: set the paths to Perl and fnr
set PATH=%PATH%;C:\Perl64\bin;C:\local\libs\fnr\bin;

:: create copy of the directory
xcopy "openssl-1.0.x" "openssl-1.0.x_x64" /R /Y /I /E

set VERSION64=openssl-1.0.x_x64

:: switch to the x64 OpenSSL directory ----------------------------------------
cd %VERSION64%

:: replace all occurrences of 'eay32' with 'eay64'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "eay32" --replace "eay64"

:: replace all occurrences of '32dll' with '64dll'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "32dll" --replace "64dll"

:: replace all occurrences of 'openssl.exe' with 'openssl64.exe'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "openssl.exe" --replace "openssl64.exe"

:: configure using Perl
perl Configure VC-WIN64A --prefix=c:\local\libs\openssl

:: build for x64
call ms\do_win64a

:: replace all occurrences of 'EAY32' with 'EAY64'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "EAY32" --replace "EAY64"

:: replace all occurrences of '32dll' with '64dll'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "32dll" --replace "64dll"

:: replace all occurrences of 'E_EXE=openssl' with 'E_EXE=openssl64'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "E_EXE=openssl" --replace "E_EXE=openssl64"

:: build the library
nmake -f ms\ntdll.mak

:: copy the relevant files to the location specified in --prefix
nmake -f ms\ntdll.mak install

:: delete the engines folder (to-do: yet to find a way to compile these into libeay64.dll)
rd C:\local\libs\openssl\lib\engines /s /q

:: done building ... delete the folder ...
cd ..\
rd %VERSION64% /s /q