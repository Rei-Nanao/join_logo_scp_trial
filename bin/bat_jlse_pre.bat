@echo off

rem ## join_logo_scp����m�F�p�o�b�`�t�@�C�� - �O�������s
rem ## �t�@�C����������s�ɕK�v�ȏ����擾���A���ϐ��ɐݒ肷��
rem ## ���́F
rem ##  %1     : avs�t�@�C�����܂���ts�t�@�C����
rem ##
rem ## ���ϐ��i���́j�F
rem ##  BINDIR    : ���s�t�@�C���t�H���_
rem ##  SETDIR    : �ݒ���̓t�H���_
rem ##  LG_DIR    : ���S�f�[�^�t�H���_
rem ##  RESTART_AFTER_PARAM : 1�̎��t�@�C��������擾�̃p�����[�^��C����̍ĊJ
rem ##
rem ## ���ϐ��i�o�́j�F
rem ##  LOGO_NAME    : �����ǖ��i�F���p�j
rem ##  LOGO_INST    : �����ǖ��i�ݒ�p�j
rem ##  LOGO_ABBR    : �����Ǘ���
rem ##  LOGO_PATH    : ���S�f�[�^�����p�X���i���o�́j
rem ##  LOGOSUB_PATH : CM�Ƃ͖��֌W�̃��S�f�[�^�����p�X��
rem ##  ���̑�setting�t�@�C���ɂ��ݒ�
rem ##

rem ##------------------------------------------------
rem ## �����ݒ�i�ʂ̏��ł܂Ƃ߂Đݒ�j
rem ##------------------------------------------------
rem ##--- ���̓f�[�^ ---
rem set file_csv_chlist=ChList.csv
rem set file_csv_param1=JLparam_set1.csv
rem set file_csv_param2=JLparam_set2.csv

rem ##--- �p�����[�^�ݒ�p�i�V�K�쐬�t�@�C���j ---
rem set file_bat_param=obs_param.bat

rem ##------------------------------------------------
rem ## �蓮�C�����p�̏ȗ�����
rem ## ���ϐ� RESTART_AFTER_PARAM=1 �����O�ݒ莞�̓J�b�g�ʒu���o�܂ŏȗ�
rem ## �p�����[�^�ݒ���蓮�C�����čĊJ����p�r��z��
rem ##------------------------------------------------
if "%RESTART_AFTER_PARAM%" == "1" (
  echo RESTART_AFTER_PARAM=1���ݒ肳��Ă��邽�߁A�p�����[�^���o�͏ȗ����܂�
  goto label_setparam
)

rem ##------------------------------------------------
rem ## �����ǖ��E���̂̎擾
rem ##------------------------------------------------
rem ##--- �t�@�C������������Ǐ����擾 ---
set LOGO_NAME=
set LOGO_INST=
set LOGO_ABBR=
for /F "usebackq delims=" %%I IN (`cscript //nologo "%BINDIR%func_get_chname.vbs" 1 "%SETDIR%%file_csv_chlist%" "%~n1"`) do set LOGO_NAME=%%~I
for /F "usebackq delims=" %%I IN (`cscript //nologo "%BINDIR%func_get_chname.vbs" 2 "%SETDIR%%file_csv_chlist%" "%~n1"`) do set LOGO_INST=%%~I
for /F "usebackq delims=" %%I IN (`cscript //nologo "%BINDIR%func_get_chname.vbs" 3 "%SETDIR%%file_csv_chlist%" "%~n1"`) do set LOGO_ABBR=%%~I

rem ##--- ������Ȃ����͒��O�t�H���_���Ō��� ---
set TITLE2ND=
if not "%LOGO_ABBR%" == "" goto skip_chname
set TITLE2ND=%~dp1
if "%TITLE2ND%" == "" goto skip_chname
for /F "usebackq delims=" %%I IN (`echo "%TITLE2ND:~0,-1%"`) do set TITLE2ND=%%~nI
if "%TITLE2ND%" == "" goto skip_chname
for /F "usebackq delims=" %%I IN (`cscript //nologo "%BINDIR%func_get_chname.vbs" 1 "%SETDIR%%file_csv_chlist%" "%TITLE2ND%"`) do set LOGO_NAME=%%~I
for /F "usebackq delims=" %%I IN (`cscript //nologo "%BINDIR%func_get_chname.vbs" 2 "%SETDIR%%file_csv_chlist%" "%TITLE2ND%"`) do set LOGO_INST=%%~I
for /F "usebackq delims=" %%I IN (`cscript //nologo "%BINDIR%func_get_chname.vbs" 3 "%SETDIR%%file_csv_chlist%" "%TITLE2ND%"`) do set LOGO_ABBR=%%~I
set TITLE2ND= %TITLE2ND%
:skip_chname

rem ##--- ���S�擾�����p�����[�^�t�@�C���ɏ����o�� ---
>  "%file_bat_param%" echo rem ## �����ǔF��
>> "%file_bat_param%" echo set LOGO_NAME=%LOGO_NAME%
>> "%file_bat_param%" echo set LOGO_INST=%LOGO_INST%
>> "%file_bat_param%" echo set LOGO_ABBR=%LOGO_ABBR%
>> "%file_bat_param%" echo.

rem ##------------------------------------------------
rem ## CM�J�b�g���s�p�p�����[�^�̎擾�E�ݒ�
rem ##------------------------------------------------
rem ##--- �p�����[�^�����擾 ---
cscript //nologo "%BINDIR%func_jls_params.vbs" "%SETDIR%%file_csv_param1%" "%LOGO_ABBR%" "%~n1%TITLE2ND%" >> "%file_bat_param%"
cscript //nologo "%BINDIR%func_jls_params.vbs" "%SETDIR%%file_csv_param2%" "%LOGO_ABBR%" "%~n1%TITLE2ND%" >> "%file_bat_param%"

:label_setparam
rem ##--- �擾�����p�����[�^����ݒ� ---
call "%file_bat_param%"

rem ##------------------------------------------------
rem ## �p�����[�^��񂩂�ϐ��ݒ�
rem ##------------------------------------------------
rem ##--- CM�p���S���Ȃ��ꍇ ---
if "%JLOGO_NOLOGO%" == "1" set LOGO_PATH=

rem ##--- CM���o�Ƃ͊֌W�Ȃ����S������ꍇ ---
if not "%LOGOSUBHEAD%" == "" set LOGOSUB_PATH=%LG_DIR%%LOGOSUBHEAD%.lgd

rem ##--- ���o�����ǖ��̕\�� ---
if not "%LOGO_ABBR%" == "" echo "�����ǁF%LOGO_NAME%�i%LOGO_ABBR%�j"
if "%LOGO_ABBR%" == "" echo �����ǂ̓t�@�C�������猟�o�ł��܂���ł���


rem ##------------------------------------------------
rem ## ����
rem ##------------------------------------------------
exit /b
