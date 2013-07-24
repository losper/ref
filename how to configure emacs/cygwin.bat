@SET CYGWIN=D:\app\cygwin\bin

@if "%CYGWIN%"=="" goto error_no_CYGWIN

@echo Setting environment for using cygwin tools.

@rem
@rem Root of Visual Studio IDE installed files.
@rem
@rem set DevEnvDir=D:\Program Files\ms\Common7\IDE

@set PATH=D:\app\cygwin\bin;%PATH%
@rem set INCLUDE=D:\Program Files\ms\VC\ATLMFC\INCLUDE;D:\Program Files\ms\VC\INCLUDE;D:\Program Files\ms\VC\PlatformSDK\include;D:\Program Files\ms\SDK\v2.0\include;%INCLUDE%
@rem set LIB=D:\Program Files\ms\VC\ATLMFC\LIB;D:\Program Files\ms\VC\LIB;D:\Program Files\ms\VC\PlatformSDK\lib;D:\Program Files\ms\SDK\v2.0\lib;%LIB%
@rem set LIBPATH=C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727;D:\Program Files\ms\VC\ATLMFC\LIB

@goto end

:error_no_CYGWIN
@echo ERROR: CYGWIN variable is not set. 
@goto end

:end
