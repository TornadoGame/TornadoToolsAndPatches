@echo off
echo ===========TORNADO Terrain Following Realism Patch=============
echo =          (c) 1995 TCSC Associates                           =
echo ===============================================================

if not exist tpatcher.exe goto error_tp

tpatcher RIDE.INI

REM TPATCHER RIDE2.INI

goto end

:error_tp
echo ERROR!!!!!!!!!!!!!!!!!
echo This patch requires the program TPATCHER.EXE


:end


