# Postwork Sesi�n 1.

# Objetivo
# El Postwork tiene como objetivo que practiques los comandos b�sicos aprendidos durante la sesi�n, 
# de tal modo que sirvan para reafirmar el conocimiento. Recuerda que la programaci�n es como un deporte 
# en el que se debe practicar, habr� ca�das, pero lo importante es levantarse y seguir adelante. �xito
# 
# Requisitos
# Concluir los retos
# Haber estudiado los ejemplos durante la sesi�n

# Desarrollo
# El siguiente postwork, te servir� para ir desarrollando habilidades como si se tratara de un proyecto 
# que evidencie el progreso del aprendizaje durante el m�dulo, sesi�n a sesi�n se ir� desarrollando. A 
# continuaci�n aparecen una serie de objetivos que deber�s cumplir, es un ejemplo real de aplicaci�n y 
# tiene que ver con datos referentes a equipos de la liga espa�ola de f�tbol (recuerda que los datos provienen 
# siempre de diversas naturalezas), en este caso se cuenta con muchos datos que se pueden aprovechar, explotarlos 
# y generar an�lisis interesantes que se pueden aplicar a otras �reas. Siendo as� damos paso a las instrucciones:
#   
# 1.Importa los datos de soccer de la temporada 2019/2020 de la primera divisi�n de la liga espa�ola a R,
# los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

setwd("D:/OneDrive/Documentos/BEDU/Sesion 1 Introducci�n a R y Software (Github, Tipos de Datos)/")
soccer<-data.frame(read.csv("SP1.csv"))
library(dplyr)

# 2.Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los n�meros de
# goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

housevisit<-select(soccer,FTHG,FTAG)
 
# 3.Consulta c�mo funciona la funci�n table en R al ejecutar en la consola ?table

?table

# Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

tablehousevisit<- table (housevisit)
tablehousevisit

frecFTHG<-data.frame(No.Goles=as.numeric(rownames(tablehousevisit)),Goles=apply(tablehousevisit, 1, sum))
frecFTHG

frecFTAG<-data.frame(No.Goles=as.numeric(colnames(tablehousevisit)),Goles=apply(tablehousevisit, 2, sum))
frecFTAG


# 1.La probabilidad (marginal) de que el equipo que juega en casa (FTHG) anote x goles (x = 0, 1, 2, ...)

x<-0

Probabilidad<-frecFTHG[x+1,2]/sum(frecFTHG[,2])
Probabilidad
cat("La probabilidad de que local anote: ", x, " goles es de : ", Probabilidad)

# frecFTHG[cx,2]
# class(frecFTHG[cx,2])
# frecFTHG[nrow(frecFTHG),2]
# class(frecFTHG[nrow(frecFTHG),2])

# 2.La probabilidad (marginal) de que el equipo que juega como visitante (FTAG) anote y goles (y = 0, 1, 2, ...)

y<-0

Probabilidad<-frecFTAG[y+1,2]/sum(frecFTAG[,2])
Probabilidad
cat("La probabilidad de que visitante anote: ", y, " goles es de : ", Probabilidad)


# 3.La probabilidad (conjunta) de que el equipo que juega en casa (FTHG) anote x goles y el equipo que juega como 
# visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
tablehousevisit[(x+1),(y+1)]
Probabilidad<-tablehousevisit[(x+1),(y+1)]/380
cat("La probabilidad de que el visitante anote: ", y, " goles y el local anote: ", x, " goles es de : ", Probabilidad)
