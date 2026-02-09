# Cargar el csv
datos <- read.csv("datos_nervios.csv")

# Agregamos nuevas columnas (operaciones)

datos$Duracion <- (datos$Lat_Pico_ms - datos$Lat_Inicio_ms) * 2

datos$Area <- ((datos$Lat_Pico_ms - datos$Lat_Inicio_ms) * datos$Amplitud_uV) * 2

datos$Velocidad <- (1.5 / datos$Lat_Pico_ms)

datos$Desconocido_uno <- (1.5) / (datos$Lat_Pico_ms - datos$Lat_Inicio_ms)

datos$Desconocido_dos <- (1.5) / datos$Lat_Inicio_ms

# Guardamos nuevo csv
write.csv(datos, "datos_nervios_actualizados.csv", row.names = FALSE)