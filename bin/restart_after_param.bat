@echo off
setlocal

rem ##
rem ## join_logo_scp����m�F�p�o�b�`�t�@�C���̎蓮�C����ĊJ�p
rem ## �t�@�C��������擾�����p�����[�^����C��������̍ĊJ
rem ##

rem ## �P�K�w��̃t�H���_�擾
set TMPPATH=%~dp0
for /F "usebackq delims=" %%I IN (`echo "%TMPPATH:~0,-1%"`) do set TMPPATH=%%~dpI

set RESTART_AFTER_PARAM=1
call "%TMPPATH%jlse_bat.bat" "%~1"

endlocal
exit /b
