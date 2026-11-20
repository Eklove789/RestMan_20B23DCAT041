@echo off
rem Reset CSDL restman1 ve du lieu mau ban dau de demo lai (MySQL rieng cua RestMan, cong 3307)
rem Chay lai database\restman1.sql: xoa 28 bang, tao lai va nap du lieu mau theo kich ban.
set "MYSQLBIN=C:\Program Files\MySQL\MySQL Server 8.0\bin"
set "SQL=%~dp0..\database\restman1.sql"

"%MYSQLBIN%\mysqladmin.exe" --user=root --password=123456 --host=127.0.0.1 --port=3307 ping >nul 2>&1
if errorlevel 1 (
    echo MySQL RestMan chua bat, dang bat...
    call "%~dp0start-mysql-restman.bat"
)

echo Dang nap lai du lieu tu %SQL% ...
"%MYSQLBIN%\mysql.exe" --user=root --password=123456 --host=127.0.0.1 --port=3307 --default-character-set=utf8mb4 < "%SQL%"
if errorlevel 1 (
    echo LOI: khong nap duoc du lieu. Kiem tra MySQL o cong 3307.
) else (
    echo Da reset CSDL restman1 ve du lieu mau.
    echo Mo lai http://localhost:8080/RestMan1/ trong cua so an danh moi de demo lai.
)
pause
