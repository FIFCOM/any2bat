:: any2bat - ����Կ�ΪBAT
:: Build 05/06/2019 - By FIFCOM
:: https://github.com/FIFCOM/any2bat/
@echo off
title any2bat - https://github.com/FIFCOM/any2bat/
setlocal enabledelayedexpansion

if "" == "/?" goto usage
if "%~1" == "" (goto usage)
echo.
echo [%time%]  Generating...
echo.
set file="%~dpnx1"
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
echo %%windir%%\System32\certutil.exe -decode fc ^"%OutPath%\%FileName%%Ext%^" ^>NUL 2^>NUL>>"%file%.bat"
echo del fc ^>NUL 2^>NUL >>%file%.bat
echo start ^"%OutPath%\%FileName%%Ext%^" 2^>NUL>>%file%.bat
echo exit>>%file%.bat
del %file%.tmp >NUL 2>NUL
echo [%time%]  ...Generated,save as %file%.bat
echo.
%windir%\System32\cmd.exe

:usage
echo any2bat - ����Կ�ΪBAT https://github.com/FIFCOM/any2bat/
echo.
echo �÷�: %~n0 [Ҫת�����ļ�] [����ļ���] [���·��] [����������� y/n]
echo         [����ļ���]     batת��Ϊ�ļ�ʱ���ļ���     Ĭ��ֵ(def): FIFCOM_%%RANDOM%%
echo         [���·��]       batת��Ϊ�ļ�ʱ���ļ���     Ĭ��ֵ(def): %%temp%%
echo         [�����������]   batת��Ϊ�ļ�ʱ�Ƿ����ش��� Ĭ��ֵ(def): n
echo.
echo.
echo ʾ��: 
echo       %~n0 example.exe                             ^|  ����ļ������ļ�����������ʾ�������
echo       %~n0 example.exe FIFCOM                      ^|  ����ļ�����������ʾ�������
echo       %~n0 example.exe def C:\FIFCOM\              ^|  ����ļ�����������ʾ�������
echo       %~n0 example.exe FIFCOM C:\FIFCOM\           ^|  ����ļ������ļ����Զ�������ʾ�������
echo       %~n0 example.exe FIFCOM def y                ^|  ����ļ����Զ����������������
echo.
%windir%\System32\cmd.exe