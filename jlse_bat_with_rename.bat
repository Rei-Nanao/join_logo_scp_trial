@echo off

rem ## join_logo_scp����m�F�p�o�b�`�t�@�C��
rem ##
rem ## �s���̈����t�@�C�����́iTS�t�@�C�����̂݁j�����I�Ƀ��l�[�����Ď��s����
rem ## �i���̃t�@�C������"�V�t�@�C����.title_bak.txt"���ɋL�ڂ��ďo�͂���j
rem ##
rem ## ���́F
rem ##  %1     : AVS�t�@�C�����܂���TS�t�@�C����
rem ## �o�́F
rem ## tsfullname : ���l�[��������̃t�@�C����

rem ##------------------------------------------------
rem ## �����ݒ�
rem ##------------------------------------------------
set BASEDIR=%~dp0
set BINDIR=%BASEDIR%bin\

if "%~1" == "" goto end_rename

:start_rename
rem ##------------------------------------------------
rem ## �s���̈����t�@�C������rename�����A���̖��O���t�@�C���ɕۑ�
rem ##------------------------------------------------
rem ##
rem ## TS�t�@�C�����̂ݎ��s
rem ##
set "tsfullname=%~1"
if not "%~x1" == ".ts" goto skip_rename

rem ##
rem ## ���ꕶ�����������āAShift-JIS�Ƀt�@�C������ϊ�
rem ##
for /F "usebackq delims=" %%I IN (`cscript //nologo "%BINDIR%func_echo.vbs" "%~n1"`) do set tsname_new=%%~I
set "tsname_new=%tsname_new:?=%"
set "tsfullname=%~dp1%tsname_new%%~x1"

rem ##
rem ## ���O�ύX�Ȃ���Ώȗ�
rem ##
if "%tsname_new%" == "%~n1" goto skip_rename

rem ##
rem ## �t�@�C�����ύX
rem ##
move /Y "%~1" "%tsfullname%"

rem ##
rem ## ���t�@�C������ۑ�
rem ##
cscript //nologo "%BINDIR%func_write_unicode.vbs" "%~dp1%tsname_new%.title_bak.txt" "%~n1"

:skip_rename

rem ##------------------------------------------------
rem ## �o�b�`�t�@�C���{�̎��s
rem ##------------------------------------------------
rem ##--- ���s ---
call "%BASEDIR%jlse_bat.bat" "%tsfullname%"

rem ##
rem ## �J��Ԃ�����
rem ##
shift
if not "%~1" == "" goto start_rename

:end_rename
exit /b
