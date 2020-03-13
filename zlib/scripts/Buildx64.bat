:: call the x64 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

:: set the paths to Perl and fnr
set PATH=%PATH%;C:\local\libs\fnr\bin;

:: create copy of the directory
xcopy "zlib-1.2.x" "zlib-1.2.x_x64" /R /Y /I /E

set VERSION64=zlib-1.2.x_x64

:: switch to the x64 directory ----------------------------------------
cd %VERSION64%

:: replace all occurrences of '1.dll' with '64.dll'
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "1.dll" --replace "64.dll"
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "1.DLL" --replace "64.DLL"

:: replace all occurrences of zdll with zlib64
fnr --cl --dir %cd% --fileMask "*.*"  --useRegEx --caseSensitive --includeSubDirectories --find "zdll" --replace "zlib64"

:: build for x64
nmake -f win32/Makefile.msc AS=ml64 LOC="-DASMV -DASMINF -I." OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"

:: copy the relevant files
xcopy "zlib64.dll" "C:\local\libs\zlib\bin\" /F /R /Y /I
xcopy "zlib64.lib" "C:\local\libs\zlib\lib\" /F /R /Y /I
xcopy "zlib64.exp" "C:\local\libs\zlib\lib\" /F /R /Y /I
xcopy "zlib.h" "C:\local\libs\zlib\include\" /F /R /Y /I
xcopy "zutil.h" "C:\local\libs\zlib\include\" /F /R /Y /I
xcopy "zconf.h" "C:\local\libs\zlib\include\" /F /R /Y /I

:: done building ... delete the folder ...
cd ..\
rd %VERSION64% /s /q