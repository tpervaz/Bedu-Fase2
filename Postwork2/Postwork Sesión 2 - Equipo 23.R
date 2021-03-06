# Postwork Sesion 2 - Programaci�n y manipulaci�n de datos con R

# Equipo 23
# Francisco Ricardo Arredondo Almuina - frankk_arredondo@hotmail.com
# Tamara Ytanyu P�rez V�zquez - tamara.ytanyu@gmail.com
# Carlos Eduardo Vidal Villeda - charlie.lalo@hotmail.com
# Jesus Emanuel Serrano Molina - emanuel.serm@gmail.com

# OBJETIVO
  # Importar m�ltiples archivos csv a R
  # Observar algunas caracter�sticas y manipular los data frames
  # Combinar m�ltiples data frames en un �nico data frame

# REQUISITOS
  # Tener instalado R y RStudio
  # Haber realizado el prework y estudiado los ejemplos de la sesi�n.

# DESARROLLO
  # Ahora vamos a generar un c�mulo de datos mayor al que se ten�a, esta es una 
  # situaci�n habitual que se puede presentar para complementar un an�lisis, 
  # siempre es importante estar revisando las caracter�sticas o tipos de datos 
  # que tenemos, por si es necesario realizar alguna transformaci�n en las 
  # variables y poder hacer operaciones aritm�ticas si es el caso, adem�s de 
  # s�lo tener presente algunas de las variables, no siempre se requiere el uso 
  # de todas para ciertos procesamientos.

# Pregunta 1
# Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 
# de la primera divisi�n de la liga espa�ola a R, los datos los puedes encontrar 
# en el siguiente enlace: https://www.football-data.co.uk/spainm.php

  # Se cargo la libreria necesaria para realizar el problema planteado

library(dplyr)

  # Se descargaron los archivos correspondientes y se estableci� el directorio 
  # en donde con el comando "dir" y "lapply" se leyeron los archivos en conjunto
  # dentro de la variable "lista"

getwd()
setwd("C:/Users/Rito/Documents/UANL - Ing Aeronautica/Courses/Santander/BEDU - Data Science/Modulo 2 - Programaci�n y Estad�stica con R/Data/Football Spain/")
dir()
lista <- lapply(dir(), read.csv)

# Pregunta 2
# Obten una mejor idea de las caracter�sticas de los data frames al usar las 
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
# Con la funci�n select del paquete dplyr selecciona �nicamente las columnas 
# Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data 
# frames. (Hint: tambi�n puedes usar lapply).

  # Al ya tener cargado la libreria, se uso el comando "lapply" para seleccionar
  # las columnas correspondientes y se volvio a renombrar el mismo dataframe

lista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

  # Con los comandos "str" y "head" para ver las caracteristicas del dataframe, 
  # y confirmar que si se seleccionaron las columnas

str(lista)
head(lista)

# Pregunta 4
# Aseg�rate de que los elementos de las columnas correspondientes de los 
# nuevos data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para 
# arreglar las fechas). Con ayuda de la funci�n rbind forma un �nico data frame 
# que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la funci�n 
# do.call podr�a ser utilizada).

  # Con el comando "mutate" se cambio el formato de la columna "Date" con el 
  # comando "Date" de cada uno de las 3 temporadas que conforman el dataframe.
  # NOTA: La temporada 2017/2018 tiene el a�o diferente a las demas temporadas,
  # por lo que se uso "y" (min�scula) y "Y" (may�scula) para las dem�s temporadas

lista[[1]] <- mutate(lista[[1]], Date = as.Date(Date,"%d/%m/%y"))
lista[[2]] <- mutate(lista[[2]], Date = as.Date(Date,"%d/%m/%Y"))
lista[[3]] <- mutate(lista[[3]], Date = as.Date(Date,"%d/%m/%Y"))

  # Con el comando "do.call" se juntaron por filas mediante el comando "rbind"
  # las 3 temporadas que conformaban el dataframe y se renombro en el mismo 
  # dataframe "lista"

lista <- do.call(rbind,lista)

  # Para confirmar lo anterior hecho y ver las caracter�sticas del dataframe
  # se usaron los comandos "str", "head", "tail" y "View"

str(lista)
head(lista)
tail(lista)
View(lista)
