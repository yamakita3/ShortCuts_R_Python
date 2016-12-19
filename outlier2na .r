####
#outlierをnaに変換する関数。
#
outlier2na <- function(dat1,band1=2,quant=c(0.05,0.95)){
 outlier2navec <-function(dat=dat1,band=band1,quant=c(0.05,0.95)){
 	for(i in (1+band):(length(dat)-band)){
 	 qu <- quantile(dat[(i-band):(i+band)],quant,na.rm=T)
 	 #naの入ったバッファをつけても良いかも。
 	 if(is.na(dat[i])==T){
 	 	
 	 }else{
 	 	if(dat[i]<qu[1]|dat[i]>qu[2]){
 	 		dat[i] <- NA
 	 	}
 	 }
 	}
 	return(dat)
 }
 if(is.null(dim(x))==T){
 	outlier2navec(dat=dat1,band=band1,quant)
 }else{
 	apply(dat1,2,function(x) outlier2navec(dat=x,band=band1))
 }
 return(x)
}


#Example:zooパッケージをつかった一連の補間の例
#http://www.okadajp.org/RWiki/?cmd=read&page=R%E3%81%A7%E3%83%87%E3%83%BC%E3%82%BF%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%8B%E3%83%B3%E3%82%B0&word=%E5%A4%96%E3%82%8C%E5%80%A4#ac3e0f8e
library(zoo)
x <- matrix(c(1:3,0,5:6,NA,0,NA,10,11,100,13:18), ncol = 2);x
#0をnaにする。
x[x==0] <- NA;x
#外れ値をnaにする
x <- outlier2na(x,band1=2);x
#naを補完する。
x <- na.approx(x); x
##参考
#a <- x[,3]
#d <- 1
#for(i in (1+d):(nrow(a)-d)){
# qu <- quantile(a[(i-d):(i+d)],na.rm=T)
# if(a[i]<qu[2]|a[i]>qu[2]){a[i] <- NA
#}#
#apply(x,2,function(x) outlier2navec(dat=x,band=2))

