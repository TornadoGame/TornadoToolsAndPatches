echo off
cls

echo unofficial Tornado TMX patch reversal
echo for Tornado Version 1.0c only
echo not required for versions 1.0d -  1.0e
echo --

if not exist amp\amp.exe    goto error
if not exist dxc.old      goto error
if not exist dxc.new      goto error
if not exist t_patch.exe     goto error

if exist amp.exe goto no_bu_f

echo Copying AMP.EXE as a backup
copy AMP\AMP.EXE amp.exe > NUL

:no_bu_f

echo Erasing READ-ONLY attribute of  AMP\AMP.exe
attrib -R amp\amp.exe

echo Calling patching program

t_patch dxc.new amp\amp.exe 304 amp\amp.exe dxc.old TMX10R

if errorlevel 1 goto miscerr1

goto end


:miscerror
:miscerr1
echo error!
echo The patch failed. Please check you have version 1.0c
echo of Tornado properly installed.
echo Probably you have already patched your copy of Tornado.

goto end



:cerror
echo Error copying file! Make sure you have at least 3MB free disk space
echo on this drive.

goto end

:error
echo ERROR!!!!!!
echo This patch must be copied to the Tornado directory.
echo The following files have to be present to run this patch
echo T_patch.exe          ; patching program
echo dxc.old              ; copy of Tornado's orig. data 
echo dxc.new              ; replacement
echo AMP\AMP.EXE          ; Tornado's mission planning program

:end 

