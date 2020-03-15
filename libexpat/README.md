# libexpat
Build differently named 32 and 64 bit binaries for libexpat

## PREREQUISITES
1. msvc: tested with [MSVS 2019 Community Edition](https://visualstudio.microsoft.com/)
2. libexpat VS2019 solution: tested with [these sources](https://github.com/alecmus/files/tree/master/libexpat/source)

## STEPS
1. Save [these files](https://github.com/alecmus/files/tree/master/libharu/source) to C:\local\temp and open expat.sln
2. Select Build -> Batch and select all four configurations (Release|Debug)<-->(x64|Win32) and build (skip templates)
     1. Place the files into C:\local\libs\libexpat
          * \include	all .h files except macconfig.h and amigaconfig.h
          * \bin		Release: libexpat32.dll, libexpat64.dll
                    Debug: libexpat32d.dll, libexpat64d.dll
          * \lib		Release: libexpat32.lib, libexpat64.lib
                    Debug: libexpat32d.lib, libexpat64d.lib

## HOW THE VS2019 SOLUTION WAS CREATED
1. Extract [libexpat201.7z](https://sourceforge.net/projects/expat/) (source code from sourceforge)
2. Open the VC++ project expat.dsw and allow the upgrade
3. Rename the project expat to libexpat and delete all the other projects
4. Add x64 configuration by right clicking Solution in Solution Explorer -> Configuration Manager
    * Under Active solution platform -> New … -> x64 and OK (copying settings from x86)
5. Under project properties for the project libexpat do the following:
     1. Configuration Properties -> General -> Target Name
          * x64 Release	$(ProjectName)64
          * x64 Debug	$(ProjectName)64d
          * Win32 Release	$(ProjectName)32
          * Win32 Debug	$(ProjectName)32d
     2. C/C++ -> Precompiled Headers -> Precompiled Header
          * ALL	Not Using Precompiled Headers
     3. Linker -> General -> Output File
          * ALL	$(OutDir)$(TargetName)$(TargetExt)
     4. Linker -> Advanced -> Import Library
          * ALL	$(OutDir)$(TargetName).lib
     5. C/C++ -> Code Generation -> Function Level Linking
          * ALL	Yes (/Gy)
     6. C/C++ -> Code Generation -> Runtime Library
          * Debug	MDd
          * Release	MD
7. All four configurations ready to be built as [this](https://github.com/alecmus/files/tree/master/libexpat/source) ready-made solution
    1. Under Build -> Batch Build select all except the Template|x86 and Template|x64
    2. Build
    3. Place the files into C:\local\libs\libexpat
        * \include	all .h files except macconfig.h and amigaconfig.h
        * \bin	Release: libexpat32.dll, libexpat64.dll
                Debug: libexpat32d.dll, libexpat64d.dll
        * \lib	Release: libexpat32.lib, libexpat64.lib
                Debug: libexpat32d.lib, libexpat64d.lib
