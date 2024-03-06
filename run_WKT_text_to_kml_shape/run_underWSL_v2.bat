@echo "you need to have wsl2 and have python as python3 and geopandas"
@echo "This automatically search csv file with wkt column in the directory of this file ad run conversion"
@echo off
setlocal

rem バッチファイルの場所を取得
set "script_dir=%~dp0"
rem 不要な部分を除外
set "script_dir=%script_dir:~2,-1%"
rem バックスラッシュをスラッシュに置換
set "script_dir=%script_dir:\=/%"

rem WSL2上でPythonスクリプトを実行
wsl python3 "/mnt/c%script_dir%/test_convert_wkt_to_kml_shp_v2.py"  %*

endlocal
rem cmd /k