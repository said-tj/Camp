# Función auxiliar
promedio_general <- function(df) {
  medias <- c(
    Basal = mean(df$Basal, na.rm = TRUE),
    Inicio_Act = mean(df$Inicio_Act, na.rm = TRUE),
    Mayor_Act = mean(df$Mayor_Act, na.rm = TRUE),
    Menor_Act = mean(df$Menor_Act, na.rm = TRUE)
  )
  mean(medias, na.rm = TRUE)
}


# Cálculo principal
datos <- list(
  r1 = read.csv("h_573_r_1_proximal.csv"),
  r2 = read.csv("h_573_r_2_proximal.csv"),
  r3 = read.csv("h_573_r_3_proximal.csv")
)

promedios <- sapply(datos, promedio_general)

cat("Promedio repetición 1:", promedios["r1"], "\n")
cat("Promedio repetición 2:", promedios["r2"], "\n")
cat("Promedio repetición 3:", promedios["r3"], "\n")
cat("Promedio resultante (3 repeticiones):", mean(promedios), "\n")