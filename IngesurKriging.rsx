##Basic statistics=group
##showplots
##Layer=vector
##Field=Field Layer
##by=number 10
##Countour=output vector
##Output=output raster

# Libraries imports
# autofitVariogram and autoKrige
library(automap)
# raster
library(raster)

# CRS
# String de sistema de coordenadas
L.p4s<-proj4string(Layer)
#L.names<-names(Layer)

# Get values the data
# Y<-as.factor(Layer[[Field]])
A<-as.numeric(Layer[[Field]])

# Get points and limits 
coords<-coordinates(Layer)
MinX<-min(coords[,1])
MinY<-min(coords[,2])
MaxX<-max(coords[,1])
MaxY<-max(coords[,2])
Seqx<-seq(MinX, MaxX, by=by)
Seqy<-seq(MinY, MaxY, by=by)
MSeqx<-rep(Seqx, length(Seqy))
MSeqy<-rep(Seqy, length(Seqx))
MSeqy <- sort(MSeqy, decreasing=F)

# Grille to calculate estimations
# Like frame
Grille <- data.frame(X=MSeqx, Y=MSeqy)
# Grille SpatialPoints
coordinates(Grille)=c("X","Y")
# Add grid
gridded(Grille)<-TRUE
# Set CRS of Grille
if (L.p4s != "") {
proj4string(Grille) <- L.p4s
}

# Mesure values
# Like frme
Mesure<- data.frame(XP=coords[,1], YP=coords[,2], A)
# Mesure SpatialPoints
coordinates(Mesure)<-c("XP","YP")
# Set CRS Mesure
if (L.p4s != "") {
proj4string(Mesure) <- L.p4s
}

# Adjust variogram
variogram = autofitVariogram(A~1, Mesure)
plot(variogram)
kriging_result = autoKrige(A~1,  Mesure, Grille, model=c("Cir","Lin","Bes","Wav","Hol","Leg","Per","Pen","Mat","Exc","Spl","Ste"))
prediction = raster(kriging_result$krige_output)

# Set CRS of Prediction
if (L.p4s != "") {
proj4string(prediction) <- L.p4s
}

# Extract countours
contours = rasterToContour(prediction)

# Want to plot 
#plot(prediction)
#lines(contours)
#points(Mesure)

# Set return value
Countour<-contours

# Set return value
Output<-prediction
