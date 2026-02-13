datos <- read.csv("distal.csv")

promedio_basal <- mean(datos$Basal, na.rm = TRUE)
promedio_inicio <- mean(datos$Inicio_Act, na.rm = TRUE)
promedio_mayor <- mean(datos$Mayor_Act, na.rm = TRUE)
promedio_menor <- mean(datos$Menor_Act, na.rm = TRUE)

promedio_general <- mean(c(promedio_basal, promedio_inicio, promedio_mayor, promedio_menor))
cat("El promedio general es:", promedio_general, "\n")