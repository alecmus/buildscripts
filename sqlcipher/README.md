# sqlcipher
Build differently named 32 and 64 bit binaries for SQLCipher

## CREDITS
Some ideas borrowed from [here](https://github.com/sqlitebrowser/sqlitebrowser/wiki/Win64-setup-%E2%80%94-Compiling-SQLCipher).

## PREREQUISITES
1. sqlcipher source code: tested with [sqlcipher-4.2.0.zip](https://github.com/sqlcipher/sqlcipher/releases/tag/v4.2.0)
2. OpenSSL x86 and x64: tested with [OpenSSL 1.0.2s](https://www.openssl.org/source/old/1.0.2/openssl-1.0.2s.tar.gz)
3. tcl 8: tested with [ActiveTcl 8.5.18.0.298892 x86_64](https://www.activestate.com/products/tcl/)
4. fnr: tested with [fnr](http://findandreplace.io/downloads/fnr.zip) v1.8.1
5. msvc: tested with [MSVS 2019 Community Edition](https://visualstudio.microsoft.com/)
6. sqlcipher build scripts: tested with [these](https://github.com/alecmus/buildscripts/tree/master/sqlcipher/scripts) scripts

## STEPS
1. Place openssl in C:\local\libs\openssl such that libeay32.lib, ssleay32.lib, libeay64.lib, ssleay64.lib are in \lib
2. Install Tcl 8 (ActiveTcl recommented; install it to C:\local\libs\tcl)
3. Copy fnr.exe to C:\local\libs\fnr\bin
4. Extract sqlcipher source to C:\local\temp\sqlcipher (so that source is in C:\local\temp\sqlcipher\sqlcipher-4.x)

At this point the build process can be <b>fully automated</b> by saving [these](https://github.com/alecmus/buildscripts/blob/master/sqlcipher/scripts) scripts to C:\local\temp\sqlcipher and running [Build.bat](https://github.com/alecmus/buildscripts/blob/master/sqlcipher/scripts/Build.bat) (files will be placed in C:\local\libs\sqlcipher). The automated scripts makes steps 5 and 6 unnecessary, but they've been added here for convenience and reference, and in case issues with the automated scripts arise in the future.

5. <b>Build the x64 binaries</b> (scripts assume the above mentioned locations)
    1. Copy the folder sqlcipher-4.x to sqlcipher-4.x_x64. If the folder already existed, delete it first!
    2. Edit the file sqlcipher-4.x_x64\Makefile.msc as follows:	
        1. Rename the dll to sqlcipher64.dll. Use the definition of SQLITE3DLL.
        2. Rename the lib to sqlcipher64.lib. Use the definition of SQLITE3LIB.
        3. Rename the exe to sqlcipher64.exe. Use the definition of SQLITE3EXE.
        4. Rename the pdb to sqlcipher64sh.pdb. Use the definition of SQLITE3EXEPDB.
        5. Set -DSQLITE_TEMP_STORE to 2 for both TCC and RCC.
            * Edit TCC = $(TCC) -DSQLITE_TEMP_STORE=1 and RCC = $(RCC) -DSQLITE_TEMP_STORE=1.
        6. Add -DSQLITE_HAS_CODEC to TCC and RCC.
            * Insert just below RCC = $(RCC) -DSQLITE_TEMP_STORE=2 as follows: TCC = $(TCC) -DSQLITE_HAS_CODEC and RCC = $(RCC) -DSQLITE_HAS_CODEC.
        7. Add OpenSSL include path to TCC and RCC.
            * Insert just below RCC = $(RCC) -DSQLITE_HAS_CODEC as follows: TCC = $(TCC) -IC:\local\libs\openssl\include and RCC = $(RCC) -IC:\local\libs\openssl\include.
        8. Add OpenSSL library path and library filenames.
            * Insert just above the line comment # If ICU support is enabled, add the linker options for it.
            * LTLIBPATHS = $(LTLIBPATHS) /LIBPATH:C:\local\libs\openssl\lib
            * LTLIBS = $(LTLIBS) libeay64.lib ssleay64.lib
        9. Replace all occurrences of sqlite3.def with sqlcipher64.def
    3. Open the x64 Native Tools Command Prompt for VS 2019 and change directory to \sqlcipher-4.x_x64
    4. Build the library by running nmake /f Makefile.msc
        * Output is sqlcipher64.dll (uses sqlcipher64.lib and sqlite3.h). The shell is sqlcipher64.exe


6. <b>Build the x86 binaries</b> (scripts assume the above mentioned locations)		
    1. Copy the folder sqlcipher-4.x to sqlcipher-4.x_x86. If the folder already existed, delete it first!
    2. Edit the file sqlcipher-4.x_x86\Makefile.msc as follows:
        1. Rename the dll to sqlcipher32.dll. Use the definition of SQLITE3DLL.
        2. Rename the lib to sqlcipher32.lib. Use the definition of SQLITE3LIB.
        3. Rename the exe to sqlcipher32.exe. Use the definition of SQLITE3EXE.
        4. Rename the pdb to sqlcipher32sh.pdb. Use the definition of SQLITE3EXEPDB.
        5. Set -DSQLITE_TEMP_STORE to 2 for both TCC and RCC
            * Edit TCC = $(TCC) -DSQLITE_TEMP_STORE=1 and RCC = $(RCC) -DSQLITE_TEMP_STORE=1
        6. Add -DSQLITE_HAS_CODEC to TCC and RCC. Insert just below RCC = $(RCC) -DSQLITE_TEMP_STORE=2 as follows:
            * TCC = $(TCC) -DSQLITE_HAS_CODEC and RCC = $(RCC) -DSQLITE_HAS_CODEC
        7. Add OpenSSL include path to TCC and RCC. Insert just below RCC = $(RCC) -DSQLITE_HAS_CODEC as follows:
            * TCC = $(TCC) -IC:\local\libs\openssl\include and RCC = $(RCC) -IC:\local\libs\openssl\include
        8. Add OpenSSL library path and library filenames.
            * Insert just above the line comment # If ICU support is enabled, add the linker options for it.
            * LTLIBPATHS = $(LTLIBPATHS) /LIBPATH:C:\local\libs\openssl\lib
            * LTLIBS = $(LTLIBS) libeay32.lib ssleay32.lib
        9. Replace all occurrences of sqlite3.def with sqlcipher32.def
     3. Open the x86 Native Tools Command Prompt for VS 2019 and change directory to \sqlcipher-4.x_x86
     4. Build the library by running nmake /f Makefile.msc
         * Output is sqlcipher32.dll (uses sqlcipher32.lib and sqlite3.h). The shell is sqlcipher32.exe
