echo off
cls

echo unofficial Tornado morale table patch
echo for Tornado Versions 1.0c - 1.0e 
echo --
echo --

if not exist AMP\AMP.exe     goto error
if not exist tpatcher.exe    goto error
if not exist tmoralep.doc    goto error


echo Erasing READ-ONLY attribute of AMP\AMP.EXE
attrib -R amp\amp.exe


tpatcher  tmoralep.ini



goto end





:miscerror
echo error!
echo The patch failed. Please check you have version 1.0c,1.0d
echo or 1.0e of Tornado properly installed on a hard disk.
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
echo tpatcher.exe         ; patching program
echo tmoralep.doc         ; documentation file
echo AMP\AMP.EXE          ; Tornado's mission planning program

:end 


