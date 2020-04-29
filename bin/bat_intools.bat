@echo off

rem ##
rem ## join_logo_scp�ȈՎ��s - avs�쐬�܂ł̓���
rem ## ���́F
rem ##  %1     : avs�t�@�C�����܂���ts�t�@�C����
rem ##
rem ## �o�́F
rem ##  (�t�@�C����)%file_avs_in% : avs�t�@�C��
rem ##
rem ## ���ϐ��i���́j�F
rem ##  file_avs_in  : �쐬����avs�t�@�C����
rem ##  use_tssplit  : ts�t�@�C�����͎��̓���w��
rem ##  use_intools  : ts�t�@�C�����͎��̓���w��
rem ##  tffbff       : L-Smash Works�ɐݒ肷��ꍇ�ATFF�܂���BFF
rem ##

rem ##--- avs���͎��͎��O�ݒ�s�v ---
if "%~x1" == ".avs" goto label_in_avs

rem ##------------------------------------------------
rem ## TsSplitter�g�p��
rem ##------------------------------------------------
rem ##--- ts�t�@�C�����O��������i��j ---
if "%use_tssplit%" == "1" goto label_tssplitter_1
if "%use_tssplit%" == "2" goto label_tssplitter_2
goto skip_tssplitter

:label_tssplitter_1
  TsSplitter.exe" -EIT -ECM -SD -1SEG "%~1"
  if not exist "%~dpn1_HD%~x1" goto skip_tssplitter
  move /Y "%~1" "%~dpn1_org%~x1"
  move /Y "%~dpn1_HD%~x1" "%~1"
  goto skip_tssplitter

:label_tssplitter_2
  rem �ʂ̐؂�o�����s��
  goto skip_tssplitter

:skip_tssplitter

rem ##------------------------------------------------
rem ## DGIndex�����g�p�������앪���
rem ##------------------------------------------------
rem ## 
rem ## use_intools�̎g�p��i0���ʏ�j
rem ##  0  : L-SMASH Works
rem ##  1  : dgindex + FAW
rem ## 10  : L-SMASH Works + ts_parser + FAW
rem ## 

rem ##---dgindex����m�F ---
if "%use_intools%" == "1" goto label_dgindex

rem ##------------------------------------------------
rem ##�i�ʏ���́j L-SMASH Works�œ���avs�t�@�C���쐬
rem ##------------------------------------------------
rem ##--- ts�t�@�C�����͎���avs�쐬 ---
:label_in_ts
set dominance=0
if "%tffbff%" == "TFF" set dominance=1
if "%tffbff%" == "BFF" set dominance=2
>  "%file_avs_in%" echo TSFilePath="%~1"
>> "%file_avs_in%" echo LWLibavVideoSource(TSFilePath, repeat=true, dominance=%dominance%)

rem ##--- ������ts_parser�ō쐬����ꍇ�͈ړ� ---
if "%use_intools%" == "10" goto label_tsparser

>> "%file_avs_in%" echo AudioDub(last, LWLibavAudioSource(TSFilePath, stream_index=1, av_sync=true))
goto label_in_end

rem ##------------------------------------------------
rem ##�i�ʃc�[���g�p��jDGIndex����
rem ##------------------------------------------------
:label_dgindex
echo DGIndex���g�p���܂�
set named2v=work_d2v
set nameinaac1=%named2v%*ms.aac
set nameinwav1=%named2v%*ms_aac.wav

DGIndex.exe -SD=? -AIF=?%~1? -OF=?%named2v%? -IA=3 -hide -exit
>  "%file_avs_in%" echo MPEG2Source("%named2v%.d2v", idct=3)
call :sublabel_faw
>> "%file_avs_in%" echo AudioDub(last,WavSource("%nameinwav%"))
>> "%file_avs_in%" echo YV12toYUY2(itype=0,interlaced=true,cplace=0)
goto label_in_end

rem ##------------------------------------------------
rem ##�i�ʃc�[���g�p��jts_parser����
rem ##------------------------------------------------
:label_tsparser
set nametsp=work_tsp
set nameinaac1=%nametsp%*ms.aac
set nameinwav1=%nametsp%*ms_aac.wav

ts_parser.exe --mode da -o "%nametsp%" "%~1"
call :sublabel_faw
>> "%file_avs_in%" echo AudioDub(last,WavSource("%nameinwav%"))
goto label_in_end

rem ##------------------------------------------------
rem ## �T�u���[�`��
rem ##�i�ʃc�[���g�p��jFAW����
rem ##------------------------------------------------
:sublabel_faw
FOR /F "delims=* usebackq" %%t IN (`dir /b "%nameinaac1%"`) DO set nameinaac=%%t
fawcl.exe -s2 "%nameinaac%"
FOR /F "delims=\ usebackq" %%t IN (`dir /b "%nameinwav1%"`) DO set nameinwav=%%t
exit /b


rem ##------------------------------------------------
rem ## ����avs�t�@�C���쐬�i����avs�t�@�C�����R�s�[�j
rem ##------------------------------------------------
rem ##--- avs�t�@�C�����͎��͍�Ɨp�̖��O�ŃR�s�[ ---
:label_in_avs
copy "%~1" "%file_avs_in%"

:label_in_end

exit /b
