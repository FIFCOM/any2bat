:: any2bat - 万物皆可为BAT
:: Build 22/06/2019 - By FIFCOM
:: https://github.com/FIFCOM/any2bat/
@echo off
title any2bat - https://github.com/FIFCOM/any2bat/
setlocal enabledelayedexpansion

if "" == "/?" goto usage
if "%~1" == "" (goto usage)
echo.
echo [%time%]  Generating...
echo.
set file=%~dpnx1
set Ext=%~x1
if not "%~2" == "" (if "%~2" == "def" (set FileName=FIFCOM_%RANDOM%) else (set FileName=%~2))
if "%~2" == "" (set FileName=FIFCOM_%RANDOM%)
if not "%~3" == "" (if "%~3" == "def" (set OutPath=%%temp%%) else (set OutPath=%~3))
if "%~3" == "" set (OutPath=%%temp%%)
if "%~4" == "" set Hide=false
if "%~4" == "n" set Hide=false
if "%~4" == "y" set Hide=true
%windir%\System32\certutil.exe -encode %file% %file%.tmp >NUL 2>NUL
echo ^@echo off>%file%.bat
if "%Hide%" == "false" echo echo Please Wait...>>%file%.bat
if "%Hide%" == "true" echo if "%%%%1"=="h" goto fc >>%file%.bat
if "%Hide%" == "true" echo start mshta vbscript:createobject("wscript.shell")^.run(^"^"^"%%%%^~nx0^"^" h^",0)(window.close)^&^&exit >>%file%.bat
if "%Hide%" == "true" (echo ^:fc >>%file%.bat)
for /f "delims=" %%i in (%file%.tmp) do (
if "%%i"=="" (
echo.>>%file%.bat
) else (
echo echo.%%i^>^>fc>>%file%.bat
)
)
echo %%windir%%\System32\certutil.exe -decode fc ^"!OutPath!\!FileName!%Ext%^" ^>NUL 2^>NUL>>"%file%.bat"
echo del fc ^>NUL 2^>NUL >>%file%.bat
echo start ^"!OutPath!\!FileName!%Ext%^" 2^>NUL>>%file%.bat
echo exit>>%file%.bat
del %file%.tmp >NUL 2>NUL
echo [%time%]  ...Generated,save as %file%.bat
echo.
%windir%\System32\cmd.exe

:usage
echo any2bat - 万物皆可为BAT https://github.com/FIFCOM/any2bat/
echo.
echo 用法: %~n0 [要转换的文件] [输出文件名] [输出路径] [隐藏输出窗口 y/n]
echo         [输出文件名]     bat转换为文件时的文件名     默认值(def): FIFCOM_%%RANDOM%%
echo         [输出路径]       bat转换为文件时的文件夹     默认值(def): %%temp%%
echo         [隐藏输出窗口]   bat转换为文件时是否隐藏窗口 默认值(def): n
echo.
echo.
echo 示例: 
echo       %~n0 example.exe                             ^|  输出文件名和文件夹任意且显示输出窗口
echo       %~n0 example.exe FIFCOM                      ^|  输出文件夹任意且显示输出窗口
echo       %~n0 example.exe def C:\FIFCOM\              ^|  输出文件名任意且显示输出窗口
echo       %~n0 example.exe FIFCOM C:\FIFCOM\           ^|  输出文件名和文件夹自定义且显示输出窗口
echo       %~n0 example.exe FIFCOM def y                ^|  输出文件名自定义且隐藏输出窗口
echo.
%windir%\System32\cmd.exe
