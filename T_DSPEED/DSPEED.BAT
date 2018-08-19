@echo off
echo ===========TORNADO Default Planning Speed Patch=============
echo =          (c) 1995 TCSC Associates                        =
echo ============================================================

if not exist tpatcher.exe goto error_tp

tpatcher dspeed.INI


goto end

:error_tp
echo ERROR!!!!!!!!!!!!!!!!!
echo This patch requires the program TPATCHER.EXE


:end



