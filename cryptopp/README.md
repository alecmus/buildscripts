# crypto++
Build differently named 32 and 64 bit binaries for crypto++

## PREREQUISITES
1. crypto++ source code: tested with [cryptopp-CRYPTOPP_8_2_0.zip](https://github.com/weidai11/cryptopp/archive/CRYPTOPP_8_2_0.zip)
2. msvc: tested with [MSVS 2019 Community Edition](https://visualstudio.microsoft.com/)

## STEPS
1. Extract source code and open cryptest.sln
2. Under project properties for the project cryptlib do this:
    1. C/C++ -> Precompiled Headers -> Precompiled Header
        * ALL	Not Using Precompiled Headers
    2. C/C++ -> General -> Debug Information Format
        * ALL	None
    3. C/C++ -> Code Generation -> Runtime Library
        * Debug	MDd
        * Release	MD
    4. Configuration Properties -> General -> Target Name (because of some issue build them one at a time)
        * In the VS menu select appropriately under Solution Configurations and Solution Platforms
        * Right click the project cryptlib in Solution Explorer and select Project Only -> Build Only cryptlib
            * x64 Release	$(ProjectName)64
            * x64 Debug	$(ProjectName)64d
            * Win32 Release	$(ProjectName)32
            * Win32 Debug	$(ProjectName)32d
    5. Place the files into C:\local\libs\cryptopp
        * \include	all 175 .h files
        * \bin	Release: cryptlib32.dll, cryptlib64.dll
                Debug: cryptlib32d.dll, cryptlib64d.dll
        * \lib	Release: cryptlib32.lib, cryptlib64.lib
                Debug: cryptlib32d.lib, cryptlib64d.lib
