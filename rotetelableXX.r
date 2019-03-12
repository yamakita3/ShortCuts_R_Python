#Rotete DITECTNET label XXdegree
#Ditectnetの形式のラベルのテキストファイルが入ったフォルダを指定して、すべてのラベルをXX度回転させた画像に対応するラベルにします。
#画像のサイズを1248x384、テスト用に90°回転とサイズの10%分枠を縮小する値が入っています。枠を縮小させない場合1を入れてください。

#XXdeegree rotation
##x1 <- read.table("P1010767.txt",sep=" ",as.is=T,header=F)
#imgx <- 1248; imgy <- 384
#x1 <- matrix(strsplit(c("Car 0.0 0 0.0 7 4 380 196 0.0 0.0 0.0 0.0 0.0 0.0 0.0")," ")[[1]],nrow=1)

rotationXX <- function(x1,imgx,imgy,deg,cutpar){
 rad <- deg*(pi/180)
 imgx2 <- cos(rad)*imgx+sin(rad)*imgy;
 imgy2 <- cos(rad)*imgy+sin(rad)*imgx;
	
 x1 <- as.matrix(x1)
 labels <- x1[,1]
 x1 <- matrix(as.numeric(x1[,]),byrow=F,ncol=15)
 xst=x1[,5]
 xen=x1[,7]
 yst=x1[,6]
 yen=x1[,8]
 lab=x1[,1]
 ids=1:nrow(x1)
	
 x2 <- x1
 x2[,5]= cos(rad)*xst+sin(rad)*(imgy-yen)
 x2[,7]= x2[,5]+cos(rad)*(xen-xst)+sin(rad)*(yen-yst)
 x2[,6]= cos(rad)*yst+sin(rad)*xst
 x2[,8]= x2[,6]+cos(rad)*(yen-yst)+sin(rad)*(xen-xst)
 #x2[,1]=labels
	
 x3 <- as.matrix(x2) #cut ZZ percentage
 x2bboxlengx <- x2[,7]-x2[,5]
 x2bboxlengy <- x2[,8]-x2[,6]
 x3[,5]= x2[,5]+x2bboxlengx/cutpar
 x3[,7]= x2[,7]-x2bboxlengx/cutpar
 x3[,6]= x2[,6]+x2bboxlengy/cutpar
 x3[,8]= x2[,8]-x2bboxlengy/cutpar
 x3[,1]=labels
 return(x3)	
}

imgx <- 1248; imgy <- 384 ;deg <- 90; cutpar <- 10 #Please Modify to Your image size and angle 
path1 <- choose.dir(getwd(), "Choose a data folder")
infiles1 <- dir(path1,"*.txt$",full.names=T)

for(i in 1:length(infiles1)){
	infile <- read.table(infiles1[i],sep=" ",as.is=T,header=F)
	outfname <- paste(strsplit(infiles1[i],"\\.")[[1]][1],"_r",deg,".txt",sep=" ")
	result <- rotationXX(infile,imgx,imgy,deg,cutpar)
	write.table(result,file=outfname,row.names=F,col.names=F,sep=" ",quote=F
	)
}

#end
