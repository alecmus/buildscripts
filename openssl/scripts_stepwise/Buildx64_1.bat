:: call the x64 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

:: set the paths to Perl and NASM
set PATH=%PATH%;C:\Perl64\bin;C:\local\libs\nasm\bin;

:: switch to the OpenSSL directory
set VERSION=openssl-1.0.2s
cd %VERSION%

:: configure using Perl
perl Configure VC-WIN64A --prefix=c:\local\libs\openssl

:: build for x64
call ms\do_win64a