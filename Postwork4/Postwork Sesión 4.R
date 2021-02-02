# Postwork Sesión 4
# 
# Objetivo
# Investigar la dependencia o independecia de las variables aleatorias X y Y, el número 
# de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante.
# 
# Requisitos
# R, RStudio
# Haber trabajado con el Prework y el Work
# 
# Desarrollo
# Ahora investigarás la dependencia o independencia del número de goles anotados por el 
# equipo de casa y el número de goles anotados por el equipo visitante mediante un procedimiento 
# denominado bootstrap, revisa bibliografía en internet para que tengas nociones de este desarrollo.

# Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles 
# (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén 
# una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las 
# probabilidades marginales correspondientes.

setwd("~/BEDU/Sesion 4. Algunas distribuciones, teorema central del límite y contraste de hipótesis")
load(file="Pw4DATA.RData")
library(dplyr)
library(ggplot2)


Pconmar<-P.Conjunta

for (x in 1:7) {
  for (y in 1:9) {
    Pconmar[y,x]=Pconmar[y,x]/(frecFTAG[x,3]*frecFTHG[y,3])
  }
}
Pconmar

dataP<-data.frame(Pconmar)
ggplot(dataP, aes(x=dataP[,1],y=dataP[,2], fill=dataP[,3])) + 
  geom_tile() +
  xlab("No. Goles Local") +
  ylab("No. Goles Visitante")+
  ggtitle("Cociente muestra original") +
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="Cociente")



# Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en 
# la tabla del punto anterior. Esto para tener una idea de las distribuciones de la cual 
# vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece razonable 
# suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos 
# independencia de las variables aleatorias X y Y).


x<-as.numeric(dataP[,1])
y<-as.numeric(dataP[,2])
z<-as.numeric(dataP[,3])

x2<-data.frame(numeric(1000))
y2<-data.frame(numeric(1000))
z2<-data.frame(numeric(1000))

medias<-cbind.data.frame(x2,y2,z2)
names(medias)=c("x2","y2","z2")

for(i in 1:1000) {
  muestrax=sample(x, replace=T)
  medias[i,1]=mean(muestrax)
  muestray=sample(y, replace=T)
  medias[i,2]=mean(muestray)
  muestraz=sample(z, replace=T)
  medias[i,3]=mean(muestraz)
}

ggplot(medias, aes(x=medias[,1],y=medias[,2], fill=medias[,3])) + 
  geom_tile() +
  xlab("No. Goles Local") +
  ylab("No. Goles Visitante")+
  ggtitle("Cociente bootstrap") +
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="Cociente")


sd(dataP[,3], na.rm = FALSE) # 0.9801441
mean(dataP[,3])             #0.8595706
sd(medias[,3], na.rm = FALSE) # 0.1195076
mean(medias[,3])             # 0.8581522

hist(dataP[,3])
hist(medias[,3])