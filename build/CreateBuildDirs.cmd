@echo on
SETLOCAL enabledelayedexpansion
pushd %~dp0
FOR /F %%i IN ('DIR /B /O:D') DO SET NEWEST=%%i
IF "%NEWEST:~0,3%"=="vs-" goto end
pushd ..\..\vcpkg\scripts\buildsystems
set t=%CD%\vcpkg.cmake
set tcf=%t:\=/%
popd
for %%p in (x86,x64) do (
  if %%p==x86 (set t=Win32) else (set t=%%p)
  rmdir /q /s vs-16.0-%%p
  mkdir vs-16.0-%%p
  echo CMAKE_TOOLCHAIN_FILE:FILEPATH=%tcf% > vs-16.0-%%p\CMakeCache.txt
  type CMakeCache.txt >> vs-16.0-%%p\CmakeCache.txt
  pushd vs-16.0-%%p
  "C:\Program Files\CMake\bin\CMake.exe" ..\.. -G "Visual Studio 16 2019" -A !t! 
  popd
)
:end
popd
endlocal
