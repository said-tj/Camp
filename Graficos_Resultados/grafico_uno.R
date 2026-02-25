# ============================================================
# GRÁFICA 1: Barras agrupadas por región - Dos paneles
# Método Clásico (PolyVIEW) vs Método Alternativo (R)
# ============================================================

# Librerías necesarias
library(ggplot2)
library(dplyr)
library(gridExtra)

# ============================================================
# DATOS
# ============================================================

# Método Clásico (PolyVIEW)
datos_clasico <- data.frame(
  Especimen = c("H_551", "H_563", "H_564", "H_573",
                "H_551", "H_563", "H_564", "H_573",
                "H_551", "H_563", "H_564", "H_573"),
  Region = c(rep("Distal", 4), rep("Medial", 4), rep("Proximal", 4)),
  Magnitud = c(1.0850, 6.0351, 3.2103, 1.7653,
               1.5934, 5.9724, 0.8079, 1.4089,
               1.6815, 5.8265, 3.5614, 1.2420)
)

# Método Alternativo (R)
datos_alternativo <- data.frame(
  Especimen = c("H_551", "H_563", "H_564", "H_573",
                "H_551", "H_563", "H_564", "H_573",
                "H_551", "H_563", "H_564", "H_573"),
  Region = c(rep("Distal", 4), rep("Medial", 4), rep("Proximal", 4)),
  Magnitud = c(0.0049, 0.0269, 0.0071, 0.0057,
               0.0052, 0.0269, 0.0095, 0.0043,
               0.0040, 0.0184, 0.0088, 0.0041)
)

# Ordenar regiones
orden_regiones <- c("Distal", "Medial", "Proximal")
datos_clasico$Region <- factor(datos_clasico$Region, levels = orden_regiones)
datos_alternativo$Region <- factor(datos_alternativo$Region, levels = orden_regiones)

# ============================================================
# COLORES
# ============================================================

colores_especimenes <- c(
  "H_551" = "#001F3F",
  "H_563" = "#1F3B4D",
  "H_564" = "#36454F",
  "H_573" = "#536872"
)

# ============================================================
# PANEL A: Método Clásico (PolyVIEW)
# ============================================================

panel_A <- ggplot(datos_clasico, 
                  aes(x = Region, y = Magnitud, fill = Especimen)) +
  geom_bar(stat = "identity", 
           position = position_dodge(width = 0.8),
           width = 0.7,
           color = "black",
           linewidth = 0.3) +
  scale_fill_manual(values = colores_especimenes,
                    name = "Espécimen") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = "A) Método Clásico (PolyVIEW)",
    x = "Región Uretral",
    y = expression("Densidad Espectral de Amplitud (V"["pk"]*"/√Hz)")
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(size = 12, face = "bold", hjust = 0),
    axis.title = element_text(size = 11),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 10, face = "bold"),
    legend.text = element_text(size = 9),
    legend.position = "right",
    panel.grid.major.y = element_line(color = "grey85", linewidth = 0.4)
  )

# ============================================================
# PANEL B: Método Alternativo (R)
# ============================================================

panel_B <- ggplot(datos_alternativo, 
                  aes(x = Region, y = Magnitud, fill = Especimen)) +
  geom_bar(stat = "identity", 
           position = position_dodge(width = 0.8),
           width = 0.7,
           color = "black",
           linewidth = 0.3) +
  scale_fill_manual(values = colores_especimenes,
                    name = "Espécimen") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = "B) Método Alternativo (R)",
    x = "Región Uretral",
    y = expression("Densidad Espectral de Amplitud (V"["pk"]*"/√Hz)")
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(size = 12, face = "bold", hjust = 0),
    axis.title = element_text(size = 11),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 10, face = "bold"),
    legend.text = element_text(size = 9),
    legend.position = "right",
    panel.grid.major.y = element_line(color = "grey85", linewidth = 0.4)
  )

# ============================================================
# UNIR PANELES Y GUARDAR
# ============================================================

figura_1 <- grid.arrange(
  panel_A, panel_B,
  ncol = 1,
  top = grid::textGrob(
    "Figura 1. Densidad espectral de amplitud del EEU por región uretral y método de análisis",
    gp = grid::gpar(fontsize = 11, fontface = "bold")
  )
)

# Guardar en alta resolución para tesis
ggsave(
  filename = "Figura1_Barras_Agrupadas.png",
  plot = figura_1,
  width = 8,
  height = 10,
  dpi = 300,
  units = "in"
)

cat("Gráfica guardada como: Figura1_Barras_Agrupadas.png\n")