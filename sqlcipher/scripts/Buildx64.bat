:: call the x64 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

:: set the paths to tcl and fnr
set PATH=%PATH%;C:\local\libs\tcl\bin;C:\local\libs\fnr\bin;

:: create copy of the directory
xcopy "sqlcipher-4.x" "sqlcipher-4.x_x64" /R /Y /I /E

set VERSION64=sqlcipher-4.x_x64

:: switch to the x64 directory ----------------------------------------
cd %VERSION64%

:: rename dll
fnr --cl --dir %cd% --fileMask "Makefile.msc" --useRegEx –-caseSensitive --find "SQLITE3DLL = winsqlite3.dll" --replace "SQLITE3DLL = sqlcipher64.dll"
fnr --cl --dir %cd% --fileMask "Makefile.msc"  --useRegEx –-caseSensitive --find "SQLITE3DLL = sqlite3.dll" --replace "SQLITE3DLL = sqlcipher64.dll"

:: rename lib
fnr --cl --dir %cd% --fileMask "Makefile.msc"  --useRegEx –-caseSensitive --find "SQLITE3LIB = winsqlite3.lib" --replace "SQLITE3LIB = sqlcipher64.lib"
fnr --cl --dir %cd% --fileMask "Makefile.msc"  --useRegEx –-caseSensitive --find "SQLITE3LIB = sqlite3.lib" --replace "SQLITE3LIB = sqlcipher64.lib"

:: rename exe
fnr --cl --dir %cd% --fileMask "Makefile.msc"  --useRegEx –-caseSensitive --find "SQLITE3EXE = winsqlite3shell.exe" --replace "SQLITE3EXE = sqlcipher64.exe"
fnr --cl --dir %cd% --fileMask "Makefile.msc"  --useRegEx –-caseSensitive --find "SQLITE3EXE = sqlite3.exe" --replace "SQLITE3EXE = sqlcipher64.exe"

:: rename pdb
fnr --cl --dir %cd% --fileMask "Makefile.msc"  --useRegEx –-caseSensitive --find "SQLITE3EXEPDB = /pdb:sqlite3sh.pdb" --replace "SQLITE3EXEPDB = /pdb:sqlcipher64sh.pdb"

:: do the rest (1. setting -DSQLITE_TEMP_STORE to 2, 2. Adding -DSQLITE_HAS_CODEC to the TCC and RCC variables, 3. Adding the openssl include path to TCC and RCC)
fnr --cl --dir %cd% --fileMask "Makefile.msc"  –-caseSensitive --find "TCC = $(TCC) -DSQLITE_TEMP_STORE=1" --replace "TCC = $(TCC) -DSQLITE_TEMP_STORE=2"
fnr --cl --dir %cd% --fileMask "Makefile.msc"  –-caseSensitive --find "RCC = $(RCC) -DSQLITE_TEMP_STORE=1" --replace "RCC = $(RCC) -DSQLITE_TEMP_STORE=2\n\n# Add -DSQLITE_HAS_CODEC to TCC and RCC\nTCC = $(TCC) -DSQLITE_HAS_CODEC\nRCC = $(RCC) -DSQLITE_HAS_CODEC\n\n# Add OpenSSL include path to TCC and RCC\nTCC = $(TCC) -IC:\local\libs\openssl\include\nRCC = $(RCC) -IC:\local\libs\openssl\include"

:: add OpenSSL library path and library filenames just above the line with the comment '# If ICU support is enabled, add the linker options for it.'
fnr --cl --dir %cd% --fileMask "Makefile.msc" –-caseSensitive --find "# If ICU support is enabled, add the linker options for it." --replace "# Add OpenSSL library path and library filenames\nLTLIBPATHS = $(LTLIBPATHS) /LIBPATH:C:\local\libs\openssl\lib\nLTLIBS = $(LTLIBS) libeay64.lib ssleay64.lib\n\n# If ICU support is enabled, add the linker options for it."

:: replace all occurrences of 'sqlite3.def' with 'sqlcipher64.def'
fnr --cl --dir %cd% --fileMask "Makefile.msc"  --useRegEx –-caseSensitive --find "sqlite3.def" --replace "sqlcipher64.def"

:: build the library for x64
nmake /f Makefile.msc

:: copy the relevant files
xcopy "sqlcipher64.exe" "C:\local\libs\sqlcipher\bin\" /F /R /Y /I
xcopy "sqlcipher64.dll" "C:\local\libs\sqlcipher\bin\" /F /R /Y /I
xcopy "sqlcipher64.lib" "C:\local\libs\sqlcipher\lib\" /F /R /Y /I
xcopy "sqlcipher64.def" "C:\local\libs\sqlcipher\lib\" /F /R /Y /I
xcopy "sqlcipher64.exp" "C:\local\libs\sqlcipher\lib\" /F /R /Y /I
xcopy "sqlite3.h" "C:\local\libs\sqlcipher\include\" /F /R /Y /I

:: done building ... delete the folder ...
cd ..\
rd %VERSION64% /s /q