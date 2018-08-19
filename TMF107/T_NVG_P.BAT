echo off
cls

echo unofficial Tornado NVG patch
echo for Tornado Versions 1.0c - 1.0e 
echo --
echo --

if not exist FLIGHT\FLIGHT_.exe     goto error
if not exist pal.seg      goto error
if not exist pal.new      goto error
if not exist t_patch.exe     goto error
rem if not exist t_NVG_.doc  goto error

if exist FLIGHT_.EXE goto no_bu_f

echo Copying FLIGHT_.EXE as a backup
copy FLIGHT\FLIGHT_.EXE flight_.exe > NUL

:no_bu_f

echo Erasing READ-ONLY attribute of  FLIGHT\FLIGHT_.EXE
attrib -R flight\flight_.exe

echo Calling patching program

t_patch pal.seg flight\flight_.exe 16 flight\flight_.exe pal.new NVG10

if errorlevel 1 goto miscerr1
copy nvg_.ini nvg.ini

:DS
if not exist flight\desert_.exe goto end
if exist DESERT_.EXE goto no_bu_fds

echo Copying DESERT_.EXE as a backup
copy FLIGHT\DESERT_.EXE desert_.exe > NUL

:no_bu_fds


echo Erasing READ-ONLY attribute of  FLIGHT\DESERT_.EXE
attrib -R flight\desert_.exe

echo Calling patching program

t_patch pal.seg flight\desert_.exe 16 flight\desert_.exe pal.new NVGDS10

if errorlevel 1 goto miscerror



goto end





:miscerror
echo error!
echo The patch failed. Please check you have european version 1.0c,1.0d
echo or 1.0e of Tornado properly installed.
echo Probably you have already patched your copy of Tornado.

goto end


:miscerr1
echo error!
echo The patch failed. Please check you have european version 1.0c,1.0d
echo or 1.0e of Tornado properly installed.
echo Probably you have already patched your copy of Tornado.
goto DS

:cerror
echo Error copying file! Make sure you have at least 3MB free disk space
echo on this drive.

goto end

:error
echo ERROR!!!!!!
echo This patch must be copied to the Tornado directory.
echo The following files have to be present to run this patch
echo T_patch.exe          ; patching program
echo pal.seg              ; copy of Tornado's orig. palette function 
echo pal.new              ; replacement
REM echo tmoralep.doc         ; documentation file
REM echo AMP\AMP.EXE          ; Tornado's mission planning program

:end 
echo !!!!!!!!!!!IMPORTANT NOTE:!!!!!!!!!!!!!!!!!!!!!!
echo LOAD TSG.EXE EVERYTIME BEFORE LOADING TORNADO 
ECHO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

