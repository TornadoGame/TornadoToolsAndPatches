@echo off
echo ===========TORNADO SB DETECTION PATCH FOR FAST MACHINES==========
echo = (c) 1995 TCSC Associates                                      =
echo =================================================================

if not exist tpatcher.exe goto error_tp

tpatcher sb_dtct.INI

goto end

:error_tp
echo ERROR!!!!!!!!!!!!!!!!!
echo This patch requires the program TPATCHER.EXE


:end


