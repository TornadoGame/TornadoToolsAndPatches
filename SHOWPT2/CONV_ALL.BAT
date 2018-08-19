
mkdir c:\tmp_pt2

if not exist digipics\*.* goto error 

cd digipics

for %%f in (*.pt2) do showpt2 %%f c:\tmp_pt2\%%f %1 %2 %3 %4

ren C:\tmp_pt2\*.pt2 *.bmp

cd ..

goto end

:error
echo off

echo ! 
echo ERROR: conv_all.bat must be run in the Tornado directory
echo ! 
:end
