import sys
import os
import geopandas as gpd
from shapely import wkt
import fiona

# カスタムドライバを設定
fiona.drvsupport.supported_drivers['KML'] = 'rw'

def convert_wkt_to_kml_shp(input_csv, wkt_column, kml_output, shp_output):
    # CSVファイルを読み込む
    df = gpd.read_file(input_csv)

    # WKT列をGeometry型に変換
    df['geometry'] = df[wkt_column].apply(wkt.loads)

    # KMLファイルにエクスポート
    df.to_file(kml_output, driver='KML')

    # ESRI Shapefileにエクスポート
    df.to_file(shp_output, driver='ESRI Shapefile')

if __name__ == "__main__":
    # 引数の数が正しいか確認
    if len(sys.argv) == 1:
        print("Usage: python script.py [input_csv] [wkt_column_name] [kml_output_name] [shp_output_name]")
        print("No options specified. Trying with default values.")

        # デフォルトの値を設定
        script_dir = os.path.dirname(os.path.abspath(__file__))
        input_csv = os.path.join(script_dir, "input_data.csv")
        wkt_column = "wkt"
        kml_output = f"{input_csv}_output.kml"
        shp_output = f"{input_csv}_output.shp"

        print(f"Tried with the following options:\nInput CSV: {input_csv}\nWKT Column: {wkt_column}\nKML Output: {kml_output}\nShapefile Output: {shp_output}")

    elif len(sys.argv) == 5:
        # 引数が指定されている場合はそれを使用
        input_csv = sys.argv[1]
        wkt_column = sys.argv[2]
        kml_output = sys.argv[3]
        shp_output = sys.argv[4]
    else:
        print("Usage: python script.py [input_csv] [wkt_column_name] [kml_output_name] [shp_output_name]")
        sys.exit(1)

    convert_wkt_to_kml_shp(input_csv, wkt_column, kml_output, shp_output)