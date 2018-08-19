@echo off

echo y > tmp.$$$
echo d >> tmp.$$$ 

tpatcher tmoralep.ini < tmp.$$$

del tmp.$$$

