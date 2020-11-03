@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL DISABLEDELAYEDEXPANSION
pushd %~dp0
mkdir "vs-16.0-x86"
copy CMakeCache.txt "vs-16.0-x86"
mkdir "vs-16.0-x64"
del "vs-16.0-x64\CMakeCache.txt"
for /f "tokens=1,* delims=]" %%A in ('"type CMakeCache.txt|find /n /v """') do (
    set "line=%%B"
    if defined line (
        call set "line=echo.%%line:32=64%%"
        call set "line=echo.%%line:86=64%%"
        for /f "delims=" %%X in ('"%%line%%"') do %%~X >> "vs-16.0-x64\CMakeCache.txt"
    ) ELSE echo.
)
popd
