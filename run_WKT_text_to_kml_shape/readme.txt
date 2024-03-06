
This python command outputs shapefile and kml files from the well known text (WKT) format, which is GIS data in text format.
Prepare a csv file in the format described at the end of the file, place it in the same folder, and use it as follows
"python3 convert_wkt_to_kml_shp2_run.py input_data.csv wkt output_data.kml output_data.shp"

The batch file in the same directory can be placed in the folder where you want to run it with python file.
To run it with Python3 and geopandas installed in the Windows WSL.
This windows batch automatically creates kml and shp with no options, 
using the information in the wkt column from the csv file initially found in the folder.

テキスト形式のGISデータであるWell known text (WKT)フォーマットから、shapeファイルとkmlファイルを出力するpythonコマンドです。
末尾に記載のフォーマットのcsvファイルを用意して同じフォルダ内に置き、以下のように使用します。
"python3 convert_wkt_to_kml_shp2_run.py input_data.csv wkt output_data.kml output_data.shp"

同胞のbatchファイルは、WindowsのWSLにPython3、geopandasが導入された状態で、実行したいフォルダに設置することで、
自動的にフォルダ内で初めに見つかったcsvファイルからwktコラムの情報を用いて、kmlとshpをオプション無しで作成するものです。


##################
##CSV format
#id,name,wkt
#1,Point A,POINT(1.0 2.0)
#2,Point B,POINT(3.0 4.0)
#3,Point C,POINT(5.0 6.0)
#4,Point D,POINT(7.0 8.0)
#

#WKT Example	Description
#POINT(1 2)
#MULTIPOINT(0 0,1 1)
#LINESTRING(1.5 2.45,3.21 4)
#MULTILINESTRING((0 0,–1 –2,–3 –4),(2 3,3 4,6 7))
#POLYGON((1 2,1 4,3 4,3 2,1 2))#rectangle
#POLYGON((0.5 0.5,5 0,5 5,0 5,0.5 0.5), (1.5 1,4 3,4 1,1.5 1))#A polygon with a hole
#MULTIPOLYGON(((0 1,3 0,4 3,0 4,0 1)), ((3 4,6 3,5 5,3 4)), ((0 0,–1 –2,–3 –2,–2 –1,0 0)))
#GEOMETRYCOLLECTION(POINT(5 8), LINESTRING(–1 3,1 4))
#########
