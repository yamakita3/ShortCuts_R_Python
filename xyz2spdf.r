#shortcut function to create spatial point data frame 
#Takehisa Yamakita v1 2014
xyz2spdf <- function(x.long,y.lat,z.dataframe,crs.prj="+proj=longlat +datum=WGS84"){
        x.long <- as.numeric(x.long)
        y.lat <- as.numeric(y.lat)
        if(max(y.lat,na.rm=T) > 90){cat(paste("lat numbers are more than 90"))}
        if(min(y.lat,na.rm=T) < -90){cat(paste("lat numbers are more than -90"))}
        require(sp)
        SpatialPointsDataFrame(
                SpatialPoints(
                        data.frame(longitude=x.long,latitude=y.lat)
                        ,proj4string = CRS(paste(crs.prj))
                        ), data = data.frame(z.dataframe)
        )
 }

#example
#df <- (lon=c(135.1,136.2,137,3),lat=c(36.1,37.1,37.3),dat1=c(1:3))
#df.spdf <- xyz2spdf(df$lon,df$lat,df)
#spplot(df.spdf[3])
#require(maptools);
#writeSpatialShape(df.spdf,"df.spdf")
#

