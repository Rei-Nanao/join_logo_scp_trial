rem ## 
rem ## join_logo_scp����m�F�p�o�b�`�t�@�C���̐ݒ�t�@�C��
rem ## ���́F
rem ##  %1     : AVS�t�@�C�����܂���TS�t�@�C����
rem ## 
rem ## ���ϐ��i���́j�F
rem ##  BASEDIR   : �ŏ��̃o�b�`�t�@�C���ꏊ
rem ## 

rem ##------------------------------------------------
rem ## �`���v�^�[�ݒ�
rem ##------------------------------------------------
rem === �`���v�^�[�o�͐�itvtplay�p�j����̓t�@�C���ɂ���ꍇ����rem������ ===
rem set file_chapter_tvtplay=%~dpn1.chapter

rem === �`���v�^�[�o�͐�i�J�b�g�O�j����̓t�@�C���ɂ���ꍇ����rem������ ===
rem set file_chapter_org=%~dpn1.chapter.txt
rem === �`���v�^�[�o�͐�i�J�b�g��j����̓t�@�C���ɂ���ꍇ����rem������ ===
rem set file_chapter_cut=%~dpn1.chapter.txt

rem ##------------------------------------------------
rem ## TS�t�@�C���w�莞�̏o�͐�
rem ## OUTDIR\OUTNAME\ �Ɍ��ʂ��o�͂����
rem ##------------------------------------------------
rem ##--- �o�͐ݒ� ---
set OUTDIR=%BASEDIR%result\
set "OUTNAME=%~n1\"

rem ##------------------------------------------------
rem ## ���̓t�@�C���̃t�H���_�ݒ�
rem ##------------------------------------------------
rem ##--- ���͐ݒ� ---
set BINDIR=%BASEDIR%bin\
set SETDIR=%BASEDIR%setting\
set JL_DIR=%BASEDIR%JL\
set LG_DIR=%BASEDIR%logo\

rem ##------------------------------------------------
rem ## ����p�����[�^�ݒ�
rem ##------------------------------------------------
set LOGO_PATH=%LG_DIR%
set OPT_CHAPTER_EXE=-s 8 -e 4
set JLOGO_CMD=JL_�W��.txt

rem ##------------------------------------------------
rem ## ����ݒ�Ɏg�p����t�@�C����
rem ##------------------------------------------------
rem ##--- ���̓f�[�^ ---
set file_csv_chlist=ChList.csv
set file_csv_param1=JLparam_set1.csv
set file_csv_param2=JLparam_set2.csv

rem ##--- �p�����[�^�ݒ�p�i�V�K�쐬�t�@�C���j ---
set file_bat_param=obs_param.bat

rem ##------------------------------------------------
rem ## �쐬�t�@�C�����ݒ�
rem ##------------------------------------------------
rem ##--- �쐬�t�@�C���� ---
set file_avs_in=in_org.avs
set file_txt_cpt_org=obs_chapter_org.chapter.txt
set file_txt_cpt_cut=obs_chapter_cut.chapter.txt
set file_txt_cpt_tvt=obs_chapter_tvtplay.chapter

rem ##--- �t�@�C�����ݒ� ---
set file_avs_logo=obs_logo_erase.avs
set file_avs_cut=obs_cut.avs
set file_avs_in_cutcm=in_cutcm.avs
set file_avs_in_cutcl=in_cutcm_logo.avs
set file_txt_logoframe=obs_logoframe.txt
set file_txt_chapterexe=obs_chapterexe.txt
set file_txt_jlscp=obs_jlscp.txt

exit /b
