datos_uno <- read.csv("h_551_r_1_distal.csv")

promedio_uno_basal <- mean(datos_uno$Basal, na.rm = TRUE)
promedio_uno_inicio <- mean(datos_uno$Inicio_Act, na.rm = TRUE)
promedio_uno_mayor <- mean(datos_uno$Mayor_Act, na.rm = TRUE)
promedio_uno_menor <- mean(datos_uno$Menor_Act, na.rm = TRUE)

promedio_uno_general <- mean(c(promedio_uno_basal, promedio_uno_inicio, promedio_uno_mayor, promedio_uno_menor))
cat("El promedio general de la repetición uno es:", promedio_uno_general, "\n")




datos_dos <- read.csv("h_551_r_2_distal.csv")

promedio_dos_basal <- mean(datos_dos$Basal, na.rm = TRUE)
promedio_dos_inicio <- mean(datos_dos$Inicio_Act, na.rm = TRUE)
promedio_dos_mayor <- mean(datos_dos$Mayor_Act, na.rm = TRUE)
promedio_dos_menor <- mean(datos_dos$Menor_Act, na.rm = TRUE)

promedio_dos_general <- mean(c(promedio_dos_basal, promedio_dos_inicio, promedio_dos_mayor, promedio_dos_menor))
cat("El promedio general de la repetición dos es:", promedio_dos_general, "\n")




datos_tres <- read.csv("h_551_r_3_distal.csv")

promedio_tres_basal <- mean(datos_tres$Basal, na.rm = TRUE)
promedio_tres_inicio <- mean(datos_tres$Inicio_Act, na.rm = TRUE)
promedio_tres_mayor <- mean(datos_tres$Mayor_Act, na.rm = TRUE)
promedio_tres_menor <- mean(datos_tres$Menor_Act, na.rm = TRUE)

promedio_tres_general <- mean(c(promedio_tres_basal, promedio_tres_inicio, promedio_tres_mayor, promedio_tres_menor))
cat("El promedio general de la repetición tres es:", promedio_tres_general, "\n")



promedio_resultante <- mean(c(promedio_uno_general, promedio_dos_general, promedio_tres_general))
cat("El promedio resultante es:", promedio_resultante, "\n")

