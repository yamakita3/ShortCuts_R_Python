#フォルダの同じ名前のファイルのcsvを結合して新しいcsvに出力する。

#1248x384

#90deegree rotation
##x1 <- read.table("P1010767.txt",sep=" ",as.is=T,header=F)
#imgx <- 1248; imgy <- 384
#x1 <- matrix(strsplit(c("Car 0.0 0 0.0 7 4 380 196 0.0 0.0 0.0 0.0 0.0 0.0 0.0")," ")[[1]],nrow=1)

rotation90 <- function(x1,imgx,imgy){
 labels <- x1[,1]
 x1 <- matrix(as.numeric(x1[,]),byrow=T,ncol=15)
 xst=x1[,5]
 xen=x1[,7]
 yst=x1[,6]
 yen=x1[,8]
 lab=x1[,1]
 ids=1:nrow(x1)
 x2 <- x1
 x2[,5]=imgy-yen
 x2[,7]=imgy-yst
 x2[,6]=xst
 x2[,8]=xen
 return(x2)
}

path1 <- choose.dir(getwd(), "Choose a data folder")
infiles1 <- dir(path1,"*.txt$")
outfolder <- path1
for(i in 1:length(infiles1)){
	write.csv(
		rotation90(x1,imgx,imgy)
	,file=paste(strsplit(infiles1[1],"\\.")[[1]][1],"_r90.txt",sep=" "),row.names=F
	)
}
