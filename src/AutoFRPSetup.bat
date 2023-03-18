echo off
set version=v1.0

rem
title FRPC �ֳt�]�w�p�u��
mode con cols=85 lines=30
cd %~dp0

echo:
echo           =================================================================
echo           =                                                               =
echo           =                        FRPC �ֳt�]�w�p�u��                    =
echo           =                                                               =
echo           =                          ����: %version%                           =
echo           =                                                               =
echo           =                      �@��: redbean0721                        =
echo           =    Github: https://github.com/redbean0721/AutoFRPSetup        =
echo           =                                                               =
echo           =                                                               =
echo           =                                                               =
echo           =                       ���U Enter �~��                         =
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
    echo                            ����Ƨ����٦���L�ɮשθ�Ƨ�
    echo:
    echo:
    echo                       �бN���]�w�u���m�󰮲b����Ƨ����í���
    echo:
    echo:
    echo:
    pause
    @REM exit
)

cls
echo:
echo:
echo                                  ���b�U�� FRPC ��...
echo:
curl -O -L https://github.com/fatedier/frp/releases/download/v0.48.0/frp_0.48.0_windows_386.zip
echo:
echo:
echo                                      �U������
echo:
pause

cls
echo:
echo:
echo                                      �����Y��...
echo:
echo:
tar.exe -xf frp_0.48.0_windows_386.zip
echo                                     �����Y����!!
pause

move frp_0.48.0_windows_386\frpc.exe .
rmdir /s /q frp_0.48.0_windows_386
rm frp_0.48.0_windows_386.zip

:test
cls
echo:
echo:
echo                                       �ѼƳ]�w
echo:
echo:
set /p frps_ip=�п�J���A����m(�Ь��ߦ��A����): 
echo:
set /p frps_port=�п�J���A��port(�Ь��ߦ��A����): 
echo:
set /p username=�п�J�b��: 
echo:
set /p userpassword=�п�J�K�X: 
echo:
set /p protypename=�п�J�G�D�W��(�ۭq): 
echo:
set /p protype=�п�J�G�D����(tcp/udp) (Minecraft Java�ϥ�tcp, Minecraft PE�ϥ�udp): 
echo:
set /p proport=�п饻�a�ݤf(Minecraft Java�w�]25565, Minecraft PE�w�]19132): 
echo:
set /p promoteport=�п黷�{�ݤf(�Ь��ߦ��A����): 

cls
echo:
echo:
echo                                  ���b�ͦ� frpc.ini ��...
echo:
echo:
( echo [common] & echo server_addr = %frps_ip% & echo server_port = %frps_port% & echo user = %username% & echo meta_token = %userpassword% & echo: & echo [%protypename%] & echo type = %protype% & echo local_ip = 127.0.0.1 & echo local_port = %proport% & echo remote_port = %promoteport% & echo protocol = kcp & echo bandwidth_limit = 250KB ) > frpc.ini
echo                                    frpc.ini �ͦ�����
echo:
ping 127.0.0.1 -n 2 > nul
goto spawn_start

:spawn_start
set spawn=
set /p spawn=�O�_�ͦ��Ұʤ��? [y/n]: 
if "%spawn%" == "y" ( echo frpc.exe > start.bat & echo                                         �ͦ����� & ping 127.0.0.1 -n 1 > nul & goto start )
if "%spawn%" == "n" ( goto start )
cls
echo:
echo                                    �п�J���T����
echo:
goto spawn_start

:start
echo:
set start=
set /p spawn=�O�_�Ұ�frpc? [y/n]: 
if "%spawn%" == "y" ( frpc.exe & goto finish )
if "%spawn%" == "n" ( goto finish )
cls
echo:
echo                                    �п�J���T����
echo:
goto start

:finish
cls
echo:
echo:
echo:
echo                                     �P�±z���ϥ�
echo:
echo:
echo:
timeout /t 2
pause
exit