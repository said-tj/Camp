################################################################################
# Script para Análisis Electrofisiológico - Gráficos Violin Plot
# Autor: Análisis de datos de nervios (Femoral y Peroneo)
# Fecha: Febrero 2026
################################################################################

# ==============================================================================
# 1. INSTALACIÓN Y CARGA DE PAQUETES
# ==============================================================================

# Lista de paquetes necesarios
paquetes <- c("ggplot2", "dplyr", "tidyr", "ggbeeswarm", "gridExtra", "grid")

# Instalar paquetes que no estén instalados
paquetes_faltantes <- paquetes[!(paquetes %in% installed.packages()[,"Package"])]
if(length(paquetes_faltantes)) install.packages(paquetes_faltantes)

# Cargar librerías
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggbeeswarm)
library(gridExtra)
library(grid)

# ==============================================================================
# 2. LECTURA Y PREPARACIÓN DE DATOS
# ==============================================================================

# Leer datos
datos <- read.csv("datos_nervios.csv", stringsAsFactors = FALSE)

# Verificar estructura
cat("\n=== ESTRUCTURA DE DATOS ===\n")
str(datos)
cat("\nPrimeras filas:\n")
head(datos)

# Preparar datos
datos <- datos %>%
  mutate(
    # Convertir día a factor ordenado
    Dia_Post_Avulsion = factor(Dia_Post_Avulsion, levels = c(4, 15, 28)),
    
    # Crear nombres cortos para condiciones
    Condicion_corta = factor(Condicion,
                             levels = c("SHAM", "ARV L6", "ARV L6+PPyI"),
                             labels = c("Sham", "L6 VRA", "L6 VRA+PPyI"))
  )

# Resumen de datos
cat("\n=== RESUMEN DE DATOS ===\n")
cat("Total de registros:", nrow(datos), "\n")
cat("\nRegistros por condición:\n")
print(table(datos$Condicion_corta))
cat("\nRegistros por día:\n")
print(table(datos$Dia_Post_Avulsion))
cat("\nRegistros por nervio:\n")
print(table(datos$Nervio))

# ==============================================================================
# 3. CONFIGURACIÓN DE COLORES Y TEMA
# ==============================================================================

# Colores basados en las imágenes de referencia
colores <- c(
  "Sham" = "#FFFFFF",           # Blanco
  "L6 VRA" = "#D2691E",          # Chocolate/Naranja
  "L6 VRA+PPyI" = "#654321"      # Marrón oscuro
)

# Tema personalizado para los gráficos
tema_personalizado <- theme_classic(base_size = 12) +
  theme(
    plot.title = element_text(hjust = 0, face = "bold", size = 16),
    axis.title.x = element_text(size = 12, margin = margin(t = 10)),
    axis.title.y = element_text(size = 12, margin = margin(r = 10)),
    axis.text = element_text(size = 11, color = "black"),
    axis.line = element_line(color = "black", size = 0.5),
    axis.ticks = element_line(color = "black", size = 0.5),
    legend.position = "bottom",
    legend.title = element_blank(),
    legend.text = element_text(size = 11),
    legend.key.size = unit(1, "cm"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA)
  )

# ==============================================================================
# 4. FUNCIÓN PARA CREAR GRÁFICOS
# ==============================================================================

crear_grafico_violin <- function(data, variable, titulo, y_label, 
                                 y_limits, y_breaks, nervio = "Femoral") {
  
  # Filtrar datos
  df <- data %>%
    filter(Nervio == nervio, !is.na(!!sym(variable)))
  
  if(nrow(df) == 0) {
    cat("\nADVERTENCIA: No hay datos para", variable, "en nervio", nervio, "\n")
    return(NULL)
  }
  
  # Crear gráfico base
  p <- ggplot(df, aes(x = Dia_Post_Avulsion, y = !!sym(variable), 
                      fill = Condicion_corta)) +
    
    # Violin plots
    geom_violin(position = position_dodge(0.9), 
                trim = TRUE, 
                alpha = 0.7, 
                scale = "width",
                color = "black",
                size = 0.3) +
    
    # Box plots superpuestos
    geom_boxplot(position = position_dodge(0.9), 
                 width = 0.2, 
                 alpha = 0,
                 outlier.shape = NA,
                 color = "black",
                 size = 0.5) +
    
    # Puntos individuales con beeswarm
    geom_beeswarm(position = position_dodge(0.9),
                  size = 1.5,
                  alpha = 0.7,
                  dodge.width = 0.9,
                  cex = 2.5,
                  color = "black") +
    
    # Línea horizontal en y=0
    geom_hline(yintercept = 0, linetype = "dotted", 
               color = "gray40", size = 0.5) +
    
    # Escalas
    scale_fill_manual(values = colores) +
    scale_y_continuous(limits = y_limits, breaks = y_breaks) +
    
    # Etiquetas
    labs(title = titulo,
         x = "Day post-avulsion",
         y = y_label) +
    
    # Tema
    tema_personalizado
  
  return(p)
}

# ==============================================================================
# 5. FUNCIÓN PARA ANÁLISIS ESTADÍSTICO
# ==============================================================================

analisis_estadistico <- function(data, variable, nervio = "Femoral") {
  
  cat("\n", rep("=", 70), "\n", sep = "")
  cat("ANÁLISIS ESTADÍSTICO:", variable, "(Nervio:", nervio, ")\n")
  cat(rep("=", 70), "\n", sep = "")
  
  # Filtrar datos
  df <- data %>%
    filter(Nervio == nervio, !is.na(!!sym(variable)))
  
  if(nrow(df) == 0) {
    cat("No hay datos disponibles\n")
    return(invisible(NULL))
  }
  
  # Resumen descriptivo
  cat("\nESTADÍSTICA DESCRIPTIVA:\n")
  resumen <- df %>%
    group_by(Dia_Post_Avulsion, Condicion_corta) %>%
    summarise(
      n = n(),
      Media = mean(!!sym(variable), na.rm = TRUE),
      DE = sd(!!sym(variable), na.rm = TRUE),
      Mediana = median(!!sym(variable), na.rm = TRUE),
      Min = min(!!sym(variable), na.rm = TRUE),
      Max = max(!!sym(variable), na.rm = TRUE),
      .groups = 'drop'
    )
  print(resumen, n = Inf)
  
  # ANOVA de dos vías
  cat("\nANOVA DE DOS VÍAS:\n")
  formula_anova <- as.formula(paste(variable, "~ Condicion_corta * Dia_Post_Avulsion"))
  
  tryCatch({
    modelo <- aov(formula_anova, data = df)
    print(summary(modelo))
    
    # Pruebas post-hoc por día
    cat("\nCOMPARACIONES POST-HOC POR DÍA (t-test):\n")
    
    for(dia in c("4", "15", "28")) {
      df_dia <- df %>% filter(Dia_Post_Avulsion == dia)
      
      if(nrow(df_dia) > 0) {
        cat("\n--- Día", dia, "---\n")
        
        # Comparaciones pareadas
        condiciones <- c("Sham", "L6 VRA", "L6 VRA+PPyI")
        
        for(i in 1:(length(condiciones)-1)) {
          for(j in (i+1):length(condiciones)) {
            
            grupo1 <- df_dia %>% 
              filter(Condicion_corta == condiciones[i]) %>% 
              pull(!!sym(variable))
            
            grupo2 <- df_dia %>% 
              filter(Condicion_corta == condiciones[j]) %>% 
              pull(!!sym(variable))
            
            if(length(grupo1) > 1 && length(grupo2) > 1) {
              test <- t.test(grupo1, grupo2)
              
              # Símbolo de significancia
              sig <- if(test$p.value < 0.001) "***"
              else if(test$p.value < 0.01) "**"
              else if(test$p.value < 0.05) "*"
              else "ns"
              
              cat(sprintf("  %s vs %s: p = %.4f %s\n", 
                         condiciones[i], condiciones[j], 
                         test$p.value, sig))
            }
          }
        }
      }
    }
  }, error = function(e) {
    cat("Error en análisis estadístico:", e$message, "\n")
  })
  
  cat("\n")
}

# ==============================================================================
# 6. GENERAR GRÁFICOS PRINCIPALES
# ==============================================================================

cat("\n\n")
cat("################################################################################\n")
cat("GENERANDO GRÁFICOS\n")
cat("################################################################################\n")

# GRÁFICO A: Amplitud del reflejo
cat("\nGenerando Gráfico A - Amplitud...\n")
grafico_A <- crear_grafico_violin(
  data = datos,
  variable = "Amplitud_uV",
  titulo = "A)",
  y_label = "Amplitude of reflex\n(µV)",
  y_limits = c(-1000, 45000),
  y_breaks = seq(0, 40000, 10000),
  nervio = "Femoral"
)

if(!is.null(grafico_A)) {
  ggsave("Figura_A_Amplitud.png", grafico_A, 
         width = 8, height = 6, dpi = 300, bg = "white")
  cat("  ✓ Guardado: Figura_A_Amplitud.png\n")
}

# GRÁFICO B: Duración del reflejo
cat("\nGenerando Gráfico B - Duración...\n")
grafico_B <- crear_grafico_violin(
  data = datos,
  variable = "Duracion_ms",
  titulo = "B)",
  y_label = "Duration of reflex\n(ms)",
  y_limits = c(-0.2, 1.6),
  y_breaks = seq(0, 1.6, 0.4),
  nervio = "Femoral"
)

if(!is.null(grafico_B)) {
  ggsave("Figura_B_Duracion.png", grafico_B, 
         width = 8, height = 6, dpi = 300, bg = "white")
  cat("  ✓ Guardado: Figura_B_Duracion.png\n")
}

# GRÁFICO C: Latencia al pico
cat("\nGenerando Gráfico C - Latencia...\n")
grafico_C <- crear_grafico_violin(
  data = datos,
  variable = "Lat_Pico_ms",
  titulo = "C)",
  y_label = "Peak latency\n(ms)",
  y_limits = c(-0.2, 1.2),
  y_breaks = seq(0, 1.2, 0.3),
  nervio = "Femoral"
)

if(!is.null(grafico_C)) {
  ggsave("Figura_C_Latencia.png", grafico_C, 
         width = 8, height = 6, dpi = 300, bg = "white")
  cat("  ✓ Guardado: Figura_C_Latencia.png\n")
}

# GRÁFICO D: Velocidad de conducción
cat("\nGenerando Gráfico D - Velocidad...\n")
grafico_D <- crear_grafico_violin(
  data = datos,
  variable = "Velocidad_ms",
  titulo = "D)",
  y_label = "Conduction velocity\n(m/s)",
  y_limits = c(0, 4),
  y_breaks = seq(0, 4, 1),
  nervio = "Femoral"
)

if(!is.null(grafico_D)) {
  ggsave("Figura_D_Velocidad.png", grafico_D, 
         width = 8, height = 6, dpi = 300, bg = "white")
  cat("  ✓ Guardado: Figura_D_Velocidad.png\n")
}

# ==============================================================================
# 7. CREAR PANEL COMBINADO (A, B, C)
# ==============================================================================

cat("\nGenerando panel combinado...\n")

if(!is.null(grafico_A) && !is.null(grafico_B) && !is.null(grafico_C)) {
  
  # Extraer leyenda
  extraer_leyenda <- function(un_ggplot) {
    tmp <- ggplot_gtable(ggplot_build(un_ggplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)
  }
  
  leyenda <- extraer_leyenda(grafico_A)
  
  # Gráficos sin leyenda
  g_A <- grafico_A + theme(legend.position = "none")
  g_B <- grafico_B + theme(legend.position = "none")
  g_C <- grafico_C + theme(legend.position = "none")
  
  # Combinar
  panel_ABC <- arrangeGrob(
    g_A, g_B, g_C, leyenda,
    ncol = 1,
    heights = c(1, 1, 1, 0.15)
  )
  
  # Guardar
  ggsave("Panel_ABC_Combinado.png", panel_ABC,
         width = 8, height = 15, dpi = 300, bg = "white")
  
  cat("  ✓ Guardado: Panel_ABC_Combinado.png\n")
}

# ==============================================================================
# 8. ANÁLISIS ESTADÍSTICO COMPLETO
# ==============================================================================

cat("\n\n")
cat("################################################################################\n")
cat("ANÁLISIS ESTADÍSTICO\n")
cat("################################################################################\n")

# Análisis para cada variable
analisis_estadistico(datos, "Amplitud_uV", "Femoral")
analisis_estadistico(datos, "Duracion_ms", "Femoral")
analisis_estadistico(datos, "Lat_Pico_ms", "Femoral")
analisis_estadistico(datos, "Velocidad_ms", "Femoral")

# ==============================================================================
# 9. ANÁLISIS ADICIONAL PARA NERVIO PERONEO (OPCIONAL)
# ==============================================================================

cat("\n\n")
cat("################################################################################\n")
cat("GRÁFICOS PARA NERVIO PERONEO\n")
cat("################################################################################\n")

# Verificar si hay datos de peroneo
datos_peroneo <- datos %>% filter(Nervio == "Peroneo")

if(nrow(datos_peroneo) > 0) {
  
  cat("\nGenerando gráficos para nervio Peroneo...\n")
  
  # Gráfico Peroneo - Amplitud
  grafico_peroneo_A <- crear_grafico_violin(
    data = datos,
    variable = "Amplitud_uV",
    titulo = "A) Peroneo",
    y_label = "Amplitude of reflex\n(µV)",
    y_limits = c(-1000, 45000),
    y_breaks = seq(0, 40000, 10000),
    nervio = "Peroneo"
  )
  
  if(!is.null(grafico_peroneo_A)) {
    ggsave("Figura_Peroneo_A_Amplitud.png", grafico_peroneo_A,
           width = 8, height = 6, dpi = 300, bg = "white")
    cat("  ✓ Guardado: Figura_Peroneo_A_Amplitud.png\n")
  }
  
  # Análisis estadístico para peroneo
  cat("\nAnálisis estadístico para nervio Peroneo:\n")
  analisis_estadistico(datos, "Amplitud_uV", "Peroneo")
  analisis_estadistico(datos, "Duracion_ms", "Peroneo")
  analisis_estadistico(datos, "Lat_Pico_ms", "Peroneo")
  analisis_estadistico(datos, "Velocidad_ms", "Peroneo")
  
} else {
  cat("\nNo hay datos suficientes para nervio Peroneo\n")
}

# ==============================================================================
# 10. EXPORTAR TABLA DE RESULTADOS
# ==============================================================================

cat("\n\n")
cat("################################################################################\n")
cat("EXPORTANDO TABLAS DE RESULTADOS\n")
cat("################################################################################\n")

# Crear tabla resumen
tabla_resumen <- datos %>%
  filter(Nervio == "Femoral") %>%
  group_by(Dia_Post_Avulsion, Condicion_corta) %>%
  summarise(
    n_Amplitud = sum(!is.na(Amplitud_uV)),
    Media_Amplitud = mean(Amplitud_uV, na.rm = TRUE),
    DE_Amplitud = sd(Amplitud_uV, na.rm = TRUE),
    
    n_Duracion = sum(!is.na(Duracion_ms)),
    Media_Duracion = mean(Duracion_ms, na.rm = TRUE),
    DE_Duracion = sd(Duracion_ms, na.rm = TRUE),
    
    n_Latencia = sum(!is.na(Lat_Pico_ms)),
    Media_Latencia = mean(Lat_Pico_ms, na.rm = TRUE),
    DE_Latencia = sd(Lat_Pico_ms, na.rm = TRUE),
    
    n_Velocidad = sum(!is.na(Velocidad_ms)),
    Media_Velocidad = mean(Velocidad_ms, na.rm = TRUE),
    DE_Velocidad = sd(Velocidad_ms, na.rm = TRUE),
    
    .groups = 'drop'
  )

# Guardar tabla
write.csv(tabla_resumen, "Tabla_Resumen_Resultados.csv", row.names = FALSE)
cat("\n✓ Guardado: Tabla_Resumen_Resultados.csv\n")

# Mostrar tabla
cat("\nTabla de Resumen (primeras filas):\n")
print(head(tabla_resumen, 10))

# ==============================================================================
# 11. RESUMEN FINAL
# ==============================================================================

cat("\n\n")
cat("################################################################################\n")
cat("ANÁLISIS COMPLETADO EXITOSAMENTE\n")
cat("################################################################################\n\n")

cat("Archivos generados:\n")
cat("  • Figura_A_Amplitud.png\n")
cat("  • Figura_B_Duracion.png\n")
cat("  • Figura_C_Latencia.png\n")
cat("  • Figura_D_Velocidad.png\n")
cat("  • Panel_ABC_Combinado.png\n")
cat("  • Tabla_Resumen_Resultados.csv\n")

if(nrow(datos_peroneo) > 0) {
  cat("  • Figura_Peroneo_A_Amplitud.png\n")
}

cat("\nTodos los gráficos están en alta resolución (300 DPI)\n")
cat("listos para publicación científica.\n\n")

cat("Para personalizar:\n")
cat("  1. Ajusta los colores en la línea 60\n")
cat("  2. Modifica rangos de ejes en las llamadas a crear_grafico_violin()\n")
cat("  3. Cambia el nervio a analizar (Femoral o Peroneo)\n\n")

cat("¡Script finalizado!\n")
cat(rep("=", 80), "\n", sep = "")
