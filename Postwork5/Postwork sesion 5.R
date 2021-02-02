# Postwork Sesión 5

# OBJETIVO
# Continuar con el desarrollo de los postworks; en esta ocasión se utiliza la función predict para realizar predicciones de 
# los resultados de partidos para una fecha determinada

# REQUISITOS
# Haber desarrollado los postworks anteriores
# Cubrir los temas del prework
# Replicar los ejemplos de la sesión

# DESARROLLO
# A partir del conjunto de datos de soccer de la liga española de las temporadas 2017/2018, 2018/2019 y 2019/2020, crea el 
# data frame SmallData, que contenga las columnas date, home.team, home.score, away.team y away.score; esto lo puede hacer 
# con ayuda de la función select del paquete dplyr. Luego establece un directorio de trabajo y con ayuda de la función write.csv 
# guarda el data frame como un archivo csv con nombre soccer.csv. Puedes colocar como argumento row.names = FALSE en write.csv.
# 
library(dplyr)

getwd()
setwd("~/BEDU/Sesion 5. Regresión lineal y clasificación/Postwork data")
dir()
lista<- lapply(dir(), read.csv)
View(lista[[1]])
lista<-lapply(lista,select, Date, HomeTeam, FTHG, AwayTeam, FTAG)
lista[[1]] <- mutate(lista[[1]], Date = as.Date(Date,"%d/%m/%y"))
lista[[2]] <- mutate(lista[[2]], Date = as.Date(Date,"%d/%m/%Y"))
lista[[3]] <- mutate(lista[[3]], Date = as.Date(Date,"%d/%m/%Y"))

head(lista)
summary(lista)

smalldata<-do.call(rbind,lista)
names(smalldata)=c("date", "home.team", "home.score", "away.team", "away.score")
summary(smalldata)
str(smalldata)

write.csv(smalldata,"../Postwork data/soccer.csv")

# Con la función create.fbRanks.dataframes del paquete fbRanks importe el archivo soccer.csv a R y al mismo tiempo asignelo 
# a una variable llamada listasoccer. Se creará una lista con los elementos scores y teams que son data frames listos para 
# la función rank.teams. Asigna estos data frames a variables llamadas anotaciones y equipos.

#install.packages("fbRanks")
library(fbRanks)

listasoccer<-create.fbRanks.dataframes("soccer.csv")
View(listasoccer[["teams"]])
anotaciones<-listasoccer[["scores"]]
equipos<- listasoccer[["teams"]]


# Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan y que correspondan a las fechas en 
# las que se jugaron partidos. Crea una variable llamada n que contenga el número de fechas diferentes. Posteriormente, 
# con la función rank.teams y usando como argumentos los data frames anotaciones y equipos, crea un ranking de equipos 
# usando unicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas 
# las deberá especificar en max.date y min.date. Guarda los resultados con el nombre ranking.

fecha<-unique(anotaciones$date)
n<-nrow(as.data.frame(c(fecha)))

ranking <- rank.teams(scores = anotaciones, 
                      teams = equipos, 
                      max.date = "2020-07-16", 
                      min.date = "2017-08-18" )

# Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado 
# es un empate para los partidos que se jugaron en la última fecha del vector de fechas fecha. Esto lo puedes hacer con 
# ayuda de la función predict y usando como argumentos ranking y fecha[n] que deberá especificar en date.
fecha[n]
predict(ranking, min.date =fecha[n])



