@echo off
rem Bat MySQL rieng cho RestMan (cong 3307, root/123456) - khong dung toi MySQL80
start "" /B "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" --defaults-file="%LOCALAPPDATA%\Programs\RestMan-MySQL\my.ini"
echo Da bat MySQL RestMan o cong 3307.
timeout /t 3 >nul
