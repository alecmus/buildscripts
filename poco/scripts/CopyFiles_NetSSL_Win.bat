:: call the x64 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

:: x64 files
xcopy "poco-1.x\bin64" "C:\local\libs\poco\bin" /R /Y /I /E
xcopy "poco-1.x\lib64" "C:\local\libs\poco\lib" /R /Y /I /E

:: x86 files
xcopy "poco-1.x\bin" "C:\local\libs\poco\bin" /R /Y /I /E
xcopy "poco-1.x\lib" "C:\local\libs\poco\lib" /R /Y /I /E

:: include files
xcopy "poco-1.x\ApacheConnector\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\CppParser\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\CppUnit\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Crypto\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Data\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Data\ODBC\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Data\SQLite\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Encodings\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Foundation\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\JSON\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\MongoDB\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Net\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\NetSSL_Win\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\PDF\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Redis\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\SevenZip\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Util\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\XML\include" "C:\local\libs\poco\include" /R /Y /I /E
xcopy "poco-1.x\Zip\include" "C:\local\libs\poco\include" /R /Y /I /E

pause