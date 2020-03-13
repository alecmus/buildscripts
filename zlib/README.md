# zlib
Build differently named 32 and 64 bit binaries for zlib

## PREREQUISITES
1. zlib source code: tested with [zlib 1.2.8](http://zlib.net/)
2. fnr: tested with [fnr](http://findandreplace.io/downloads/fnr.zip) v1.8.1
3. msvc: tested with [MSVS 2019 Community Edition](https://visualstudio.microsoft.com/)
4. [These](https://github.com/alecmus/buildscripts/tree/master/zlib/scripts) zlib scripts.
			
## STEPS
1. Copy fnr.exe to C:\local\libs\fnr\bin
2. Extract zlib source to C:\local\temp\zlib (so that source is in C:\local\temp\zlib\zlib-1.2.x)
3. Extract the scripts in zlib_1.2.x_build_batch.7z to C:\local\temp\zlib
    1. Build by running [Build.bat]([these](https://github.com/alecmus/buildscripts/tree/master/zlib/scripts/Build.bat) scripts.)
    2. Files will be placed in C:\local\libs\zlib
