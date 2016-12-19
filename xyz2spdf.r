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
