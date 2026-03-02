library(ggplot2)

# Datos
datos_correlacion <- data.frame(
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
# PROMEDIAR los 4 especímenes por región → luego promediar
# las 3 regiones para obtener un valor global por método
# (o simplemente promediar los 12 observaciones)
# ============================================================

clasico_vals     <- datos_correlacion$Clasico
alternativo_vals <- datos_correlacion$Alternativo

media_clasico     <- mean(clasico_vals)
media_alternativo <- mean(alternativo_vals)

se_clasico     <- sd(clasico_vals)     / sqrt(length(clasico_vals))
se_alternativo <- sd(alternativo_vals) / sqrt(length(alternativo_vals))

# ============================================================
# T DE STUDENT NO PAREADA (Welch)
# ============================================================
t_test <- t.test(clasico_vals, alternativo_vals, paired = FALSE, var.equal = FALSE)
cat("=== t de Student (no pareada / Welch) ===\n")
print(t_test)

# ============================================================
# DATA FRAME PARA GRAFICAR
# ============================================================
df_plot <- data.frame(
  Metodo = c("Clásico\n(PolyVIEW)", "R\n(Alternativo)"),
  Media  = c(media_clasico, media_alternativo),
  SE     = c(se_clasico,    se_alternativo)
)

df_plot$Metodo <- factor(df_plot$Metodo, levels = df_plot$Metodo)

# Etiqueta de significancia
p_val <- t_test$p.value
sig_label <- ifelse(p_val < 0.001, "p < 0.001",
                    ifelse(p_val < 0.01,  "p < 0.01",
                           ifelse(p_val < 0.05,  "p < 0.05", paste0("p = ", round(p_val, 3)))))

# ============================================================
# GRÁFICA
# ============================================================
y_max <- max(df_plot$Media + df_plot$SE) * 1.25

ggplot(df_plot, aes(x = Metodo, y = Media, fill = Metodo)) +
  geom_bar(stat = "identity", width = 0.5, color = "black", linewidth = 0.4) +
  geom_errorbar(
    aes(ymin = Media - SE, ymax = Media + SE),
    width = 0.15, linewidth = 0.7
  ) +
  # Línea de significancia entre barras
  annotate("segment",
           x = 1, xend = 2,
           y = y_max * 0.90, yend = y_max * 0.90,
           linewidth = 0.6) +
  annotate("segment", x = 1, xend = 1,
           y = y_max * 0.88, yend = y_max * 0.90, linewidth = 0.6) +
  annotate("segment", x = 2, xend = 2,
           y = y_max * 0.88, yend = y_max * 0.90, linewidth = 0.6) +
  annotate("text",
           x = 1.5, y = y_max * 0.93,
           label = sig_label, size = 3.5) +
  scale_fill_manual(values = c("Clásico\n(PolyVIEW)" = "#4878CF",
                               "R\n(Alternativo)"   = "#6ACC65")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, y_max)) +
  labs(
    x     = "Método",
    y     = "Power / Frequency",
    title = "Comparación de métodos: Clásico vs Alternativo",
    subtitle = paste0("t de Student no pareada (Welch) — ", sig_label,
                      "  |  n = ", length(clasico_vals), " por grupo")
  ) +
  theme_classic(base_size = 13) +
  theme(
    legend.position = "none",
    plot.title    = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, size = 10, color = "gray40"),
    axis.title    = element_text(face = "bold")
  )


# ============================================================
# GUARDAR LA GRÁFICA
# ============================================================
ggsave(
  filename = "comparacion_clasico_vs_alternativo.png",
  plot     = last_plot(),
  width    = 7,
  height   = 6,
  dpi      = 300,
  units    = "in"
)

cat("Gráfica guardada en:", getwd(), "\n")