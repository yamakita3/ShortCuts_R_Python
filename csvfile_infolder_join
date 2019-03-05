#フォルダの同じ名前のファイルのcsvを結合して新しいcsvに出力する。
winDialog("ok","フォルダの選択画面が開きます。
結合されるdiveから始まるcsv、右から結合するhdcから始まるcsvを検索し、
数字、abc順に結合され、.で区切ったファイル名に_cind_hdc_csvとつけて出力
します")
path1 <- choose.dir(getwd(), "Choose a data folder")
infiles1 <- dir(path1,"^dive.*\\.csv$")
infiles2 <- dir(path1,"^hdc.*\\.csv$")
outfolder <- path1
if(length(infiles1)!=length(infiles2)){
	warning("different number of files")
}
for(i in 1:length(infiles1)){
	write.csv(
		cbind(
			read.csv(infiles1[i]),read.csv(infiles2[i])
		)
	,file=paste(strsplit(infiles1[1],"\\.")[[1]][1],"_cbind_hdc.csv",sep=""),row.names=F
	)
}
