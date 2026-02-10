# ============================================================
# CÓDIGO PARA GRÁFICA DE VELOCIDAD
# ============================================================

# Cargar librerías necesarias
library(tidyverse)
library(rstatix)

# Cargar datos
datos <- read.csv("datos_nervios_actualizados.csv")

# Filtrar solo los umbrales deseados y eliminar NA en Condicion
datos_filtrados <- datos %>%
  filter(Umbrales_analizados %in% c("X1", "X3", "X5", "X6")) %>%
  filter(!is.na(Condicion) & Condicion != "" & Condicion != "NA")

# Verificar que solo tenemos los 3 grupos
print("Grupos únicos en los datos:")
print(unique(datos_filtrados$Condicion))

# ============================================================
# PASO 1: PRUEBAS ESTADÍSTICAS - ANOVA y Post-hoc Tukey
# ============================================================

# Realizar ANOVA para cada umbral (usando Velocidad)
resultados_anova <- datos_filtrados %>%
  group_by(Umbrales_analizados) %>%
  anova_test(Velocidad ~ Condicion)

print("Resultados ANOVA:")
print(resultados_anova)

# Post-hoc Tukey para comparaciones múltiples
resultados_tukey <- datos_filtrados %>%
  group_by(Umbrales_analizados) %>%
  tukey_hsd(Velocidad ~ Condicion)

print("\nResultados Tukey HSD (comparaciones múltiples):")
print(resultados_tukey)

# Guardar resultados
write.csv(resultados_anova, "resultados_anova_velocidad.csv", row.names = FALSE)
write.csv(resultados_tukey, "resultados_tukey_velocidad.csv", row.names = FALSE)

# ============================================================
# PASO 2: PREPARAR DATOS PARA LA GRÁFICA
# ============================================================

# Calcular medias y errores estándar
datos_resumen <- datos_filtrados %>%
  group_by(Condicion, Umbrales_analizados) %>%
  summarise(
    media = mean(Velocidad, na.rm = TRUE),
    se = sd(Velocidad, na.rm = TRUE) / sqrt(n()),
    n = n(),
    .groups = 'drop'
  )

# Convertir a factor con orden específico
datos_resumen$Umbrales_analizados <- factor(
  datos_resumen$Umbrales_analizados,
  levels = c("X1", "X3", "X5", "X6")
)

# Ordenar Condicion para que coincida con la gráfica original
datos_resumen$Condicion <- factor(datos_resumen$Condicion,
                                  levels = c("SHAM", "ARV L6", "ARV L6+PPyI"))

print("\nResumen de datos por grupo (después de filtrar):")
print(datos_resumen)

# ============================================================
# PASO 3: CREAR LA GRÁFICA BASE CON MEJOR PRESENTACIÓN
# ============================================================

p <- ggplot(datos_resumen, aes(x = Umbrales_analizados, y = media, 
                               shape = Condicion, group = Condicion)) +
  geom_point(size = 5, position = position_dodge(width = 0.5), 
             color = "black", stroke = 1.2) +
  geom_errorbar(aes(ymin = media - se, ymax = media + se), 
                width = 0.15, linewidth = 1.2, 
                position = position_dodge(width = 0.5),
                color = "black") +
  geom_hline(yintercept = 0, linetype = "dotted", linewidth = 0.8, color = "black") +
  
  labs(
    x = "Threshold",
    y = "Conduction velocity (m/s)",
    shape = ""  # Título vacío para la leyenda
  ) +
  theme_classic(base_size = 16) +
  theme(
    # Ejes
    axis.text.x = element_text(size = 16, color = "black", face = "bold"),
    axis.text.y = element_text(size = 14, color = "black", face = "bold"),
    axis.title.x = element_text(size = 18, face = "bold", margin = margin(t = 12)),
    axis.title.y = element_text(size = 18, face = "bold", margin = margin(r = 12)),
    axis.line = element_line(linewidth = 1.5, color = "black"),
    axis.ticks = element_line(linewidth = 1.2, color = "black"),
    axis.ticks.length = unit(0.25, "cm"),
    
    # Leyenda profesional
    legend.position = c(0.85, 0.15),  # Posición arriba izquierda
    legend.background = element_rect(fill = "white", color = "black", linewidth = 0.8),
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 13, face = "plain"),
    legend.key.size = unit(1.2, "cm"),
    legend.spacing.y = unit(0.3, "cm"),
    legend.margin = margin(t = 8, r = 8, b = 8, l = 8),
    
    # Panel
    panel.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(t = 20, r = 20, b = 20, l = 20)
  ) +
  scale_y_continuous(
    limits = c(-1, 4),  # CORREGIDO: Rango ajustado para Velocidad (1.5 - 3.75)
    breaks = seq(-1, 4, 1),
    expand = expansion(mult = c(0.02, 0.05))
  ) +
  scale_x_discrete(labels = c("X1" = "1", "X3" = "3", "X5" = "5", "X6" = "6")) +
  scale_shape_manual(
    values = c(16, 6, 15),  # círculo, triángulo invertido, cuadrado
    labels = c("Sham", "ARV L6", "L6 VRA+PPyI")  # Etiquetas para la leyenda
  ) +
  guides(shape = guide_legend(
    override.aes = list(size = 6),  # Hacer símbolos más grandes en leyenda
    byrow = TRUE
  ))

# ============================================================
# PASO 4: AÑADIR BARRAS DE SIGNIFICANCIA
# ============================================================

# Función mejorada para añadir barras de significancia
add_significance_bar <- function(plot, x_pos, y_pos, width, label) {
  plot +
    annotate("segment", 
             x = x_pos - width/2, xend = x_pos + width/2,
             y = y_pos, yend = y_pos,
             linewidth = 1.5, color = "black") +
    annotate("segment",
             x = x_pos - width/2, xend = x_pos - width/2,
             y = y_pos - 0.06, yend = y_pos,
             linewidth = 1.5, color = "black") +
    annotate("segment",
             x = x_pos + width/2, xend = x_pos + width/2,
             y = y_pos - 0.06, yend = y_pos,
             linewidth = 1.5, color = "black") +
    annotate("text",
             x = x_pos, y = y_pos + 0.15,
             label = label, size = 7, fontface = "bold")
}

# Filtrar comparaciones significativas
sig_comparisons <- resultados_tukey %>%
  filter(p.adj < 0.05) %>%
  arrange(Umbrales_analizados, desc(p.adj))

print("\nComparaciones significativas:")
print(sig_comparisons %>% select(Umbrales_analizados, group1, group2, p.adj, p.adj.signif))

# Posiciones de los umbrales
umbrales_pos <- c("X1" = 1, "X3" = 2, "X5" = 3, "X6" = 4)

# Para cada umbral, añadir las barras de significancia
for(umbral in c("X1", "X3", "X5", "X6")) {
  comparaciones_umbral <- sig_comparisons %>% filter(Umbrales_analizados == umbral)
  
  if(nrow(comparaciones_umbral) > 0) {
    pos_x <- umbrales_pos[umbral]
    
    # Calcular altura máxima de los datos en este umbral
    altura_datos <- datos_resumen %>%
      filter(Umbrales_analizados == umbral) %>%
      summarise(max_y = max(media + se, na.rm = TRUE)) %>%
      pull(max_y)
    
    # Definir alturas base para las barras con más separación
    alturas <- c(altura_datos + 0.4, altura_datos + 0.75, altura_datos + 1.1)
    
    # Añadir cada comparación
    for(i in 1:min(nrow(comparaciones_umbral), 3)) {
      comp <- comparaciones_umbral[i,]
      
      # Determinar ancho de la barra según los grupos comparados
      g1 <- comp$group1
      g2 <- comp$group2
      
      # Calcular ancho basado en distancia entre grupos
      if((g1 == "SHAM" & g2 == "ARV L6+PPyI") | (g1 == "ARV L6+PPyI" & g2 == "SHAM")) {
        ancho <- 0.45  # Comparación entre grupos extremos
      } else if((g1 == "SHAM" & g2 == "ARV L6") | (g1 == "ARV L6" & g2 == "SHAM")) {
        ancho <- 0.25  # Comparación entre grupos adyacentes izquierda
      } else {
        ancho <- 0.25  # ARV L6 vs ARV L6+PPyI (adyacentes derecha)
      }
      
      # Determinar símbolo de significancia
      simbolo <- comp$p.adj.signif
      
      # Añadir barra
      p <- add_significance_bar(p, pos_x, alturas[i], ancho, simbolo)
    }
  }
}

# ============================================================
# PASO 5: GUARDAR Y MOSTRAR
# ============================================================

# Guardar la gráfica en alta resolución
ggsave("grafica_velocidad.png", plot = p, 
       width = 25, height = 25, dpi = 600, bg = "white")

# También guardar en formato PDF para publicaciones
ggsave("grafica_velocidad.pdf", plot = p, 
       width = 25, height = 25, device = "pdf")

# Mostrar la gráfica
print(p)

# Tabla final de comparaciones
print("\nTabla final de comparaciones significativas:")
resultado_final <- sig_comparisons %>% 
  select(Umbrales_analizados, group1, group2, estimate, p.adj, p.adj.signif)
print(resultado_final)

# Crear tabla resumen para publicación
tabla_resumen <- datos_resumen %>%
  mutate(
    media_se = sprintf("%.2f ± %.2f", media, se)
  ) %>%
  select(Condicion, Umbrales_analizados, media_se, n)

print("\nTabla resumen (Media ± SE):")
print(tabla_resumen)

# Guardar tabla resumen
write.csv(tabla_resumen, "tabla_resumen_velocidad.csv", row.names = FALSE)