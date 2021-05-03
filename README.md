# buildscripts
Scripts for automating or simplifying the build process for some libraries that are crucial to desktop development in C++ on Windows

<p>
  <img alt="Lines of code" src="https://img.shields.io/tokei/lines/github/alecmus/buildscripts">
</p>

Scripts for the following are available:

Item           | Script      | Description
-------------- | ----------- | -----------------------------------------------------------------------
openssl        | [Build.bat](https://github.com/alecmus/buildscripts/blob/master/openssl/scripts/Build.bat)   | Script for automating x86 and x64 builds, naming the builds differently
sqlcipher      | [Build.bat](https://github.com/alecmus/buildscripts/blob/master/sqlcipher/scripts/Build.bat)   | Script for automating x86 and x64 builds, naming the builds differently
poco           | [Buildx64.bat](https://github.com/alecmus/buildscripts/blob/master/poco/scripts/Buildx64.bat), [Buildx86.bat](https://github.com/alecmus/buildscripts/blob/master/poco/scripts/Buildx86.bat)   | Script for automating x86 and x64 builds, linking the builds to differently named OpenSSL binaries
zlib           | [Build.bat](https://github.com/alecmus/buildscripts/blob/master/zlib/scripts/Build.bat)  | Script for automating x86 and x64 builds, naming the builds differently
libpng         | [Build.bat](https://github.com/alecmus/buildscripts/blob/master/libpng/scripts/Build.bat)  | Script for automating x86 and x64 builds, linking the builds to differently named zlib binaries
libharu         | None  | Step by step [instructions](https://github.com/alecmus/buildscripts/blob/master/libharu/README.md) on how to prepare a vs2019 solution that builds to differently named libharu binaries and that link to differently named zlib binaries
libexpat         | None  | Step by step [instructions](https://github.com/alecmus/buildscripts/blob/master/libexpat/README.md) on how to prepare a vs2019 solution that builds to differently named libexpat binaries
crypto++         | None  | Step by step [instructions](https://github.com/alecmus/buildscripts/blob/master/cryptopp/README.md) on how to modify the provided vs2019 solution so it can build to differently named crypto++ binaries
