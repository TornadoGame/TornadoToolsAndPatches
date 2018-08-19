@echo off

echo y > tmp.$$$
echo c >> tmp.$$$ 

tpatcher tmoralep.ini < tmp.$$$

del tmp.$$$

