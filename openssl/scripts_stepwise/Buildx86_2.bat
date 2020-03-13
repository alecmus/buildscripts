:: call the x86 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat"

:: set the paths to Perl and NASM
set PATH=%PATH%;C:\Perl64\bin;C:\local\libs\nasm\bin;

:: switch to the OpenSSL directory
set VERSION=openssl-1.0.2s
cd %VERSION%

:: build the library
nmake -f ms\ntdll.mak

:: copy the relevant files to the location specified in --prefix
nmake -f ms\ntdll.mak install

:: delete the engines folder (to-do: yet to find a way to compile these into libeay32.dll)
rd C:\local\libs\openssl\lib\engines /s /q

:: switch to the out32dll directory
cd out32dll

:: copy the openssl32.exe file (for the tests)
copy openssl32.exe openssl.exe

:: run the tests
..\ms\test