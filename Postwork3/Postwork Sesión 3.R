# Postwork Sesión 3

# Objetivo
# Realizar descarga de archivos desde internet
# Generar nuevos data frames
# Visualizar probabilidades estimadas con la ayuda de gráficas

# Requisitos
# R, RStudio
# Haber realizado el prework y seguir el curso de los ejemplos de la sesión
# Curiosidad por investigar nuevos tópicos y funciones de R

# Desarrollo
# Ahora graficaremos probabilidades (estimadas) marginales y conjuntas para el número de goles que
# anotan en un partido el equipo de casa o el equipo visitante.
# 
# Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias
# relativas para estimar las siguientes probabilidades:

setwd("D:/OneDrive/Documentos/BEDU/Sesion 3. Análisis Exploratorio de Datos (AED o EDA) con R")
soccer<-data.frame(read.csv("Goles17_20.csv"))
library(dplyr)
library(ggplot2)

housevisit<-select(soccer,FTHG,FTAG)

tablehousevisit<- table (housevisit)
tablehousevisit

frecFTHG<-data.frame(No.Goles=as.numeric(rownames(tablehousevisit)),Goles=apply(tablehousevisit, 1, sum))
frecFTHG

frecFTAG<-data.frame(No.Goles=as.numeric(colnames(tablehousevisit)),Goles=apply(tablehousevisit, 2, sum))
frecFTAG
 
# La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)

P.Marginal<-data.frame(P.Marginal=frecFTHG[,2]/sum(frecFTHG[,2]))
frecFTHG<-cbind.data.frame(frecFTHG,P.Marginal)
frecFTHG
sum(frecFTHG[,"P.Marginal"])
# La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)

P.MarginalFTAG<-data.frame(P.Marginal=frecFTAG[,2]/sum(frecFTAG[,2]))
frecFTAG<-cbind.data.frame(frecFTAG,P.MarginalFTAG)
frecFTAG
 
# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que 
# juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)

P.Conjunta=tablehousevisit/1140
P.Conjunta
class(P.Conjunta)
# Realiza lo siguiente:
# Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa

p.FTHG<-select(frecFTHG, No.Goles, P.Marginal)
p.FTHG
ggplot(p.FTHG, aes(x=p.FTHG[,'No.Goles'],y=p.FTHG[,"P.Marginal"], fill=p.FTHG[,'No.Goles'])) +
  geom_bar(stat = "identity") +
  xlab("No.Goles") +
  ylab("P.Marginal")+
  ggtitle("Probabilidad marginal para equipo local")+
  # theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="No. Goles")

# Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.

p.FTAG<-select(frecFTAG, No.Goles, P.Marginal)
ggplot(p.FTAG, aes(x=p.FTAG[,'No.Goles'],y=p.FTAG[,"P.Marginal"], fill=p.FTAG[,'No.Goles'])) +
  geom_bar(stat = "identity") +
  xlab("No.Goles") +
  ylab("P.Marginal")+
  ggtitle("Probabilidad marginal para equipo visitante")+
  # theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="No. Goles")

# Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y 
# el equipo visitante en un partido.

datahousevisit<-data.frame(tablehousevisit)
datahousevisit
####
# P.con<-datahousevisit[,3]/1140
# P.conj<-data.frame(P.con)
# datahousevisit<-cbind.data.frame(datahousevisit,P.conj)
####
ggplot(datahousevisit, aes(x=datahousevisit[,1],y=datahousevisit[,2], fill=(datahousevisit[,3]/1140))) + 
  geom_tile() +
  xlab("No. Goles Local") +
  ylab("No. Goles Visitante")+
  ggtitle("Probabilidad conjunta para equipos local y visitante") +
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="P. Conjunta")

