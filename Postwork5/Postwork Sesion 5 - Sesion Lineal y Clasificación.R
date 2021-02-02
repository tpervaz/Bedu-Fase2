# Postwork Sesion 5 - Sesion Lineal y Clasificación

# Equipo 23
# Francisco Ricardo Arredondo Almuina - frankk_arredondo@hotmail.com
# Tamara Ytanyu Pérez Vázquez - tamara.ytanyu@gmail.com
# Carlos Eduardo Vidal Villeda - charlie.lalo@hotmail.com
# Jesus Emanuel Serrano Molina - emanuel.serm@gmail.com

# Pregunta 1
# A partir del conjunto de datos de soccer de la liga española de las temporadas 
# 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, que contenga las 
# columnas date, home.team, home.score, away.team y away.score; esto lo puedes hacer 
# con ayuda de la función select del paquete dplyr. Luego crea un directorio de trabajo 
# y con ayuda de la función write.csv guarde el data frame como un archivo csv con nombre 
# soccer.csv. Puedes colocar como argumento row.names = FALSE en write.csv.

library(dplyr)

getwd()
setwd("C:/Users/Rito/Documents/UANL - Ing Aeronautica/Courses/Santander/BEDU - Data Science/Modulo 2 - Programación y Estadística con R/Data/Football Spain/")
dir()
SmallData <- lapply(dir(), read.csv)
SmallData <- lapply(SmallData, select, Date , HomeTeam, FTHG, AwayTeam, FTAG)

SmallData[[1]] <- mutate(SmallData[[1]], Date = as.Date(Date,"%d/%m/%y"))
SmallData[[2]] <- mutate(SmallData[[2]], Date = as.Date(Date,"%d/%m/%Y"))
SmallData[[3]] <- mutate(SmallData[[3]], Date = as.Date(Date,"%d/%m/%Y"))

SmallData <- do.call(rbind,SmallData)
colnames(SmallData) <- c("date", "home.team", "home.score", "away.team", "away.score")
head(SmallData)

setwd("C:/Users/Rito/Documents/UANL - Ing Aeronautica/Courses/Santander/BEDU - Data Science/Modulo 2 - Programación y Estadística con R/5. Regresión Lineal y Clasificación/")
write.csv(SmallData, file = "soccer.csv", row.names = FALSE)

# Pregunta 2
# Con la función create.fbRanks.dataframes del paquete fbRanks importa el archivo 
# soccer.csv a R y al mismo tiempo asignarlo a una variable llamada listasoccer. 
# Se creará una lista con los elementos scores y teams que son data frames listos 
# para la función rank.teams. Asigna estos data frames a variables llamadas 
# anotaciones y equipos.

library(fbRanks)

listasoccer <- create.fbRanks.dataframes(scores.file = "soccer.csv",
                                         date.format = "%Y-%m-%d")

anotaciones <- na.omit(listasoccer$scores)
equipos <- na.omit(listasoccer$teams)

# Pregunta 3
# Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan y 
# que correspondan a las fechas en las que se jugaron partidos. Crea una variable 
# llamada n que contenga el número de fechas diferentes. Posteriormente, con la función 
# rank.teams y usando como argumentos los data frames anotaciones y equipos, crea un 
# ranking de equipos usando únicamente datos desde la fecha inicial y hasta la penúltima 
# fecha en la que se jugaron partidos, estas fechas las deberá especificar en max.date 
# y min.date. Guarda los resultados con el nombre ranking.

fecha <- unique(anotaciones$date)
n <- length(fechas)

ranking <- rank.teams(anotaciones, equipos,
           max.date = "2017-08-18", min.date = "2020-07-16")

# Pregunta 4
# Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo 
# visitante gana o el resultado es un empate para los partidos que se jugaron en la última 
# fecha del vector de fechas fecha. Esto lo puedes hacer con ayuda de la función predict 
# y usando como argumentos ranking y fecha[n] que deberá especificar en date.

predict(ranking, fecha[n])

predict(ranking,
        max.date="2020-07-16", min.date="2020-07-17", date.format="%Y-%m-%d",
        rnd=TRUE, silent=FALSE, show.matches=TRUE, 
        verbose=FALSE, remove.outliers=TRUE, n=10000)



