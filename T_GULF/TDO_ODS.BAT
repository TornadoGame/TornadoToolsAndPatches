@echo off

REM TORNADO BATCH FILE (FOR ODS GAMEPLAY ONLY)
REM
REM

REM You can add any TSR's / tools etc. here, e.g.
REM LH TSG /c             
REM or 
REM LH TKM_ID
REM  

echo Loading Tornado (ODS Gameplay Version) ...
cd amp
loadhigh ampODS %1
cd ..

