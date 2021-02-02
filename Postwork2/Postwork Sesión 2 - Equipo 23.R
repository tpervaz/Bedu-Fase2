# Postwork Sesion 2 - Programación y manipulación de datos con R

# Equipo 23
# Francisco Ricardo Arredondo Almuina - frankk_arredondo@hotmail.com
# Tamara Ytanyu Pérez Vázquez - tamara.ytanyu@gmail.com
# Carlos Eduardo Vidal Villeda - charlie.lalo@hotmail.com
# Jesus Emanuel Serrano Molina - emanuel.serm@gmail.com

# OBJETIVO
  # Importar múltiples archivos csv a R
  # Observar algunas características y manipular los data frames
  # Combinar múltiples data frames en un único data frame

# REQUISITOS
  # Tener instalado R y RStudio
  # Haber realizado el prework y estudiado los ejemplos de la sesión.

# DESARROLLO
  # Ahora vamos a generar un cúmulo de datos mayor al que se tenía, esta es una 
  # situación habitual que se puede presentar para complementar un análisis, 
  # siempre es importante estar revisando las características o tipos de datos 
  # que tenemos, por si es necesario realizar alguna transformación en las 
  # variables y poder hacer operaciones aritméticas si es el caso, además de 
  # sólo tener presente algunas de las variables, no siempre se requiere el uso 
  # de todas para ciertos procesamientos.

# Pregunta 1
# Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 
# de la primera división de la liga española a R, los datos los puedes encontrar 
# en el siguiente enlace: https://www.football-data.co.uk/spainm.php

  # Se cargo la libreria necesaria para realizar el problema planteado

library(dplyr)

  # Se descargaron los archivos correspondientes y se estableció el directorio 
  # en donde con el comando "dir" y "lapply" se leyeron los archivos en conjunto
  # dentro de la variable "lista"

getwd()
setwd("C:/Users/Rito/Documents/UANL - Ing Aeronautica/Courses/Santander/BEDU - Data Science/Modulo 2 - Programación y Estadística con R/Data/Football Spain/")
dir()
lista <- lapply(dir(), read.csv)

# Pregunta 2
# Obten una mejor idea de las características de los data frames al usar las 
# funciones: str, head, View y summary.

  # Se usaron las funciones "str", "head", "View" y "summary" para ver las 
  # caracteristicas del dataframe "lista" el cual esta compuesto de 3 archivos
  # csv, correspondiente de cada temporada

str(lista)
str(lista[[1]]);str(lista[[2]]);str(lista[[3]]);

head(lista)
head(lista[[1]]);head(lista[[2]]);head(lista[[3]]);

View(lista)
View(lista[[1]]);View(lista[[2]]);View(lista[[3]]);

summary(lista)
summary(lista[[1]]);summary(lista[2]);summary(lista[3])

# Pregunta 3
# Con la función select del paquete dplyr selecciona únicamente las columnas 
# Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data 
# frames. (Hint: también puedes usar lapply).

  # Al ya tener cargado la libreria, se uso el comando "lapply" para seleccionar
  # las columnas correspondientes y se volvio a renombrar el mismo dataframe

lista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

  # Con los comandos "str" y "head" para ver las caracteristicas del dataframe, 
  # y confirmar que si se seleccionaron las columnas

str(lista)
head(lista)

# Pregunta 4
# Asegúrate de que los elementos de las columnas correspondientes de los 
# nuevos data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para 
# arreglar las fechas). Con ayuda de la función rbind forma un único data frame 
# que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función 
# do.call podría ser utilizada).

  # Con el comando "mutate" se cambio el formato de la columna "Date" con el 
  # comando "Date" de cada uno de las 3 temporadas que conforman el dataframe.
  # NOTA: La temporada 2017/2018 tiene el año diferente a las demas temporadas,
  # por lo que se uso "y" (minúscula) y "Y" (mayúscula) para las demás temporadas

lista[[1]] <- mutate(lista[[1]], Date = as.Date(Date,"%d/%m/%y"))
lista[[2]] <- mutate(lista[[2]], Date = as.Date(Date,"%d/%m/%Y"))
lista[[3]] <- mutate(lista[[3]], Date = as.Date(Date,"%d/%m/%Y"))

  # Con el comando "do.call" se juntaron por filas mediante el comando "rbind"
  # las 3 temporadas que conformaban el dataframe y se renombro en el mismo 
  # dataframe "lista"

lista <- do.call(rbind,lista)

  # Para confirmar lo anterior hecho y ver las características del dataframe
  # se usaron los comandos "str", "head", "tail" y "View"

str(lista)
head(lista)
tail(lista)
View(lista)
