:: call the x86 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat"

:: set the path to fnr
set PATH=%PATH%;C:\local\libs\fnr\bin;

:: copy zlib files
xcopy "C:\local\libs\zlib\include\zlib.h" "zlib\" /F /R /Y /I
xcopy "C:\local\libs\zlib\include\zconf.h" "zlib\" /F /R /Y /I
xcopy "C:\local\libs\zlib\include\zutil.h" "zlib\" /F /R /Y /I
copy "C:\local\libs\zlib\lib\zlib32.lib" "zlib\zlib.lib" /Y

:: create copy of the directory
xcopy "lpng12x" "lpng12x_x86" /R /Y /I /E

set VERSION86=lpng12x_x86

:: switch to the x86 directory ----------------------------------------
cd %VERSION86%

:: build for x86
nmake /f scripts\makefile.vcwin32

:: copy the relevant files
ren libpng.lib libpng32.lib
xcopy "libpng32.lib" "C:\local\libs\libpng\lib\" /F /R /Y /I
xcopy "png.h" "C:\local\libs\libpng\include\" /F /R /Y /I
xcopy "pngconf.h" "C:\local\libs\libpng\include\" /F /R /Y /I

cd ..\

:: delete the zlib folder
rd zlib /s /q

:: done building ... delete the folder ...
rd %VERSION86% /s /q