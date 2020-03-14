# libharu
Build differently named 32 and 64 bit binaries for libharu that link to differently named zlib binaries

## PREREQUISITES
1. zlib binaries: tested with [zlib 1.2.8](http://zlib.net/)
2. libpng static libraries: tested with [libpng 1.2.53](http://www.libpng.org/pub/png/libpng.html)
4. msvc: tested with [MSVS 2019 Community Edition](https://visualstudio.microsoft.com/)
6. libpng vs2019 solution: tested with [these sources](https://github.com/alecmus/files/tree/master/libharu/source).

## STEPS
1. Save [these files](https://github.com/alecmus/files/tree/master/libharu/source) to C:\local\libharu and open libharu.sln
2. Place zlib in C:\local\libs\zlib such that zlib64.lib and zlib32.lib are in C:\local\libs\zlib\lib
3. Place libpng in C:\local\libs\libpng such that libpng64.lib and libpng32.lib are in C:\local\libs\libpng\lib
4. Select Build -> Batch and select all four configurations (Release|Debug)<-->(x64|Win32) and build
    1. Place the files into C:\local\libs\libharu
        * \include	all 64 .h files
        * \bin		Release: libharu32.dll, libharu64.dll
                  Debug: libharu32d.dll, libharu64d.dll
        * \lib		Release: libharu32.lib, libharu64.lib
		              Debug: libharu32d.lib, libharu64d.lib

## HOW THE VS 2019 SOLUTION WAS CREATED
1. Extract [libharu-RELEASE_2_3_0.zip](https://github.com/libharu/libharu/archive/RELEASE_2_3_0.zip)
2. Create a Visual Studio Solution ... Win32 ... DLL ... empty project ... and name it libharu
3. Copy the following files into the project directory:
    1. .c files in /src (and t4.h)
    2. all .h files in /include and the .h file in /win32/include
    3. The file "libhpdf.rc.template" under /win32. Rename it to libhpdf.rc
4. Import all the files in 3 into the project
5. Edit the files as follows:
    1. hpdf_version.h	remove all occurences of RC2
    2. hpdf_config.h	replace all occurences of 2.2.0 with 2.3.0
    3. hpdf_image_png.c	initialize row to NULL in line 244 (png_bytep *row_ptr, row;)
    4. libhpdf.rc		replace all occurences of _VERSION2 with 2.3.0
        * replace all occurrences of _VERSION1 with 2,3,0
        * edit "Haru Free PDF Library [_COMPILER]" to just "Haru Free PDF Library"
6. Under project properties do the following:
    1. Configuration Properties -> General -> Target Name
        * x64 Release	$(ProjectName)64
        * x64 Debug	$(ProjectName)64d
        * Win32 Release	$(ProjectName)32
        * Win32 Debug	$(ProjectName)32d
    2. C/C++ -> Precompiled Headers -> Precompiled Header
        * ALL	Not Using Precompiled Headers
    3. C/C++ -> Preprocessor -> Preprocessor Definitions
        * ALL	Add HPDF_DLL_MAKE_CDECL
    4. C/C++ -> General -> Additional Include Directories
        * ALL	C:\local\libs\zlib\include
        * C:\local\libs\libpng\include
    5. Linker -> General -> Additional Library Directories
        * ALL	C:\local\libs\zlib\lib
        * C:\local\libs\libpng\lib
    6. Linker -> General -> Additional Dependencies
        * x64 both	zlib64.lib, libpng64.lib
        * Win32 both	zlib32.lib, libpng32.lib
7. All four configurations ready to be built as [this](https://github.com/alecmus/files/tree/master/libharu/source) ready-made solution.
