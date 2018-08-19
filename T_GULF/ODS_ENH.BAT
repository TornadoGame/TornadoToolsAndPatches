@echo off

if NOT exist TPATCHER.EXE goto tperror

if exist amp\ampods.exe goto nocopy

echo Copying file AMP\AMP.EXE to file AMP\AMPODS.EXE

copy amp\amp.exe amp\ampods.exe

:nocopy

Tpatcher ods_p0.ini
Tpatcher ods_p1.ini
Tpatcher ods_p2.ini
Tpatcher ods_p3.ini
Tpatcher ods_p4.ini

goto end

:tperror
echo This patch requires the TPATCHER.EXE generic patching program


:end

