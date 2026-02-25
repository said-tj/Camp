# ============================================================
# GRÁFICA 2: Dispersión de correlación entre métodos
# Método Clásico (PolyVIEW) vs Método Alternativo (R)
# ============================================================

# Librerías necesarias
library(ggplot2)
library(dplyr)

# ============================================================
# DATOS
# ============================================================

datos_correlacion <- data.frame(
  Especimen = rep(c("H_551", "H_563", "H_564", "H_573"), times = 3),
  Region = c(rep("Distal", 4), rep("Medial", 4), rep("Proximal", 4)),
  Clasico = c(
    1.0850, 6.0351, 3.2103, 1.7653,  # Distal
    1.5934, 5.9724, 0.8079, 1.4089,  # Medial
    1.6815, 5.8265, 3.5614, 1.2420   # Proximal
  ),
  Alternativo = c(
    0.0049, 0.0269, 0.0071, 0.0057,  # Distal
    0.0052, 0.0269, 0.0095, 0.0043,  # Medial
    0.0040, 0.0184, 0.0088, 0.0041   # Proximal
  )
)

# Ordenar factor de región
datos_correlacion$Region <- factor(
  datos_correlacion$Region,
  levels = c("Distal", "Medial", "Proximal")
)

# ============================================================
# CALCULAR CORRELACIÓN DE SPEARMAN
# (Spearman es más apropiado que Pearson para n=12 pequeño)
# ============================================================

correlacion <- cor.test(
  datos_correlacion$Clasico,
  datos_correlacion$Alternativo,
  method = "spearman"
)

rho <- round(correlacion$estimate, 3)
pval <- round(correlacion$p.value, 4)

# Etiqueta para la gráfica
if (pval < 0.05) {
  etiqueta_cor <- paste0("rho de Spearman = ", rho, "\np = ", pval, " *")
} else {
  etiqueta_cor <- paste0("rho de Spearman = ", rho, "\np = ", pval)
}

cat("=== CORRELACIÓN DE SPEARMAN ===\n")
cat("rho =", rho, "\n")
cat("p-valor =", pval, "\n")

# ============================================================
# COLORES Y FORMAS
# ============================================================

colores_especimenes <- c(
  "H_551" = "#001F3F",
  "H_563" = "#1F3B4D",
  "H_564" = "#36454F",
  "H_573" = "#536872"
)

formas_regiones <- c(
  "Distal"   = 16,  # círculo sólido
  "Medial"   = 17,  # triángulo sólido
  "Proximal" = 15   # cuadrado sólido
)

# ============================================================
# GRÁFICA
# ============================================================

figura_2 <- ggplot(datos_correlacion,
                   aes(x = Clasico,
                       y = Alternativo,
                       color = Especimen,
                       shape = Region)) +
  
  # Línea de tendencia general (todos los puntos)
  geom_smooth(
    aes(group = 1),
    method = "lm",
    se = TRUE,
    color = "grey40",
    fill = "grey85",
    linewidth = 0.8,
    linetype = "dashed"
  ) +
  
  # Puntos
  geom_point(size = 4, stroke = 0.5) +
  
  # Etiquetas de cada punto
  ggrepel::geom_text_repel(
    aes(label = paste0(Especimen, "\n", Region)),
    size = 2.8,
    color = "grey20",
    box.padding = 0.4,
    point.padding = 0.3,
    segment.color = "grey60",
    segment.size = 0.3,
    max.overlaps = 20
  ) +
  
  # Anotación de correlación
  annotate(
    "text",
    x = min(datos_correlacion$Clasico) + 0.3,
    y = max(datos_correlacion$Alternativo) - 0.001,
    label = etiqueta_cor,
    hjust = 0,
    vjust = 1,
    size = 3.5,
    color = "grey20",
    fontface = "italic"
  ) +
  
  # Escalas
  scale_color_manual(values = colores_especimenes, name = "Espécimen") +
  scale_shape_manual(values = formas_regiones, name = "Región Uretral") +
  
  # Ejes
  labs(
    x = expression("Método Clásico (PolyVIEW) — V"["pk"]*"/√Hz"),
    y = expression("Método Alternativo (R) — V"["pk"]*"/√Hz")
  ) +
  
  # Tema
  theme_classic() +
  theme(
    plot.title = element_text(size = 11, face = "bold", hjust = 0.5),
    axis.title = element_text(size = 11),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 10, face = "bold"),
    legend.text = element_text(size = 9),
    legend.position = "right",
    panel.grid.major = element_line(color = "grey92", linewidth = 0.4)
  )

# ============================================================
# GUARDAR
# ============================================================

ggsave(
  filename = "Figura2_Correlacion.png",
  plot = figura_2,
  width = 8,
  height = 6,
  dpi = 300,
  units = "in"
)

cat("Gráfica guardada como: Figura2_Correlacion.png\n")