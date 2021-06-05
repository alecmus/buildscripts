:: call the x64 Native Tools Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

:: set the paths to fnr
set PATH=%PATH%;C:\local\libs\fnr\bin;

:: switch to the poco directory ----------------------------------------
cd "poco-1.x"

:: remove MySQL
rd "Data\MySQL" /s /q

:: edit poco-1.x\buildwin.cmd to capture the location of OpenSSL
fnr --cl --dir %cd% --fileMask "buildwin.cmd" –-caseSensitive --find "OPENSSL_DIR=C:\OpenSSL" --replace "OPENSSL_DIR=C:\local\libs\openssl"

:: retarget projects from VS 2017 to VS 2019
fnr --cl --dir %cd% --fileMask "*.vcxproj" –-caseSensitive --includeSubDirectories --find "<PlatformToolset>v141</PlatformToolset>" --replace "<PlatformToolset>v142</PlatformToolset>"

:: add openssl library dependency to Crypto and NetSSL_OpenSSL
fnr --cl --dir %cd%\Crypto --fileMask "Crypto_x64_vs150.vcxproj" –-caseSensitive --includeSubDirectories --find "ws2_32.lib;iphlpapi.lib;" --replace "ws2_32.lib;libeay64.lib;ssleay64.lib;iphlpapi.lib;"
fnr --cl --dir %cd%\Crypto --fileMask "TestSuite_x64_vs150.vcxproj" –-caseSensitive --includeSubDirectories --find "ws2_32.lib;iphlpapi.lib;" --replace "ws2_32.lib;libeay64.lib;ssleay64.lib;iphlpapi.lib;"
fnr --cl --dir %cd%\NetSSL_OpenSSL --fileMask "NetSSL_OpenSSL_x64_vs150.vcxproj" –-caseSensitive --includeSubDirectories --find "ws2_32.lib;iphlpapi.lib;" --replace "ws2_32.lib;libeay64.lib;ssleay64.lib;iphlpapi.lib;"
fnr --cl --dir %cd%\NetSSL_OpenSSL --fileMask "TestSuite_x64_vs150.vcxproj" –-caseSensitive --includeSubDirectories --find "ws2_32.lib;iphlpapi.lib;" --replace "ws2_32.lib;libeay64.lib;ssleay64.lib;iphlpapi.lib;"

:: build the library for x64
buildwin 150 build static_md both x64 nosamples notests devenv