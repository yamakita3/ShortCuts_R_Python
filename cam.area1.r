
cam.area1 <- function(h=1,type="crbdowncam1"){
 if(type=="crbdowncam1"){
 	area <-tan(pi/180*43)*h*tan(pi/180*28)*h
 	#https://mail.google.com/mail/u/0/#search/%E3%82%AF%E3%83%A9%E3%83%A0%E3%83%9C%E3%83%B3%E3%80%80%E7%94%BB%E8%A7%92/140a519caaaf0512
 }
 return(area)
}


#4 補正レンズ 有り　0.3倍（実測は、ここまで広角ではない） 無し
#5 カメラF値 F1.8 -
#6 焦点距離 5.1～51mm 8mm
#7 水平画角 気中　約90度（ワイコンアリ）/水中　約67度 気中54.4度　/　水中　約43度（気中の0.75倍）
#8 垂直画角 - 気中37.8度　/　水中　約28度（気中の0.75倍）
#9 取り付け角度 パン±50゜，チルト±40 90度
