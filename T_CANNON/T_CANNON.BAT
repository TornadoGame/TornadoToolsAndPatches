@echo off
echo ===========TORNADO SB16 CANNON PATCH======================
echo =          (c) 1995 TCSC Associates                      =
echo ==========================================================

if not exist tpatcher.exe goto error_tp

tpatcher T_CANNON.INI

goto end

:error_tp
echo ERROR!!!!!!!!!!!!!!!!!
echo This patch requires the program TPATCHER.EXE


:end


