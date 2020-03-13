# libpng
Build differently named 32 and 64 bit binaries for libpng that link to differently named zlib binaries

## PREREQUISITES
1. libpng source code: tested with [libpng 1.2.53](http://www.libpng.org/pub/png/libpng.html)
2. fnr: tested with [fnr](http://findandreplace.io/downloads/fnr.zip) v1.8.1
3. msvc: tested with [MSVS 2019 Community Edition](https://visualstudio.microsoft.com/)
4. zlib binaries: tested with [zlib 1.2.8](http://zlib.net/)
5. [These](https://github.com/alecmus/buildscripts/tree/master/libpng/scripts) libpng build scripts

## STEPS
1. Copy fnr.exe to C:\local\libs\fnr\bin
2. Extract libpng source to C:\local\temp\libpng (so that source is in C:\local\temp\libpng\lpng12x)
3. Place zlib in C:\local\libs\zlib such that zlib64.lib and zlib32.lib are in C:\local\libs\zlib\lib
4. Extract the scripts in zlib_1.2.x_build_batch.7z to C:\local\temp\zlib
    1. Build by running [Build.bat](https://github.com/alecmus/buildscripts/tree/master/libpng/scripts/Build.bat)
    2. Files will be places in C:\local\libs\libpng
