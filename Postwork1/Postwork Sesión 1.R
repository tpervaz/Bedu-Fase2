# Postwork Sesión 1.

# Objetivo
# El Postwork tiene como objetivo que practiques los comandos básicos aprendidos durante la sesión, 
# de tal modo que sirvan para reafirmar el conocimiento. Recuerda que la programación es como un deporte 
# en el que se debe practicar, habrá caídas, pero lo importante es levantarse y seguir adelante. Éxito
# 
# Requisitos
# Concluir los retos
# Haber estudiado los ejemplos durante la sesión

# Desarrollo
# El siguiente postwork, te servirá para ir desarrollando habilidades como si se tratara de un proyecto 
# que evidencie el progreso del aprendizaje durante el módulo, sesión a sesión se irá desarrollando. A 
# continuación aparecen una serie de objetivos que deberás cumplir, es un ejemplo real de aplicación y 
# tiene que ver con datos referentes a equipos de la liga española de fútbol (recuerda que los datos provienen 
# siempre de diversas naturalezas), en este caso se cuenta con muchos datos que se pueden aprovechar, explotarlos 
# y generar análisis interesantes que se pueden aplicar a otras áreas. Siendo así damos paso a las instrucciones:
#   
# 1.Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R,
# los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

setwd("D:/OneDrive/Documentos/BEDU/Sesion 1 Introducción a R y Software (Github, Tipos de Datos)/")
soccer<-data.frame(read.csv("SP1.csv"))
library(dplyr)

# 2.Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de
# goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

housevisit<-select(soccer,FTHG,FTAG)
 
# 3.Consulta cómo funciona la función table en R al ejecutar en la consola ?table

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
