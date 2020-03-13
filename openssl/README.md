# openssl
Build differently named 32 and 64 bit binaries for OpenSSL on Windows

## CREDITS
Ideas were borrowed from 
[here](http://www.lenholgate.com/blog/2012/08/building-openssl-for-x86-and-x64-on-windows-for-side-by-side-deployment.html).

## PREREQUISITES
1. openssl source: tested with [openssl-1.0.2s.tar.gz](https://www.openssl.org/source/old/1.0.2/openssl-1.0.2s.tar.gz).
2. nasm binary: tested with [nasm-2.14.02-win32.zip](https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/win32/nasm-2.14.02-win32.zip).
3. fnr binary: tested with [fnr.zip](http://findandreplace.io/downloads/fnr.zip).
4. perl 5: tested with [ActivePerl 5.28.1.2801 x64](https://www.activestate.com/products/perl/).
5. msvc: tested with [MSVS 2019 Community Edition](https://visualstudio.microsoft.com/).
6. openssl build scripts: tested with [these](https://github.com/alecmus/buildscripts/tree/master/openssl/scripts) scripts.

## STEPS
1. Place nasm.exe in C:\local\libs\nasm\bin
2. Place fnr.exe in C:\local\libs\fnr\bin
3. Install Perl 5 (ActivePerl recommented; it will install to C:\Perl64)
4. Extract scripts in openssl_1.0.x_build_scripts.7z to C:\local\temp\openssl
5. Extract openssl source to C:\local\temp\openssl (so that source is in C:\local\temp\openssl\openssl-1.0.x)

At this point, the build process can be <b>fully automated</b> by placing [these](https://github.com/alecmus/buildscripts/tree/master/openssl/scripts) scripts into C:\local\temp\openssl and running [Build.bat](https://github.com/alecmus/buildscripts/blob/master/openssl/scripts/Build.bat). The automated scripts makes steps 7 and 8 unnecessary, but they've been added here for convenience and reference, and in case issues with the automated scripts arise in the future.

Steps 7 and 8 require saving [these](https://github.com/alecmus/buildscripts/tree/master/openssl/scripts_stepwise) scripts into C:\local\temp\openssl.

7. <b>Build the x64 binaries</b> (scripts assume the above mentioned locations)
    1. copy the folder openssl-1.0.x to openssl-1.0.x_x64. If the folder already existed, delete it first!
    2. Use MSVS to replace all occurrences (in openssl-1.0.x_x64 folder) of the text listed below (Open MSVS without a project, Edit -> Find and Replace -> Replace in Files (include subfolders, match case)):	
        * eay32 -> eay64 (70 occurrences)
        * 32dll -> 64dll (23 occurrences)
        * openssl.exe -> openssl64.exe (28 occurrences)	
    3. Run [Buildx64_1.bat](https://github.com/alecmus/buildscripts/blob/master/openssl/scripts_stepwise/Buildx64_1.bat). Should report 'Configured for VC-WIN64A'.
    4. Use MSVS to replace all occurrences (in openssl-1.0.x_x64 folder) of the following text:
        * EAY32 -> EAY64 (2 occurrences)
        * 32dll -> 64dll (2 occurrences)
        * E_EXE=openssl -> E_EXE=openssl64 (3 occurrences)
    5. Run [Buildx64_2.bat](https://github.com/alecmus/buildscripts/blob/master/openssl/scripts_stepwise/Buildx64_2.bat)
        * Should report 'passed all tests'
        * Files will be placed in C:\local\libs\openssl
        * Output is libeay64.dll (uses libeay64.lib)

8. <b>Build the x86 binaries</b> (scripts assume the above mentioned locations)		
    1. copy the folder openssl-1.0.x to openssl-1.0.x_x86. If the folder already existed, delete it first!
    2. Use MSVS to replace all occurrences (in openssl-1.0.x_86 folder) of the following text:
        * openssl.exe -> openssl32.exe (28 occurrences)
    3. Run [Buildx64_1.bat](https://github.com/alecmus/buildscripts/blob/master/openssl/scripts_stepwise/Buildx86_1.bat)
        * Should report 'Configured for VC-WIN32'
    4. Use MSVS to replace all occurrences (in openssl-1.0.x_x86 folder) of the following text:
        * E_EXE=openssl -> E_EXE=openssl32 (4 occurrences)
    5. Run [Buildx64_2.bat](https://github.com/alecmus/buildscripts/blob/master/openssl/scripts_stepwise/Buildx86_2.bat)
        * Should report 'passed all tests'
        * Files will be placed in C:\local\libs\openssl
        * Output is libeay64.dll (uses libeay64.lib)
