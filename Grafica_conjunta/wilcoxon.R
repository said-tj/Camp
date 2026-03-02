# ============================================================
# GRÁFICA 3: Barras comparativas por región con Wilcoxon pareado
# Método Clásico (PolyVIEW) vs Método Alternativo (R)
# Con valores numéricos en cada barra
# ============================================================

# Librerías necesarias
library(ggplot2)
library(dplyr)
library(tidyr)
library(gridExtra)

# ============================================================
# DATOS
# ============================================================

datos <- data.frame(
  Especimen = rep(c("H_551", "H_563", "H_564", "H_573"), times = 3),
  Region = c(rep("Distal", 4), rep("Medial", 4), rep("Proximal", 4)),
  Clasico = c(
    1.0850, 6.0351, 3.2103, 1.7653,
    1.5934, 5.9724, 0.8079, 1.4089,
    1.6815, 5.8265, 3.5614, 1.2420
  ),
  Alternativo = c(
    0.0049, 0.0269, 0.0071, 0.0057,
    0.0052, 0.0269, 0.0095, 0.0043,
    0.0040, 0.0184, 0.0088, 0.0041
  )
)

# ============================================================
# FUNCIÓN: Error estándar
# ============================================================

error_estandar <- function(x) sd(x) / sqrt(length(x))

# ============================================================
# PRUEBAS DE WILCOXON PAREADO POR REGIÓN
# y cálculo de medias + error estándar
# ============================================================

regiones <- c("Distal", "Medial", "Proximal")
resultados_wilcoxon <- list()
resumen_stats <- data.frame()

cat("=== PRUEBAS DE WILCOXON PAREADO POR REGIÓN ===\n\n")

for (reg in regiones) {
  
  subset_reg <- datos %>% filter(Region == reg)
  
  # Wilcoxon pareado
  test <- wilcox.test(
    subset_reg$Clasico,
    subset_reg$Alternativo,
    paired = TRUE,
    exact = FALSE
  )
  
  pval <- round(test$p.value, 4)
  
  # Etiqueta de significancia
  sig <- ifelse(pval < 0.001, "***",
                ifelse(pval < 0.01,  "**",
                       ifelse(pval < 0.05,  "*", "ns")))
  
  resultados_wilcoxon[[reg]] <- list(p = pval, sig = sig)
  
  cat("Región:", reg, "\n")
  cat("  W =", test$statistic, "\n")
  cat("  p-valor =", pval, "\n")
  cat("  Significancia:", sig, "\n\n")
  
  # Estadísticos descriptivos
  resumen_stats <- rbind(resumen_stats, data.frame(
    Region   = reg,
    Metodo   = "Clásico (PolyVIEW)",
    Media    = mean(subset_reg$Clasico),
    EE       = error_estandar(subset_reg$Clasico)
  ))
  
  resumen_stats <- rbind(resumen_stats, data.frame(
    Region   = reg,
    Metodo   = "Alternativo (R)",
    Media    = mean(subset_reg$Alternativo),
    EE       = error_estandar(subset_reg$Alternativo)
  ))
}

# Ordenar factores
resumen_stats$Region <- factor(resumen_stats$Region,
                               levels = c("Distal", "Medial", "Proximal"))
resumen_stats$Metodo <- factor(resumen_stats$Metodo,
                               levels = c("Clásico (PolyVIEW)",
                                          "Alternativo (R)"))

# ============================================================
# COLORES
# ============================================================

colores_metodos <- c(
  "Clásico (PolyVIEW)" = "#001F3F",
  "Alternativo (R)"    = "#1F3B4D"
)

# ============================================================
# FUNCIÓN: construir panel por región
# ============================================================

construir_panel <- function(region, letra_panel) {
  
  datos_reg <- resumen_stats %>% filter(Region == region)
  pval      <- resultados_wilcoxon[[region]]$p
  sig       <- resultados_wilcoxon[[region]]$sig
  y_max     <- max(datos_reg$Media + datos_reg$EE) * 1.55
  
  # Etiqueta p-valor
  etiqueta_p <- ifelse(
    sig == "ns",
    paste0("p = ", pval, " (ns)"),
    paste0("p = ", pval, " (", sig, ")")
  )
  
  # Etiquetas numéricas para cada barra
  # Clásico con 4 decimales, Alternativo con 4 decimales
  etiquetas_barras <- datos_reg %>%
    mutate(
      Label = ifelse(
        Metodo == "Clásico (PolyVIEW)",
        paste0(round(Media, 4), "\n±", round(EE, 4)),
        paste0(round(Media, 4), "\n±", round(EE, 4))
      ),
      # Posición y del texto: encima de la barra + EE
      y_label = Media + EE + (y_max * 0.04)
    )
  
  ggplot(datos_reg, aes(x = Metodo, y = Media, fill = Metodo)) +
    
    # Barras
    geom_bar(stat = "identity",
             width = 0.6,
             color = "black",
             linewidth = 0.4) +
    
    # Barras de error estándar
    geom_errorbar(aes(ymin = Media - EE,
                      ymax = Media + EE),
                  width = 0.15,
                  linewidth = 0.6,
                  color = "black") +
    
    # Valores numéricos encima de cada barra (Media ± EE)
    geom_text(
      data = etiquetas_barras,
      aes(x = Metodo,
          y = y_label,
          label = Label),
      size = 2.8,
      fontface = "bold",
      color = "black",
      lineheight = 0.9
    ) +
    
    # Puntos individuales por espécimen
    geom_jitter(
      data = datos %>%
        filter(Region == region) %>%
        pivot_longer(cols = c(Clasico, Alternativo),
                     names_to = "Metodo_raw",
                     values_to = "Valor") %>%
        mutate(
          Metodo = ifelse(Metodo_raw == "Clasico",
                          "Clásico (PolyVIEW)",
                          "Alternativo (R)"),
          Metodo = factor(Metodo,
                          levels = c("Clásico (PolyVIEW)",
                                     "Alternativo (R)"))
        ),
      aes(x = Metodo, y = Valor),
      width = 0.08,
      size = 2.5,
      shape = 21,
      fill = "white",
      color = "black",
      stroke = 0.5,
      inherit.aes = FALSE
    ) +
    
    # Línea de significancia entre barras
    annotate("segment",
             x = 1, xend = 2,
             y = y_max * 0.88,
             yend = y_max * 0.88,
             linewidth = 0.5,
             color = "black") +
    annotate("segment",
             x = 1, xend = 1,
             y = y_max * 0.88,
             yend = y_max * 0.83,
             linewidth = 0.5,
             color = "black") +
    annotate("segment",
             x = 2, xend = 2,
             y = y_max * 0.88,
             yend = y_max * 0.83,
             linewidth = 0.5,
             color = "black") +
    annotate("text",
             x = 1.5,
             y = y_max * 0.93,
             label = etiqueta_p,
             size = 3.2,
             fontface = "italic",
             color = "black") +
    
    # Escalas
    scale_fill_manual(values = colores_metodos) +
    scale_y_continuous(
      expand = expansion(mult = c(0, 0)),
      limits = c(0, y_max)
    ) +
    
    # Etiquetas
    labs(
      title = paste0(letra_panel, ") Uretra ", region),
      x     = NULL,
      y     = expression("Densidad Espectral de Amplitud (V"["pk"]*"/√Hz)")
    ) +
    
    # Tema
    theme_classic() +
    theme(
      plot.title         = element_text(size = 11, face = "bold", hjust = 0),
      axis.title.y       = element_text(size = 9),
      axis.text.x        = element_text(size = 9.5),
      axis.text.y        = element_text(size = 9),
      legend.position    = "none",
      panel.grid.major.y = element_line(color = "grey90", linewidth = 0.4)
    )
}

# ============================================================
# CONSTRUIR LOS TRES PANELES
# ============================================================

panel_distal   <- construir_panel("Distal",   "A")
panel_medial   <- construir_panel("Medial",   "B")
panel_proximal <- construir_panel("Proximal", "C")

# ============================================================
# UNIR PANELES Y GUARDAR
# ============================================================

figura_3 <- grid.arrange(
  panel_distal,
  panel_medial,
  panel_proximal,
  ncol = 3
)

ggsave(
  filename = "Figura3_Wilcoxon_Regiones.png",
  plot     = figura_3,
  width    = 14,
  height   = 6,
  dpi      = 300,
  units    = "in"
)

cat("Gráfica guardada como: Figura3_Wilcoxon_Regiones.png\n")