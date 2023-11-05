@echo off
chcp 65001
cls
title Sudo-Installer für Windows






2>NUL mkdir "%windir%\BatchGotAdmin"
if '%errorlevel%' == '0' (
  rmdir "%windir%\BatchGotAdmin" & goto gotAdmin 
) else ( goto UACPrompt )

:UACPrompt



    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute %0, "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"      
    CD /D "%~dp0"


set farbenwahl=
set green=%farbenwahl%[32m
set rot=%farbenwahl%[31m
set gelb=%farbenwahl%[33m
set blau=%farbenwahl%[36m
set Weiss=%farbenwahl%[37m






echo %blau%Dieses Tool bringt das "sudo"-Kommando, das man von Linux kennt, in Windows
echo Es genügt nach der Installation, in der cmd.exe-Umgebung den Befehl sudo einzugeben.
echo Dahinter schreiben Sie als Parameter einen Befehl oder den Namen des auszuführenden Programnms.
echo %gelb%Die Applikation bzw. der Vorgang startet sodann mit Admin-Rechten.
echo Hierfür ist es erforderlich, einen UAC-Prompt, wie es ihn seit Vista gibt, zu bestätigen.





SETLOCAL EnableDelayedExpansion

SET $Echo=FOR %%I IN (1 2) DO IF %%I==2 (SETLOCAL EnableDelayedExpansion ^& FOR %%A IN (^^^!Text:""^^^^^=^^^^^"^^^!) DO ENDLOCAL ^& ENDLOCAL ^& ECHO %%~A) ELSE SETLOCAL DisableDelayedExpansion ^& SET Text=
SETLOCAL DisableDelayedExpansion


echo.
echo.
echo.
echo.
echo.


echo %green%
%$Echo% "  / ____|         | |        / _(_) (_)        
%$Echo% " | (___  _   _  __| | ___   | |_ _   _ _ __    
%$Echo% "  \___ \| | | |/ _` |/ _ \  |  _| | | | '__|   
%$Echo% "  ____) | |_| | (_| | (_) | | | | |_| | |      
%$Echo% " |_____/ \__,_|\__,_|\___/ _|_|  \__,_|_|      
%$Echo% " \ \        / (_)         | |                  
%$Echo% "  \ \  /\  / / _ _ __   __| | _____      _____ 
%$Echo% "   \ \/  \/ / | | '_ \ / _` |/ _ \ \ /\ / / __|
%$Echo% "    \  /\  /  | | | | | (_| | (_) \ V  V /\__ \
%$Echo% "     \/  \/   |_|_| |_|\__,_|\___/ \_/\_/ |___/















echo.






if exist %systemdrive%\windows\system32\sudo.cmd goto uninstall
if not exist %systemdrive%\windows\system32\sudo.cmd goto install






:install

echo.
echo.
echo %blau%--- --- --- INFO --- --- ---
echo %rot%Das Tool wurde noch nicht installiert.



>%temp%\test.vbs (
  echo WScript.Quit _
  echo    MsgBox("Der Linux-Systembefehl sudo wurde in Windows noch nicht installiert." ^& vbCrLf ^& "" ^& vbCrLf ^& "%Wollen Sie dies nun nachholen?", _
  echo    vbOKCancel Or vbDefaultButton2 Or vbExclamation, _
  echo    "Windows-Sudo-Installer"^)
)
wscript %temp%\test.vbs
goto %errorlevel%






:1
del %temp%\test.vbs


echo @echo off>%systemroot%\system32\sudo.cmd
echo if "%%~1"=="" ^(>>%systemroot%\system32\sudo.cmd



echo echo FEHLER: Geben Sie bitte einen Befehl als Parameter von "sudo" ein.>>%systemroot%\system32\sudo.cmd
echo echo Leer-Eingaben werden nicht akzeptiert.>>%systemroot%\system32\sudo.cmd
echo exit ^/b>>%systemroot%\system32\sudo.cmd



echo )>>%systemroot%\system32\sudo.cmd


echo if ^/i "%%~1"=="cmd" ^(>>%systemroot%\system32\sudo.cmd



echo goto CMD-Behandlung>>%systemroot%\system32\sudo.cmd


echo )>>%systemroot%\system32\sudo.cmd


echo if ^/i "%%~1"=="cmd.exe" ^(>>%systemroot%\system32\sudo.cmd


echo goto CMD-Behandlung>>%systemroot%\system32\sudo.cmd
echo )>>%systemroot%\system32\sudo.cmd




echo if /i "%%~1"=="conhost" ^(>>%systemroot%\system32\sudo.cmd



echo goto CMD-Behandlung>>%systemroot%\system32\sudo.cmd
echo )>>%systemroot%\system32\sudo.cmd
echo if /i "%%~1"=="conhost.exe" (>>%systemroot%\system32\sudo.cmd
echo goto CMD-Behandlung>>%systemroot%\system32\sudo.cmd
echo )>>%systemroot%\system32\sudo.cmd
echo.>>%systemroot%\system32\sudo.cmd
echo.>>%systemroot%\system32\sudo.cmd
echo.>>%systemroot%\system32\sudo.cmd





echo if /i "%%~1"=="wt" (>>%systemroot%\system32\sudo.cmd


echo goto CMD-Behandlung>>%systemroot%\system32\sudo.cmd
echo )>>%systemroot%\system32\sudo.cmd
echo if /i "%%~1"=="wt.exe" (>>%systemroot%\system32\sudo.cmd
echo goto CMD-Behandlung>>%systemroot%\system32\sudo.cmd
echo )>>%systemroot%\system32\sudo.cmd
echo if /i "%%~1"=="powershell" (>>%systemroot%\system32\sudo.cmd
echo goto PowerShell-Behandlung>>%systemroot%\system32\sudo.cmd
echo )>>%systemroot%\system32\sudo.cmd
echo if /i "%%~1"=="powershell.exe" (>>%systemroot%\system32\sudo.cmd
echo goto PowerShell-Behandlung>>%systemroot%\system32\sudo.cmd
echo )>>%systemroot%\system32\sudo.cmd
echo powershell Start-Process -FilePath "%%1" -Verb RunAs>>%systemroot%\system32\sudo.cmd




echo goto :EOF>>%systemroot%\system32\sudo.cmd
echo :CMD-Behandlung>>%systemroot%\system32\sudo.cmd



echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" ^/v Autorun ^/t REG_SZ ^/d "%%userprofile%%\documents\CMD-Autostart.cmd" ^/f ^> NUL>>%systemroot%\system32\sudo.cmd




echo echo @echo off ^> "%%userprofile%%\documents\CMD-Autostart.cmd">>%systemroot%\system32\sudo.cmd
echo echo cd ^/d %%CD%% ^>^> "%%userprofile%%\documents\CMD-Autostart.cmd">>%systemroot%\system32\sudo.cmd

echo echo reg delete "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" ^/v Autorun ^/f ^>^> "%%userprofile%%\documents\CMD-Autostart.cmd">>%systemroot%\system32\sudo.cmd
echo echo cls ^>^> "%%userprofile%%\documents\CMD-Autostart.cmd">>%systemroot%\system32\sudo.cmd
echo powershell -command "Start-Process -FilePath 'C:\windows\system32\cmd.exe' -ArgumentList '/K color 4e' -Verb RunAs">>%systemroot%\system32\sudo.cmd




echo goto :EOF>>%systemroot%\system32\sudo.cmd
echo :PowerShell-Behandlung>>%systemroot%\system32\sudo.cmd
echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" ^/v Autorun ^/t REG_SZ ^/d "%%userprofile%%\documents\CMD-Autostart.cmd" ^/f ^> NUL>>%systemroot%\system32\sudo.cmd
echo echo @echo off ^> "%%userprofile%%\documents\CMD-Autostart.cmd">>%systemroot%\system32\sudo.cmd




echo echo cd /d %%CD%% ^>^> "%%userprofile%%\documents\CMD-Autostart.cmd">>%systemroot%\system32\sudo.cmd
echo echo reg delete "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" ^/v Autorun /f ^>^> "%%userprofile%%\documents\CMD-Autostart.cmd">>%systemroot%\system32\sudo.cmd
echo echo cls ^>^> "%%userprofile%%\documents\CMD-Autostart.cmd">>%systemroot%\system32\sudo.cmd
echo powershell -command "Start-Process -FilePath 'C:\windows\system32\cmd.exe' -ArgumentList '/K powershell' -Verb RunAs">>%systemroot%\system32\sudo.cmd
echo goto :EOF>>%systemroot%\system32\sudo.cmd
























cls

echo %blau%Dieses Tool bringt das "sudo"-Kommando, das man von Linux kennt, in Windows
echo Es genügt nach der Installation, in der cmd.exe-Umgebung den Befehl sudo einzugeben.
echo Dahinter schreiben Sie als Parameter einen Befehl oder den Namen des auszuführenden Programnms.
echo %gelb%Die Applikation bzw. der Vorgang startet sodann mit Admin-Rechten.
echo Hierfür ist es erforderlich, einen UAC-Prompt, wie es ihn seit Vista gibt, zu bestätigen.

echo.
echo.
echo.
echo.
echo.




echo %green%
%$Echo% "  / ____|         | |        / _(_) (_)        
%$Echo% " | (___  _   _  __| | ___   | |_ _   _ _ __    
%$Echo% "  \___ \| | | |/ _` |/ _ \  |  _| | | | '__|   
%$Echo% "  ____) | |_| | (_| | (_) | | | | |_| | |      
%$Echo% " |_____/ \__,_|\__,_|\___/ _|_|  \__,_|_|      
%$Echo% " \ \        / (_)         | |                  
%$Echo% "  \ \  /\  / / _ _ __   __| | _____      _____ 
%$Echo% "   \ \/  \/ / | | '_ \ / _` |/ _ \ \ /\ / / __|
%$Echo% "    \  /\  /  | | | | | (_| | (_) \ V  V /\__ \
%$Echo% "     \/  \/   |_|_| |_|\__,_|\___/ \_/\_/ |___/


echo.
echo.
echo.

echo %blau%--- --- --- INFO --- --- ---
echo %green%Das Tool wurde %rot%jetzt %gelb%fertig %green%installiert.
timeout /t 1 >NUL
echo %blau%SIE KÖNNEN DIESES PROGRAMM NUN PER KLICK AUF "OK" BEENDEN.




echo MSGBOX "Installation vollzogen." > %temp%\popup.vbs
call %temp%\popup.vbs
del %temp%\popup.vbs
exit


:2
del %temp%\test.vbs
exit



:uninstall


>%temp%\meldung.vbs (
  echo WScript.Quit _
  echo    MsgBox("Der Linux-Systembefehl sudo wurde in Windows bereits installiert." ^& vbCrLf ^& "" ^& vbCrLf ^& "%Wollen Sie ihn deinstallieren?", _
  echo    vbOKCancel Or vbDefaultButton2 Or vbExclamation, _
  echo    "Windows-Sudo-Uninstaller"^)
)
wscript %temp%\meldung.vbs
goto %errorlevel%


:1
del %temp%\meldung.vbs
del %systemroot%\system32\sudo.cmd


echo MSGBOX "Deinstallation vollzogen." > %temp%\popup.vbs
call %temp%\popup.vbs
del %temp%\popup.vbs
exit



:2
del %temp%\test.vbs
exit




















