:: call the x64 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

:: set the path to fnr
set PATH=%PATH%;C:\local\libs\fnr\bin;

:: copy zlib files
xcopy "C:\local\libs\zlib\include\zlib.h" "zlib\" /F /R /Y /I
xcopy "C:\local\libs\zlib\include\zconf.h" "zlib\" /F /R /Y /I
xcopy "C:\local\libs\zlib\include\zutil.h" "zlib\" /F /R /Y /I
copy "C:\local\libs\zlib\lib\zlib64.lib" "zlib\zlib.lib" /Y

:: create copy of the directory
xcopy "lpng12x" "lpng12x_x64" /R /Y /I /E

set VERSION64=lpng12x_x64

:: switch to the x64 directory ----------------------------------------
cd %VERSION64%

:: build for x64
nmake /f scripts\makefile.vcwin32

:: copy the relevant files
ren libpng.lib libpng64.lib
xcopy "libpng64.lib" "C:\local\libs\libpng\lib\" /F /R /Y /I
xcopy "png.h" "C:\local\libs\libpng\include\" /F /R /Y /I
xcopy "pngconf.h" "C:\local\libs\libpng\include\" /F /R /Y /I

cd ..\

:: delete the zlib folder
rd zlib /s /q

:: done building ... delete the folder ...
rd %VERSION64% /s /q