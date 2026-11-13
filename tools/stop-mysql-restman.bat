@echo off
rem Tat MySQL rieng cua RestMan (cong 3307)
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqladmin.exe" --user=root --password=123456 --host=127.0.0.1 --port=3307 shutdown
echo Da tat MySQL RestMan.
timeout /t 3 >nul
