@echo on
SETLOCAL 
pushd %~dp0
pushd ..\..\vcpkg\scripts\buildsystems
set t=%CD%\vcpkg.cmake
set tcf=%t:\=/%
popd
for %%p in (x86,x64) do (
  rmdir /q /s vs-16.0-%%p
  mkdir vs-16.0-%%p
  echo CMAKE_TOOLCHAIN_FILE:FILEPATH=%tcf% > vs-16.0-%%p\CMakeCache.txt
  type CMakeCache.txt >> vs-16.0-%%p\CmakeCache.txt
)
popd
