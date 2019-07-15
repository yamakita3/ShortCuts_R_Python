###############################################
#detectnet_csv_to_image_v002_loop_selected.r
#detectnet csv to labelled image by T Yamakita
#ディテクトネットのcsvファイルを元に塗りつぶし画像を作成します。


#######################
##ver3

#select the folder which have image and textdata (text must be delimited by space)
setwd(choose.dir())
#change extension name (Letters are case sensitive)
imagefiles <- dir(,"*.png")#★or jpeg
labelfiles <- dir(,"*.txt")
#show filenames and check the name list (if different list the files by yourself like levels)
if( length(imagefiles==length(labelfiles)) ){
 paste("OK number of files are same") 
}else{
 paste("Error number of files are different") 
}
#listup the files you want to process
imagefiles
labelfiles


#Create the levels of the category 
#you can wrirte manually by the order you want to label from 1, 2, 3...
#  labelsall <- c("Car","Van")#★
#or make label from csv or text
for(i in 1:length(labelfiles)){
 if(i==1){labelcsv.all <- read.table(labelfiles[1])}
 else{labelcsv.all <- rbind(labelcsv.all,read.table(labelfiles[i]))}
}
#labelling
levels(factor(as.matrix(labelcsv.all)[,1]))
levelsall <-levels(factor(as.matrix(labelcsv.all)[,1]))


#read images and add labels
library(png);library(jpeg)
for(j in 1:length(imagefiles)){
 #img <- readJPEG(imagefiles[j]) #★or PNG
 img <- readPNG(imagefiles[j]) #★
 labelcsv <- read.table(labelfiles[j])#"detectnetlabel_P1010840.txt")
 #lavelsall <- levels(factor(as.matrix(labelcsv)[,1]))
 labelcsv <-  subset(labelcsv, labelcsv[,1] %in% labelsall)
 outfname1 <- paste(gsub("\\.[0-9A-Za-z]+$", "",imagefiles[j]),"_class.png",sep="")
 outfname2 <- paste(gsub("\\.[0-9A-Za-z]+$", "",imagefiles[j]),"_marge.png",sep="")
 
 png(outfname1, width=ncol(img), height=nrow(img)) #書き出し用pngファイルのオープン
	 par(mar=c(0,0,0,0),xaxs = 'i',yaxs='i')#余白全くなし設定
	 plot( 0,0, xlim=c(0,ncol(img)), ylim=c(nrow(img),0), type="n", asp=1 )#原点左上、ylimが通常と逆
	 #rasterImage(image, xleft, ybottom, xright, ytop)
	 #rasterImage(img, 0, nrow(img), ncol(img), 0)#左下と右上を指定して貼る
	 
	 for(i in 1:nrow(labelcsv)){
	  xleft<-labelcsv[i,5];ybottom<-labelcsv[i,6];xright <-labelcsv[i,7];ytop<-labelcsv[i,8]
	  rect( xleft,ybottom,xright,ytop, col=factor(labelcsv[i,1],levels=labelsall),border=NA)#
	  #rect( xleft,ybottom,xright,ytop,col=factor(labelcsv[i,1],levels=levelsall),border="white" )#factorを統一する場合
	 }
 dev.off() 


 png(outfname2, width=ncol(img), height=nrow(img)) #書き出し用pngファイルのオープン
	 par(mar=c(0,0,0,0),xaxs = 'i',yaxs='i')#余白全くなし設定
	 plot( 0,0, xlim=c(0,ncol(img)), ylim=c(nrow(img),0), type="n", asp=1 )#原点左上、ylimが通常と逆
	 #rasterImage(image, xleft, ybottom, xright, ytop)
	 rasterImage(img, 0, nrow(img), ncol(img), 0)#左下と右上を指定して貼る
	 
	 for(i in 1:nrow(labelcsv)){
	  xleft<-labelcsv[i,5];ybottom<-labelcsv[i,6];xright <-labelcsv[i,7];ytop<-labelcsv[i,8]
	  rect( xleft,ybottom,xright,ytop, col=NA, border=factor(labelcsv[i,1],levels=labelsall))#
	  #rect( xleft,ybottom,xright,ytop,col=factor(labelcsv[i,1],levels=levelsall),border="white" )#factorを統一する場合
	 }
 dev.off() 
 
}


##
#######################
