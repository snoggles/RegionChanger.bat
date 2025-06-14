@ECHO OFF
TITLE Region Changer from DreaMaN
MODE con: cols=33 lines=26
SET Regions=us-east-1 us-east-2 us-west-1 us-west-2 eu-central-1 eu-west-1 eu-west-2 sa-east-1 ap-south-1 ap-northeast-2 ap-southeast-1 ap-southeast-2 ap-northeast-1 ap-east-1 ca-central-1
REM OLD: gamelift.us-east-1.amazonaws.com gamelift.us-east-2.amazonaws.com gamelift.us-west-1.amazonaws.com gamelift.us-west-2.amazonaws.com gamelift.eu-central-1.amazonaws.com gamelift.eu-west-1.amazonaws.com gamelift.eu-west-2.amazonaws.com gamelift.sa-east-1.amazonaws.com gamelift.ap-south-1.amazonaws.com gamelift.ap-northeast-2.amazonaws.com gamelift.ap-southeast-1.amazonaws.com gamelift.ap-southeast-2.amazonaws.com gamelift.ap-northeast-1.amazonaws.com gamelift.ap-east-1.amazonaws.com gamelift.ca-central-1.amazonaws.com
SET f=%WinDir%\System32\Drivers\etc
ECHO F | XCOPY "%f%\hosts" "%f%\hosts_region_changer_backup" /y /r /f /d

:Start
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "tokens=1,2 delims=#" %%a IN ('"PROMPT #$H#$E# & ECHO ON & FOR %%b in (1) DO REM"') DO (SET "DEL=%%a")
CLS
ECHO �������������������������������ͻ
ECHO | SET /p="�   "
CALL :Text 09 "Choose Your Region Please"
ECHO    �
ECHO �������������������������������͹
ECHO | SET /p="�  "
CALL :Text 0a "0 - Set Default"
ECHO               �
ECHO �������������������������������Ķ
ECHO �  1 - Northern Virginia        �
ECHO �  2 - Ohio                     �
ECHO �  3 - Northern California      �
ECHO �  4 - Oregon                   �
ECHO | SET /p="�  "
CALL :Text 0d "5 - Frankfurt (EU,RU,CIS)"
ECHO     �
ECHO �  6 - Ireland                  �
ECHO �  7 - London                   �
ECHO �  8 - South America            �
ECHO �  9 - Asia Pacific (Mumbai)    �
ECHO � 10 - Asia Pacific (Seoul)     �
ECHO � 11 - Asia Pacific (Singapore) �
ECHO � 12 - Asia Pacific (Sydney)    �
ECHO � 13 - Asia Pacific (Tokyo)     �
ECHO � 14 - Asia Pacific (Hong Kong) �
ECHO � 15 - Canada                   �
ECHO �������������������������������Ķ
ECHO | SET /p="� "
CALL :Text 0c " e - Exit"
ECHO                      �
ECHO �������������������������������ͼ
REM 
SETLOCAL DISABLEDELAYEDEXPANSION

SET /p n="�> Enter the Number or e: "
SET /a p=0

SET t=0
FOR %%i IN (e E � � 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) DO (IF /i %n% == %%i SET t=1)
IF %t% == 0 (
	ECHO.
	CALL :Text 4f "Wrong Number! Try Again!"
	TIMEOUT 2 >nul
	GOTO Start
)

FOR %%i IN (e E � �) DO (IF /i %n% == %%i (
	ECHO.
	CALL :Text 0c " e - Ok. Exit"
	TIMEOUT 2 >nul
	EXIT
	)
)

IF %n% == 0 (
	TYPE "%f%\hosts" | findstr /i /v "gamelift" > "%f%\hosts_temp"
	DEL /q "%f%\hosts"
	RENAME "%f%\hosts_temp" "hosts"
	ECHO.
	CALL :Text 0a " 0 - Ok. Server Deleted"
	TIMEOUT 3 >nul
	EXIT
)

SETLOCAL ENABLEDELAYEDEXPANSION
SET /a c=1
TYPE "!f!\hosts" | FINDSTR /i /v "gamelift" > "!f!\hosts_temp"
DEL /q "!f!\hosts"
RENAME "!f!\hosts_temp" "hosts"
FOR %%i in (%Regions%) DO (
	IF !c! NEQ !n! (ECHO 0.0.0.0 	gamelift-ping.%%i.api.aws>> !f!\hosts)
	set /a c=!c!+1
)
SETLOCAL DISABLEDELAYEDEXPANSION && ENDLOCAL
ECHO.
ECHO | SET /p="%n% - Ok. "
CALL :Text 1f "Server Setted"
TIMEOUT 3 >nul

GOTO :EOF

:Text
<nul SET /p ".=%DEL%" > "%~2"
FINDSTR /v /a:%1 /r "^$" "%~2" nul
DEL "%~2" > nul 2>&1
GOTO :EOF