


#cooccurrence of two table
#2語の共起表の作成
coocur2table <- function(x){
x <- data.frame(x) 
res <- matrix(0,nrow=ncol(x),ncol=ncol(x)) 
for(i in 1:nrow(res)){
 for(j in 1:ncol(res)){
  res[i,j] <- nrow((x[x[,i]>0&x[,j]>0,])) 
  }
}
colnames(res) <- colnames(x)
rownames(res) <- colnames(x)
return(res)
}

#example
#test<-matrix(c(1,1,0,0,0, 0,1,1,1,1, 1,1,1,1,1, 1,0,1,1,0),5,4)
#colnames(test)<-c("国民","生活", "安心","安全")
#rownames(test)<-c("d1","d2","d3", "d4","d5")
#res <- coocur2table(test)
#write.table(res,"clipboard",sep="\t")



#reference
#	test<-matrix(c(1,1,0,0,0, 0,1,1,1,1, 1,1,1,1,1, 1,0,1,1,0),5,4)
#	colnames(test)<-c("国民","生活", "安心","安全")
#	rownames(test)<-c("d1","d2","d3", "d4","d5")
#	x <- test 
#	x <- data.frame(x) 
#	res <- matrix(0,nrow=ncol(x),ncol=ncol(x)) 
#	#res[1,2] <- nrow((x[x[,1]>0&x[,2]>0,])) 
#	for(i in 1:nrow(res)){
#	 for(j in 1:ncol(res)){
#	  res[i,j] <- nrow((x[x[,i]>0&x[,j]>0,])) 
#	  }
#	}
#	colnames(res) <- colnames(x)
#	rownames(res) <- colnames(x)
#	write.table(res,"clipboard",sep="\t")
#
#	#
#	library(network)
#	test.ne<-network(test)
#	plot(test.ne,displaylabels = TRUE)
