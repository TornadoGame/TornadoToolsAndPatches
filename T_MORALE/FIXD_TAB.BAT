@echo off

echo y > tmp.$$$
echo b >> tmp.$$$ 

tpatcher tmoralep.ini < tmp.$$$

del tmp.$$$

