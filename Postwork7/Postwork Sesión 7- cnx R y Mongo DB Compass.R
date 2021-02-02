# Postwork.7 Alojar el fichero a un local host de MongoDB

# -----------------------Equipo 23----------------------------------
# Francisco Ricardo Arredondo Almuina - frankk_arredondo@hotmail.com
# Tamara Ytanyu Pérez Vázquez - tamara.ytanyu@gmail.com
# Carlos Eduardo Vidal Villeda - charlie.lalo@hotmail.com
# Jesus Emanuel Serrano Molina - emanuel.serm@gmail.com

# OBJETIVO
# Realizar el alojamiento del fichero de un fichero .csv a una base de datos 
# (BDD), en un local host de Mongodb a traves de R
# 
# DESARROLLO
# Utilizando el manejador de BDD Mongodb Compass (previamente instalado), 
# deberás de realizar las siguientes acciones:
#   
#1.- Alojar el fichero data.csv en una base de datos llamada match_games, 
# nombrando al collection como match
#2.- Una vez hecho esto, realizar un count para conocer el número de registros 
# que se tiene en la base
# -----------------------------> 1140 registros encontrados

#install.packages("mongolite")
library(mongolite) #crea conecciones/interfaces  R <-> Mongo
library(dplyr)
#Creando una conexión: 'localhost

#despues de caargar los datos a MongoDB Compass se obtiene el url del Cluster
# con la opción de conect to cluster en Mongo Atlas
#------se extrae solo el database "match"
data.mon <- mongo("match", url ="mongodb+srv://CasitaMaincra:.Manu..67MGA@cluster0.rkpjw.mongodb.net/match_games?retryWrites=true&w=majority")
data.mon$count()#devuelve 1140 que es el numero de archivos
n<-data.mon$find("{}")
dplyr::glimpse(n)

# Realiza una consulta utilizando la sintaxis de Mongodb, en la base de 
# datos para conocer el número de goles que metió el Real Madrid el 20 
# de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

#verificando en que fechas sí jugó el Real Madrid
#Ninguna coincide con un 20 de Diciembre
gol.1 <- data.mon$find('{
          "$or":[{"HomeTeam":"Real Madrid"},{"AwayTeam":"Real Madrid"}]
                      }')
View(gol.1)
#Los únicos juegos que se serlizaron un 20 de Diciembre fueron en el año 2017
# y corresponden a las filas 161 y 162
gol.f <- data.mon$find('{
          "$or":[{"Date":"2017-12-20"},{"Date":"2018-12-20"},
          {"Date":"2018-19-20"},{"Date":"2020-12-20"}]
                      }')
gol.f
#nos desconectamos de esta colección
data.mon$disconnect(gc = TRUE) 
#debido a que en estos conjunto de datos no se encuentran datos de juegos en 
#las fechas solicitadas buscamos en un la página https://www.football-data.co.uk/spainm.php
#y encontramos uno con titulo Season 2015/2016 de la primera temporada y lo
#cargamos a nuestro cluster en Mongo Compass

data.db <- mongo("match_2", url ="mongodb+srv://CasitaMaincra:.Manu..67MGA@cluster0.rkpjw.mongodb.net/match_games?retryWrites=true&w=majority")
data.db$count()#devuelve 380 que es el numero de archivos
d.db<-data.db$find("{}")
dplyr::glimpse(d.db)

game.20 <- data.db$find('{
                        "Date": "20/12/15"
}')
#buscando partidos del 20 de diciembre del 2015 donde jugo Real Madrid
gol.RM <- data.db$find(query = '{
          "$and":[{"Date":"20/12/15"},
          {"$or":[{"HomeTeam":"Real Madrid"},{"AwayTeam":"Real Madrid"}]}]
                      }',
                       fields = '{"_id":false,"Date":true, "HomeTeam":true,
                       "AwayTeam":true, "FTHG":true, "FTAG":true}')
#Fuaaaa que goleada al Rasho Vallecano
#Resultado Final 10-2 favor Real Madrid
#   Por último, no olvides cerrar la conexión con la BDD
data.db$disconnect(gc = TRUE) 
