#２つのcsvの行を結合して新しいcsvに出力する。
#
#for any environemnt
winDialog("ok","３つのファイル選択画面が順に開きます。
結合する順にcsvファイルを選択し、３つめの画面で新しいcsvファイルの名前を.csvまで入力してください。")
write.csv(
	cbind(
		read.csv(file.choose()),read.csv(file.choose())
	)
,file=file.choose(),row.names=F
)


#single line ver
#write.csv(cbind(read.csv(file.choose()),read.csv(file.choose())),file=file.choose(),row.names=F)


#anotherway for windows user
#a <- choose.files(,caption="select two csv files",filters = "csv")
#write.csv(
#	cbind(
#		read.csv(a[1]),read.csv(a[2])
#	)
#,file=choose.files(,caption="write the output csv name with .csv",multi=F),row.names=F
#)
#
