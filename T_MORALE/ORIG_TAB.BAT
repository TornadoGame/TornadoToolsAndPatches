@echo off

echo y > tmp.$$$
echo a >> tmp.$$$ 

tpatcher tmoralep.ini < tmp.$$$

del tmp.$$$

