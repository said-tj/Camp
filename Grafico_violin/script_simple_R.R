################################################################################
# SCRIPT SIMPLIFICADO - Gráficos Violin Plot
# Versión rápida y fácil de usar
################################################################################

# ==============================================================================
# PASO 1: Instalar y cargar paquetes
# ==============================================================================

# Ejecutar solo la primera vez:
# install.packages(c("ggplot2", "dplyr", "tidyr", "ggbeeswarm", "gridExtra"))

library(ggplot2)
library(dplyr)
library(tidyr)
library(ggbeeswarm)
library(gridExtra)
library(grid)

# ==============================================================================
# PASO 2: Leer datos
# ==============================================================================

datos <- read.csv("datos_nervios.csv", stringsAsFactors = FALSE)

# Preparar datos
datos <- datos %>%
  mutate(
    Dia_Post_Avulsion = factor(Dia_Post_Avulsion, levels = c(4, 15, 28)),
    Condicion_corta = factor(Condicion,
                             levels = c("SHAM", "ARV L6", "ARV L6+PPyI"),
                             labels = c("Sham", "L6 VRA", "L6 VRA+PPyI"))
  )

# ==============================================================================
# PASO 3: Configurar colores
# ==============================================================================

colores <- c("Sham" = "#FFFFFF", 
             "L6 VRA" = "#D2691E", 
             "L6 VRA+PPyI" = "#654321")

# ==============================================================================
# PASO 4: Crear función de gráfico
# ==============================================================================

graficar <- function(variable, titulo, ylabel, ylim, ybreaks, nervio = "Femoral") {
  
  df <- datos %>% filter(Nervio == nervio, !is.na(!!sym(variable)))
  
  ggplot(df, aes(x = Dia_Post_Avulsion, y = !!sym(variable), fill = Condicion_corta)) +
    geom_violin(position = position_dodge(0.9), trim = TRUE, alpha = 0.7, 
                scale = "width", color = "black", size = 0.3) +
    geom_boxplot(position = position_dodge(0.9), width = 0.2, alpha = 0,
                 outlier.shape = NA, color = "black", size = 0.5) +
    geom_beeswarm(position = position_dodge(0.9), size = 1.5, alpha = 0.7,
                  dodge.width = 0.9, cex = 2.5, color = "black") +
    geom_hline(yintercept = 0, linetype = "dotted", color = "gray40", size = 0.5) +
    scale_fill_manual(values = colores) +
    scale_y_continuous(limits = ylim, breaks = ybreaks) +
    labs(title = titulo, x = "Day post-avulsion", y = ylabel) +
    theme_classic(base_size = 12) +
    theme(
      plot.title = element_text(hjust = 0, face = "bold", size = 16),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 11, color = "black"),
      legend.position = "bottom",
      legend.title = element_blank(),
      panel.background = element_rect(fill = "white")
    )
}

# ==============================================================================
# PASO 5: Generar gráficos
# ==============================================================================

# Gráfico A - Amplitud
A <- graficar("Amplitud_uV", "A)", "Amplitude (µV)", 
              c(-1000, 45000), seq(0, 40000, 10000))
ggsave("A_Amplitud.png", A, width = 8, height = 6, dpi = 300, bg = "white")

# Gráfico B - Duración
B <- graficar("Duracion_ms", "B)", "Duration (ms)", 
              c(-0.2, 1.6), seq(0, 1.6, 0.4))
ggsave("B_Duracion.png", B, width = 8, height = 6, dpi = 300, bg = "white")

# Gráfico C - Latencia
C <- graficar("Lat_Pico_ms", "C)", "Peak latency (ms)", 
              c(-0.2, 1.2), seq(0, 1.2, 0.3))
ggsave("C_Latencia.png", C, width = 8, height = 6, dpi = 300, bg = "white")

# Gráfico D - Velocidad
D <- graficar("Velocidad_ms", "D)", "Velocity (m/s)", 
              c(0, 4), seq(0, 4, 1))
ggsave("D_Velocidad.png", D, width = 8, height = 6, dpi = 300, bg = "white")

cat("\n✓ Gráficos guardados exitosamente!\n")

# ==============================================================================
# PASO 6 (OPCIONAL): Panel combinado
# ==============================================================================

# Extraer leyenda
get_legend <- function(plot) {
  tmp <- ggplot_gtable(ggplot_build(plot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  tmp$grobs[[leg]]
}

leyenda <- get_legend(A)

# Crear panel
panel <- arrangeGrob(
  A + theme(legend.position = "none"),
  B + theme(legend.position = "none"),
  C + theme(legend.position = "none"),
  leyenda,
  ncol = 1,
  heights = c(1, 1, 1, 0.15)
)

ggsave("Panel_ABC.png", panel, width = 8, height = 15, dpi = 300, bg = "white")

cat("✓ Panel combinado guardado!\n\n")
