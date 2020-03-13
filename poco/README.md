# poco
Build 32 and 64 bit binaries for Poco on Windows that link to differently named OpenSSL binaries

## PREREQUISITES
1. Poco source code: tested with [poco 1.9.0](https://pocoproject.org/)
2. OpenSSL x86 and x64: tested with [OpenSSL 1.0.2s](https://www.openssl.org/source/old/1.0.2/openssl-1.0.2s.tar.gz)
3. fnr: tested with [fnr](http://findandreplace.io/downloads/fnr.zip) v1.8.1
4. msvc: tested with [MSVS 2019 Community Edition](https://visualstudio.microsoft.com/)
5. poco build scripts: tested with [these](https://github.com/alecmus/buildscripts/tree/master/poco/scripts) scripts.

## STEPS
1. Place openssl in C:\local\libs\openssl such that libeay32.lib, ssleay32.lib, libeay64.lib, ssleay64.lib are in \lib
2. Copy fnr.exe to C:\local\libs\fnr\bin
3. Extract poco source to C:\local\temp\poco (so that source is in C:\local\temp\poco\poco-1.x)
4. Save [these](https://github.com/alecmus/buildscripts/tree/master/poco/scripts) scripts to C:\local\temp\poco
    1. Build for 64-bit by running [Buildx64.bat](https://github.com/alecmus/buildscripts/blob/master/poco/scripts/Buildx64.bat)
    2. Build for 32-bit by running [Buildx86.bat](https://github.com/alecmus/buildscripts/blob/master/poco/scripts/Buildx86.bat)
    3. Copy files by running [CopyFiles_NetSSL.bat](https://github.com/alecmus/buildscripts/blob/master/poco/scripts/CopyFiles_NetSSL.bat) (files will be placed in C:\local\libs\poco)

NB: The files in \include\poco\Net\ are different for PocoNetSSLWin and PocoNetSSL.
Use [CopyFiles_NetSSL_Win.bat](https://github.com/alecmus/buildscripts/blob/master/poco/scripts/CopyFiles_NetSSL_Win.bat) instead if you prefer to use PocoNetSSLWin.dll instead of PocoNetSSL.dll
