@echo off

rem ## join_logo_scp�ȈՎ��s - CM�J�b�g����
rem ## �o�́F
rem ##  join_logo_scp�̌��ʃt�@�C��
rem ##
rem ## ���ϐ��i���́j�F
rem ##  BINDIR    : ���s�t�@�C���t�H���_
rem ##  LOGO_PATH       : ���S�t�@�C����
rem ##  LOGOSUB_PATH    : CM���o�Ɏg��Ȃ����S�t�@�C����
rem ##  JLOGO_CMD_PATH  : join_logo_scp�̎��s�X�N���v�g
rem ##  JLOGO_OPT1      : join_logo_scp�̃I�v�V����1
rem ##  JLOGO_OPT2      : join_logo_scp�̃I�v�V����2
rem ##  JL_FLAGS        : join_logo_scp��-flags�I�v�V�������e
rem ##  OPT_CHAPTER_EXE : chapter_exe�̃I�v�V����
rem ##  file_avs_in     : ����avs�t�@�C����
rem ##  RESTART_AFTER_TRIM : 1�̎��J�b�g�ʒu�͎蓮�C���ς݂Ƃ��ďȗ�
rem ##


rem ##------------------------------------------------
rem ## �����ݒ�i�ʂ̏��ł܂Ƃ߂Đݒ�j
rem ##------------------------------------------------
rem ##--- �t�@�C�����ݒ� ---
rem set file_avs_in=in_org.avs
rem set file_avs_logo=obs_logo_erase.avs
rem set file_avs_cut=obs_cut.avs
rem set file_avs_in_cutcm=in_cutcm.avs
rem set file_avs_in_cutcl=in_cutcm_logo.avs
rem set file_txt_logoframe=obs_logoframe.txt
rem set file_txt_chapterexe=obs_chapterexe.txt
rem set file_txt_jlscp=obs_jlscp.txt

rem ## "������"�̕�����\�ŏI���ƃo�b�`�����Ō㔼��"���F������Ȃ����ߑ΍�
set DISP_LOGO_PATH=
if not "%LOGO_PATH%" == "" set "DISP_LOGO_PATH=%LOGO_PATH:\=\\%"

rem ##------------------------------------------------
rem ## �蓮�C�����p�̏ȗ�����
rem ##------------------------------------------------
if "%RESTART_AFTER_TRIM%" == "1" goto skip_exe_jls

rem ##------------------------------------------------
rem ## chapter_exe���s
rem ##------------------------------------------------
"%BINDIR%chapter_exe.exe" -v "lwinput.aui://%file_avs_in%" %OPT_CHAPTER_EXE% -o "%file_txt_chapterexe%"
if %ERRORLEVEL% neq 0 goto err_chapterexe

rem ##------------------------------------------------
rem ## logoframe���s
rem ##------------------------------------------------
rem ## ���S�f�[�^�iCM�m�F�p�A���֌W�p�j���m�F���A�����Ȃ���Ύ��s���Ȃ�
set DISP_LOGO_OPT=
set JL_INLOGO=
if not "%DISP_LOGO_PATH%" == "" set DISP_LOGO_OPT=-logo "%DISP_LOGO_PATH%"
if not "%LOGOSUB_PATH%" == ""   set DISP_LOGO_OPT=%DISP_LOGO_OPT% -logo99 "%LOGOSUB_PATH%"
if "%DISP_LOGO_PATH%" == "" if "%LOGOSUB_PATH%" == "" goto skip_logoframe

"%BINDIR%logoframe.exe" "%file_avs_in%" %DISP_LOGO_OPT% -oa "%file_txt_logoframe%" -o "%file_avs_logo%"
if %ERRORLEVEL% neq 0 goto err_logoframe
if not exist "%file_txt_logoframe%" goto skip_logoframe
set JL_INLOGO=-inlogo "%file_txt_logoframe%"

:skip_logoframe

rem ##------------------------------------------------
rem ## join_logo_scp���s
rem ##------------------------------------------------
"%BINDIR%join_logo_scp.exe" %JL_INLOGO% -inscp "%file_txt_chapterexe%" -incmd "%JLOGO_CMD_PATH%" -o "%file_avs_cut%" -oscp "%file_txt_jlscp%" -flags "%JL_FLAGS%" %JLOGO_OPT1% %JLOGO_OPT2%

:skip_exe_jls

rem ##------------------------------------------------
rem ## ����avs�t�@�C���쐬
rem ##------------------------------------------------
copy "%file_avs_in%" "%file_avs_in_cutcm%"
>>"%file_avs_in_cutcm%" type "%file_avs_cut%"

copy "%file_avs_in%" "%file_avs_in_cutcl%"
if exist "%file_avs_logo%" >>"%file_avs_in_cutcl%" type "%file_avs_logo%"
>>"%file_avs_in_cutcl%" type "%file_avs_cut%"

rem ##------------------------------------------------
rem ## ����
rem ##------------------------------------------------
exit /b 0


rem ##------------------------------------------------
rem ## �G���[����
rem ##------------------------------------------------
:err_chapterexe
echo chapter_exe�ŃG���[�����̂��߁A���f���܂��B
goto err_end

:err_logoframe
echo logoframe�ŃG���[�����̂��߁A���f���܂��B
goto err_end

:err_join
echo join_logo_scp�ŃG���[�����̂��߁A���f���܂��B
goto err_end

rem ##------------------------------------------------
rem ## �G���[�I��
rem ##------------------------------------------------
:err_end
exit /b 1
