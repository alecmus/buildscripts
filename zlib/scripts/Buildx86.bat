:: call the x86 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat"

:: set the paths to Perl and fnr
set PATH=%PATH%;C:\local\libs\fnr\bin;

:: create copy of the directory
xcopy "zlib-1.2.x" "zlib-1.2.x_x86" /R /Y /I /E

set VERSION86=zlib-1.2.x_x86

:: switch to the x86 directory ----------------------------------------
cd %VERSION86%

:: replace all occurrences of '1.dll' with '32.dll'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "1.dll" --replace "32.dll"
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "1.DLL" --replace "32.DLL"

:: replace all occurrences of zdll with zlib32
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "zdll" --replace "zlib32"

:: build for x86
nmake -f win32/Makefile.msc LOC="-DASMV -DASMINF" OBJA="inffas32.obj match686.obj"

:: copy the relevant files
xcopy "zlib32.dll" "C:\local\libs\zlib\bin\" /F /R /Y /I
xcopy "zlib32.lib" "C:\local\libs\zlib\lib\" /F /R /Y /I
xcopy "zlib32.exp" "C:\local\libs\zlib\lib\" /F /R /Y /I
xcopy "zlib.h" "C:\local\libs\zlib\include\" /F /R /Y /I
xcopy "zutil.h" "C:\local\libs\zlib\include\" /F /R /Y /I
xcopy "zconf.h" "C:\local\libs\zlib\include\" /F /R /Y /I

:: done building ... delete the folder ...
cd ..\
rd %VERSION86% /s /q