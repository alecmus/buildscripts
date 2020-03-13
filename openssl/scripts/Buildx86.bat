:: call the x86 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat"

:: set the paths to Perl, NASM and fnr
set PATH=%PATH%;C:\Perl64\bin;C:\local\libs\nasm\bin;C:\local\libs\fnr\bin;

:: create copy of the directory
xcopy "openssl-1.0.x" "openssl-1.0.x_x86" /R /Y /I /E

set VERSION86=openssl-1.0.x_x86

:: switch to the x86 OpenSSL directory ----------------------------------------
cd %VERSION86%

:: replace all occurrences of 'openssl.exe' with 'openssl32.exe'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "openssl.exe" --replace "openssl32.exe"

:: configure using Perl
perl Configure VC-WIN32 --prefix=c:\local\libs\openssl

:: do NASM stuff (required for x86 build)
call ms\do_nasm

:: replace all occurrences of 'E_EXE=openssl' with 'E_EXE=openssl32'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "E_EXE=openssl" --replace "E_EXE=openssl32"

:: build the library
nmake -f ms\ntdll.mak

:: copy the relevant files to the location specified in --prefix
nmake -f ms\ntdll.mak install

:: delete the engines folder (to-do: yet to find a way to compile these into libeay32.dll)
rd C:\local\libs\openssl\lib\engines /s /q

:: done building ... delete the folder ...
cd ..\
rd %VERSION86% /s /q