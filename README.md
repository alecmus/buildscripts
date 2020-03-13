# buildscripts
Scripts for automating the build process for some libraries that are crucial to desktop development in C++ on Windows

Scripts for the following are available:

Item           | Script      | Description
-------------- | ----------- | -----------------------------------------------------------------------
openssl        | [Build.bat](https://github.com/alecmus/buildscripts/blob/master/openssl/scripts/Build.bat)   | Script for automating x86 and x64 builds, naming the builds differently
sqlcipher      | [Build.bat](https://github.com/alecmus/buildscripts/blob/master/sqlcipher/scripts/Build.bat)   | Script for automating x86 and x64 builds, naming the builds differently
poco           | [Buildx64.bat](https://github.com/alecmus/buildscripts/blob/master/poco/scripts/Buildx64.bat), [Buildx86.bat](https://github.com/alecmus/buildscripts/blob/master/poco/scripts/Buildx86.bat)   | Script for automating x86 and x64 builds, linking the builds to differently named OpenSSL binaries
