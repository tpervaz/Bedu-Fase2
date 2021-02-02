# Postwork Sesion 6 - Series de Tiempo

# Equipo 23
# Francisco Ricardo Arredondo Almuina - frankk_arredondo@hotmail.com
# Tamara Ytanyu Pérez Vázquez - tamara.ytanyu@gmail.com
# Carlos Eduardo Vidal Villeda - charlie.lalo@hotmail.com
# Jesus Emanuel Serrano Molina - emanuel.serm@gmail.com

# OBJETIVO
  # Aprender a crear una serie de tiempo en R

# REQUISITOS
  # Tener instalado R y RStudio
  # Haber trabajado con el Prework y el Work

# DESARROLLO
# Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:
  
# Pregunta 1
# Agrega una nueva columna sumagoles que contenga la suma de goles por partido.

  # Se cargan las librerias necesarias para realizar el problema planteado

library(dplyr)
library(anytime)
library(tidyverse)

  # Se establece el directorio en el cual se lee el archivo ".csv" para iniciar
  # con el postwork planteado

getwd()
setwd("C:/Users/Rito/Documents/UANL - Ing Aeronautica/Courses/Santander/BEDU - Data Science/Modulo 2 - Programación y Estadística con R/6. Series de Tiempo/")

match.data <- read.csv("match.data.csv") 

  # Se cambia el formato de la columna "date" a formato "Date" siendo que era un 
  # tipo caracter

match.data <- mutate(match.data, date = as.Date(date,"%Y-%m-%d"))

  # Se crea nueva columna que contenga la suma de goles por partido, en la 
  # cual se nombro como "total.score" y se adjunta con comando cbind al 
  # dataframe original

total.score <- c(match.data$home.score + match.data$away.score)
match.data <- cbind(match.data,total.score)

head(match.data)
str(match.data)

# Pregunta 2
# Obtén el promedio por mes de la suma de goles.

  # Al ser las columnas importantes del dataframe de este punto en adelante,
  # las fechas de cada partida y la suma de goles de los mismos, se nombraron 
  # como "dates" y "scores" para seleccionarlas del dataframe original

dates <- data.frame(match.data[,1])
scores <- data.frame(match.data[,6])

  # Se crea nuevo dataframe llamado "match.data.2" en el cual se adjuntan 
  # mediante el comando cbind, las fechas y suma de goles por partidos

match.data.2 <- cbind(dates,scores)

  # Se cambia de dataframe a lista mediante el comando "list" a nuestro nuevo
  # dataframe para poder usar el comando "lapply" y cambiar los nombres de las 
  # columnas a "date" y "total.score" y posteriormente se volvio a su 
  # formato de dataframe

match.data.2 <- list(match.data.2)
match.data.2 <- lapply(match.data.2, setNames, c("date", "total.score"))
match.data.2 <- data.frame(match.data.2)

  # Al requerirse el promedio por mes de la suma de goles, se extrae el mes y 
  # año de cada una de las fechas de la columna "date" mediante el comando 
  # "format" y se adjuntan al dataframe "match.data.2"

match.data.2 <- cbind(match.data.2, 
                      month = format(match.data.2$date, "%m"),
                      year = format(match.data.2$date, "%Y"))

  # Mediante el commando "aggregate" se obtiene el promedio mensual de la suma
  # de goles de acuerdo al mes y año correspondiente, renombrando a nuestro
  # dataframe teniendo unicamente las columnas de "month" "year" y "total.score"

match.data.2 <- aggregate(total.score ~ month + year, match.data.2, mean)

  # Asimismo, se cambia el formato de las columnas "month" y "year" a tipo
  # numerico que nos servira mas adelante en la creación de la serie de tiempo

match.data.2$month <- as.numeric(match.data.2$month)
match.data.2$year <- as.numeric(match.data.2$year)

head(match.data.2)
str(match.data.2)

# Pregunta 3
# Crea la serie de tiempo del promedio por mes de la suma de goles hasta 
# diciembre de 2019.

  # Al examinar nuestro dataframe nos dimos cuenta que no en todos los meses 
  # correspondientes a cada año hay partidos, por lo que se creará un nuevo 
  # dataframe que sirva como base con valores de goles promedio 0, que servirá
  # para "rellenar" los valores en donde no se hayan jugado partidos en cierto 
  # mes de cierto año y a este nuevo dataframe lo llamaremos "base.df"

month <- (month=c(rep(c(01:12),10)))
year <- (c(rep(2010,12),rep(2011,12),rep(2012,12),rep(2013,12),rep(2014,12),
           rep(2015,12),rep(2016,12),rep(2017,12),rep(2018,12),rep(2019,12)))
mean <- (numeric(120))

  # De igual manera que el dataframe de "match.data.2", a este nuevo dataframe
  # "base.df" cambiaremos el tipo de formato de las columnas "month" y "year", 
  # a tipo numerico, el cual nos ayudará a relacionar ambos dataframes

base.df <- data.frame(cbind(month,year,mean))
base.df$month <- as.numeric(base.df$month)
base.df$year <- as.numeric(base.df$year)
str(base.df)

  # Dentro de este for, lo que se realizó es que relacione ambas columnas tanto
  # de "month" como de "year", en donde al tener un valor mayor del promedio de
  # goles de nuestro dataframe "match.data.2", este tomara dicho valor en el 
  # dataframe "base.df", y en el caso que no haya dicho valor, seguira teniendo
  # el valor de 0 que tiene originalmente el dataframe "base.df", respetando 
  # los meses en los cuales no se jugaron partidos, teniendo un promedio de 
  # goles de 0

n=nrow(match.data.2)
for (i in 1:n) {
  for (j in 1:120) {
    if (match.data.2[i,1]==base.df[j,1] & match.data.2[i,2]==base.df[j,2] ) {
      base.df[j,]<-match.data.2[i,]
    }
  }
}

base.df

  # Tras tener el promedio mensual de la suma de goles, se creo la serie de 
  # tiempo, mediante el comando ts en el cual como establece el problema, 
  # se creo a partir de Enero del 2010, hasta Diciembre del 2019, nombrando 
  # esta serie de tiempo como "match.ts"

match.ts <- ts(base.df$mean, start = c(2010,1), 
               end = c(2019,12), frequency = 12)

  # Para corroborar que nuestra serie de tiempo es realmente una serie de 
  # tiempo con los valores correspondientes a cada mes de cada año, se usaron 
  # los comandos str y class para confirmar lo planteado

match.ts
str(match.ts)
class(match.ts)

# Pregunta 4
# Grafica la serie de tiempo.

  # Finalmente se paso a graficar la serie de tiempo mediante el comando "plot"
  # y se establecio mediante el comando "points" los meses dentro de la grafica
  # de la serie de tiempo del promedio de goles mensuales por año

plot(match.ts, type = "l", ylab = "Goles promedio", xlab = "Tiempo", 
     main = "Promedio de goles",
     sub = "Serie mensual: Enero de 2010 a Diciembre de 2019")

  # Para mejor visualizacion de este comando, ampliar la imagen de la gráfica 
  # creada, en todo caso es opcional este comando si esta saturado de 
  # información la grafica al ser muchos meses de distintos años

points(y = match.ts, x = time(match.ts),
       pch = as.vector(season(match.ts)))
