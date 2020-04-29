@echo off
setlocal

rem ## join_logo_scp����m�F�p�o�b�`�t�@�C��
rem ## ���́F
rem ##  %1     : AVS�t�@�C�����܂���TS�t�@�C����
rem ##
rem ## ���ϐ��i���́j�F
rem ##  RESTART_AFTER_TRIM  : 1�̎�CM�ʒu��C����̍ĊJ
rem ##  RESTART_AFTER_PARAM : 1�̎��t�@�C��������擾�̃p�����[�^��C����̍ĊJ

rem ##------------------------------------------------
rem ## �����ݒ�
rem ##------------------------------------------------
set BASEDIR=%~dp0
set FILESETUP=%BASEDIR%setting\bat_setup.bat

rem ##--- �ݒ�ǂݍ��� ---
call "%FILESETUP%" "%~1"

rem ##------------------------------------------------
rem ## ��Əꏊ�Ɉړ�
rem ##------------------------------------------------
rem ##--- avs���͂̏ꍇ��avs�ꏊ�ɏo�� ---
if not "%~x1" == ".avs" goto skip_avs_dir
set OUTDIR=%~dp1
set OUTNAME=
:skip_avs_dir

rem ##--- �g���q�m�F ---
if not "%~x1" == ".ts" if not "%~x1" == ".avs" goto err_in_name

rem ##--- �t�@�C�����݊m�F ---
if not exist "%~1" goto err_in_none

rem ##--- �o�̓t�H���_�m�F�E�ړ� ---
if not exist "%OUTDIR%" goto err_in_outdir
pushd "%OUTDIR%"
if "%OUTNAME%" == "" goto skip_newdir
if not exist "%OUTNAME%" mkdir "%OUTNAME%"
if not exist "%OUTNAME%" goto err_in_outdir
cd "%OUTNAME%"
:skip_newdir

rem ##--- ���s�p�X��ʂ� ---
set path=%path%;%BINDIR%

rem ##------------------------------------------------
rem ## �蓮�C�����p�̏ȗ�����
rem ## ���ϐ� RESTART_AFTER_TRIM=1 �����O�ݒ莞��CM�ʒu���o�܂ŏȗ�
rem ## CM�ʒu(obs_cut.avs)���蓮�C�����čĊJ����p�r��z��
rem ##------------------------------------------------
if "%RESTART_AFTER_TRIM%" == "1" (
  echo RESTART_AFTER_TRIM=1���ݒ肳��Ă��邽�߁ACM�ʒu���o�͏ȗ����܂�
  goto skip_intools
)

rem ##------------------------------------------------
rem ## �t�@�C�����ɂ�铮��ύX
rem ##------------------------------------------------
rem ##--- �t�@�C�����ɂ���ăp�����[�^�ύX����ꍇ ---
call "%BINDIR%bat_jlse_pre.bat" "%~dpnx1"

rem ##--- ���ʐݒ� ---
set JLOGO_CMD_PATH=%JL_DIR%%JLOGO_CMD%

rem ##--- ���S���o���Ȃ����̓��S�ݒ�ȗ� ---
if "%LOGO_PATH%" == "" goto skip_logoname
if "%LOGO_ABBR%" == "" goto skip_logoname
rem ##################################################
rem ##  �����ǖ��◪�̂Ń��S���肷��ꍇ�ɐݒ肷��
rem ##    %LOGO_NAME% : �����ǖ��i�F���p�j
rem ##    %LOGO_INST% : �����ǖ��i�ݒ�p�j
rem ##    %LOGO_ABBR% : �����Ǘ���
rem ##################################################
rem ===== �ȉ��A�ݒ肷�郍�S��rem���O�� =====
rem set LOGO_PATH=%LG_DIR%%LOGO_NAME%.lgd
set LOGO_PATH=%LG_DIR%%LOGO_INST%.lgd
rem set LOGO_PATH=%LG_DIR%%LOGO_ABBR%.lgd
:skip_logoname

rem ##------------------------------------------------
rem ## CM�J�b�g���s�O�̓���
rem ##------------------------------------------------
rem ##--- ���s ---
call "%BINDIR%bat_intools.bat" "%~dpnx1"
:skip_intools

rem ##------------------------------------------------
rem ## CM�J�b�g����
rem ##------------------------------------------------
rem ##--- ���s ---
call "%BINDIR%bat_jlse_main.bat"
if %ERRORLEVEL% neq 0 goto err_end

rem ##------------------------------------------------
rem ## chapter�쐬
rem ##------------------------------------------------
cscript //nologo "%BINDIR%func_chapter_jls.vbs" org     "%file_avs_cut%" "%file_txt_jlscp%" > "%file_txt_cpt_org%"
cscript //nologo "%BINDIR%func_chapter_jls.vbs" cut     "%file_avs_cut%" "%file_txt_jlscp%" > "%file_txt_cpt_cut%"
cscript //nologo "%BINDIR%func_chapter_jls.vbs" tvtplay "%file_avs_cut%" "%file_txt_jlscp%" > "%file_txt_cpt_tvt%"
if not "%file_chapter_tvtplay%" == "" copy "%file_txt_cpt_tvt%" "%file_chapter_tvtplay%"
if not "%file_chapter_org%" == "" copy "%file_txt_cpt_org%" "%file_chapter_org%"
if not "%file_chapter_cut%" == "" copy "%file_txt_cpt_cut%" "%file_chapter_cut%"


rem ##--- ���� ---
echo ���ʏo�͐�F"%OUTDIR%%OUTNAME%"

popd
endlocal
exit /b 0


rem ##------------------------------------------------
rem ## �G���[����
rem ##------------------------------------------------
:err_in_name
echo ���͂����t�@�C���̊g���q��ts�܂���avs�ł͂���܂���
goto err_end

:err_in_none
echo ���̓t�@�C����������܂���i"%~1"�j
goto err_end

:err_in_outdir
echo �o�̓t�H���_�������ł��܂���i"%OUTDIR%%OUTNAME%"�j
goto err_end

rem ##------------------------------------------------
rem ## �G���[�I��
rem ##------------------------------------------------
:err_end
timeout /t 30
if %ERRORLEVEL% neq 0 pause
endlocal
exit /b 1
