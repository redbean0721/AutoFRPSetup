echo off
set version=v1.0

rem
title FRPC 快速設定小工具
mode con cols=85 lines=30
cd %~dp0

echo:
echo           =================================================================
echo           =                                                               =
echo           =                        FRPC 快速設定小工具                    =
echo           =                                                               =
echo           =                          版本: %version%                           =
echo           =                                                               =
echo           =                      作者: redbean0721                        =
echo           =    Github: https://github.com/redbean0721/AutoFRPSetup        =
echo           =                                                               =
echo           =                                                               =
echo           =                                                               =
echo           =                       按下 Enter 繼續                         =
echo           =                                                               =
echo           =================================================================
echo:
echo:
echo:
pause

cls
dir /b /a-d | findstr /v /c:"%~nx0" > nul && (
    echo:
    echo                                         ERROR
    echo:
    echo:
    echo                            此資料夾中還有其他檔案或資料夾
    echo:
    echo:
    echo                       請將此設定工具放置於乾淨的資料夾內並重試
    echo:
    echo:
    echo:
    pause
    @REM exit
)

cls
echo:
echo:
echo                                  正在下載 FRPC 中...
echo:
curl -O -L https://github.com/fatedier/frp/releases/download/v0.48.0/frp_0.48.0_windows_386.zip
echo:
echo:
echo                                      下載完成
echo:
pause

cls
echo:
echo:
echo                                      解壓縮中...
echo:
echo:
tar.exe -xf frp_0.48.0_windows_386.zip
echo                                     解壓縮完成!!
pause

move frp_0.48.0_windows_386\frpc.exe .
rmdir /s /q frp_0.48.0_windows_386
rm frp_0.48.0_windows_386.zip

:test
cls
echo:
echo:
echo                                       參數設定
echo:
echo:
set /p frps_ip=請輸入伺服器位置(請洽詢伺服器端): 
echo:
set /p frps_port=請輸入伺服器port(請洽詢伺服器端): 
echo:
set /p username=請輸入帳號: 
echo:
set /p userpassword=請輸入密碼: 
echo:
set /p protypename=請輸入隧道名稱(自訂): 
echo:
set /p protype=請輸入隧道類型(tcp/udp) (Minecraft Java使用tcp, Minecraft PE使用udp): 
echo:
set /p proport=請輸本地端口(Minecraft Java預設25565, Minecraft PE預設19132): 
echo:
set /p promoteport=請輸遠程端口(請洽詢伺服器端): 

cls
echo:
echo:
echo                                  正在生成 frpc.ini 中...
echo:
echo:
( echo [common] & echo server_addr = %frps_ip% & echo server_port = %frps_port% & echo user = %username% & echo meta_token = %userpassword% & echo: & echo [%protypename%] & echo type = %protype% & echo local_ip = 127.0.0.1 & echo local_port = %proport% & echo remote_port = %promoteport% & echo protocol = kcp & echo bandwidth_limit = 250KB ) > frpc.ini
echo                                    frpc.ini 生成完成
echo:
ping 127.0.0.1 -n 2 > nul
goto spawn_start

:spawn_start
set spawn=
set /p spawn=是否生成啟動文件? [y/n]: 
if "%spawn%" == "y" ( echo frpc.exe > start.bat & echo                                         生成完成 & ping 127.0.0.1 -n 1 > nul & goto start )
if "%spawn%" == "n" ( goto start )
cls
echo:
echo                                    請輸入正確的值
echo:
goto spawn_start

:start
echo:
set start=
set /p spawn=是否啟動frpc? [y/n]: 
if "%spawn%" == "y" ( frpc.exe & goto finish )
if "%spawn%" == "n" ( goto finish )
cls
echo:
echo                                    請輸入正確的值
echo:
goto start

:finish
cls
echo:
echo:
echo:
echo                                     感謝您的使用
echo:
echo:
echo:
timeout /t 2
pause
exit