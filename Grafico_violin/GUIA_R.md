# 📊 GUÍA COMPLETA PARA USAR LOS SCRIPTS DE R

## 🚀 Inicio Rápido

### Opción 1: Script Simple (Recomendado para empezar)

```r
# 1. Abre R o RStudio
# 2. Establece el directorio de trabajo donde están tus archivos
setwd("ruta/a/tus/archivos")

# 3. Instala paquetes (solo primera vez)
install.packages(c("ggplot2", "dplyr", "tidyr", "ggbeeswarm", "gridExtra"))

# 4. Ejecuta el script completo
source("script_simple_R.R")
```

### Opción 2: Script Completo (Con análisis estadístico)

```r
source("script_completo_R.R")
```

---

## 📁 Archivos Necesarios

Asegúrate de tener estos archivos en el mismo directorio:

1. ✅ `datos_nervios.csv` - Base de datos
2. ✅ `script_simple_R.R` - Script básico
3. ✅ `script_completo_R.R` - Script con estadística

---

## 📦 Instalación de Paquetes

### Primera vez usando R:

```r
# Ejecuta esto una sola vez
install.packages(c(
  "ggplot2",      # Para gráficos
  "dplyr",        # Para manipulación de datos
  "tidyr",        # Para organizar datos
  "ggbeeswarm",   # Para puntos dispersos
  "gridExtra"     # Para combinar gráficos
))
```

### Verificar instalación:

```r
# Verifica que los paquetes estén instalados
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggbeeswarm)
library(gridExtra)

# Si no hay errores, ¡estás listo!
```

---

## 🎨 Personalización de Gráficos

### Cambiar Colores

En `script_simple_R.R` o `script_completo_R.R`, busca esta sección (línea ~60):

```r
colores <- c(
  "Sham" = "#FFFFFF",           # Blanco
  "L6 VRA" = "#D2691E",          # Naranja
  "L6 VRA+PPyI" = "#654321"      # Marrón
)
```

**Códigos de colores útiles:**
- Blanco: `#FFFFFF`
- Negro: `#000000`
- Gris claro: `#E0E0E0`
- Gris oscuro: `#808080`
- Azul: `#0000FF`
- Rojo: `#FF0000`
- Verde: `#00FF00`
- Naranja: `#FFA500`
- Morado: `#800080`

### Cambiar Rangos de los Ejes Y

Busca las líneas donde se llama a `graficar()` o `crear_grafico_violin()`:

```r
# ANTES (ejemplo):
A <- graficar("Amplitud_uV", "A)", "Amplitude (µV)", 
              c(-1000, 45000),           # ← Límites Y
              seq(0, 40000, 10000))      # ← Marcas en Y

# DESPUÉS (personalizado):
A <- graficar("Amplitud_uV", "A)", "Amplitude (µV)", 
              c(0, 50000),               # Nuevo rango
              seq(0, 50000, 12500))      # Nuevas marcas
```

### Analizar Solo Nervio Peroneo

En el script, cambia:

```r
# ANTES:
nervio = "Femoral"

# DESPUÉS:
nervio = "Peroneo"
```

O ejecuta directamente:

```r
# Gráfico solo para nervio Peroneo
grafico_peroneo <- graficar(
  "Amplitud_uV", 
  "A) Peroneo", 
  "Amplitude (µV)", 
  c(-1000, 45000), 
  seq(0, 40000, 10000),
  nervio = "Peroneo"  # ← Aquí se especifica
)

ggsave("Peroneo_Amplitud.png", grafico_peroneo, 
       width = 8, height = 6, dpi = 300)
```

---

## 📊 Entendiendo las Variables

El CSV tiene estas variables principales:

| Variable | Descripción | Unidad |
|----------|-------------|--------|
| `Amplitud_uV` | Amplitud del reflejo | Microvoltios (µV) |
| `Duracion_ms` | Duración del reflejo | Milisegundos (ms) |
| `Lat_Inicio_ms` | Latencia de inicio | Milisegundos (ms) |
| `Lat_Pico_ms` | Latencia al pico | Milisegundos (ms) |
| `Velocidad_ms` | Velocidad de conducción | Metros/segundo (m/s) |
| `Anchura_ms` | Anchura del reflejo | Milisegundos (ms) |

### Crear Gráfico de Cualquier Variable

```r
# Ejemplo: Graficar Anchura
grafico_anchura <- graficar(
  variable = "Anchura_ms",
  titulo = "E)",
  ylabel = "Width (ms)",
  ylim = c(0, 2),
  ybreaks = seq(0, 2, 0.5),
  nervio = "Femoral"
)

ggsave("E_Anchura.png", grafico_anchura, width = 8, height = 6, dpi = 300)
```

---

## 📈 Análisis Estadístico

El `script_completo_R.R` incluye análisis estadístico automático:

### Qué Calcula:

1. **Estadística Descriptiva:**
   - n (tamaño de muestra)
   - Media
   - Desviación estándar
   - Mediana
   - Mínimo y Máximo

2. **ANOVA de dos vías:**
   - Efectos de Condición
   - Efectos de Día
   - Interacción Condición × Día

3. **Pruebas Post-hoc:**
   - Comparaciones t-test entre grupos
   - Valores p
   - Símbolos de significancia

### Interpretar Resultados:

```
--- Día 4 ---
  Sham vs L6 VRA: p = 0.0234 *
  Sham vs L6 VRA+PPyI: p = 0.0008 ***
  L6 VRA vs L6 VRA+PPyI: p = 0.1234 ns
```

**Significado:**
- `***` p < 0.001 (altamente significativo)
- `**` p < 0.01 (muy significativo)
- `*` p < 0.05 (significativo)
- `ns` p ≥ 0.05 (no significativo)

---

## 🔧 Solución de Problemas

### Error: "could not find function"

**Problema:** No se cargó algún paquete

**Solución:**
```r
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggbeeswarm)
library(gridExtra)
```

### Error: "cannot open file 'datos_nervios.csv'"

**Problema:** El archivo no está en el directorio correcto

**Solución:**
```r
# Ver directorio actual
getwd()

# Cambiar directorio
setwd("ruta/completa/a/tus/archivos")

# Verificar que el archivo existe
file.exists("datos_nervios.csv")  # Debe devolver TRUE
```

### Error: "package 'X' is not available"

**Problema:** El paquete no está instalado

**Solución:**
```r
install.packages("nombre_del_paquete")
```

### Los gráficos se ven mal o borrosos

**Problema:** Baja resolución

**Solución:**
```r
# Aumentar DPI en ggsave
ggsave("mi_grafico.png", width = 10, height = 8, dpi = 600)
```

### Error: "object 'datos' not found"

**Problema:** No se ejecutó la lectura de datos

**Solución:**
```r
# Volver a leer los datos
datos <- read.csv("datos_nervios.csv", stringsAsFactors = FALSE)
```

---

## 💡 Tips Profesionales

### 1. Guardar el Workspace

```r
# Al final de tu sesión
save.image("mi_analisis.RData")

# Para cargar en otra sesión
load("mi_analisis.RData")
```

### 2. Exportar Gráficos en Diferentes Formatos

```r
# PNG (raster, bueno para presentaciones)
ggsave("grafico.png", width = 8, height = 6, dpi = 300)

# PDF (vector, perfecto para publicaciones)
ggsave("grafico.pdf", width = 8, height = 6)

# TIFF (requerido por algunas revistas)
ggsave("grafico.tiff", width = 8, height = 6, dpi = 300)

# SVG (editable en Illustrator/Inkscape)
ggsave("grafico.svg", width = 8, height = 6)
```

### 3. Ver Todos los Gráficos en RStudio

```r
# Generar sin guardar para previsualizar
print(A)  # Ver gráfico A
print(B)  # Ver gráfico B
```

### 4. Filtrar Datos Antes de Graficar

```r
# Solo día 28
datos_dia28 <- datos %>% filter(Dia_Post_Avulsion == "28")

# Solo condición L6 VRA
datos_L6 <- datos %>% filter(Condicion == "ARV L6")

# Múltiples filtros
datos_filtrados <- datos %>% 
  filter(Nervio == "Femoral", 
         Dia_Post_Avulsion %in% c("15", "28"))
```

### 5. Ajustar Tamaño de Texto

```r
# En la función graficar, modifica base_size
theme_classic(base_size = 14)  # Texto más grande
theme_classic(base_size = 10)  # Texto más pequeño
```

---

## 📚 Recursos Adicionales

### Aprender R:
- [R for Data Science](https://r4ds.had.co.nz/) - Libro gratuito
- [RStudio Education](https://education.rstudio.com/)
- [Quick-R](https://www.statmethods.net/)

### ggplot2:
- [Documentación oficial](https://ggplot2.tidyverse.org/)
- [R Graphics Cookbook](https://r-graphics.org/)
- [ggplot2 cheatsheet](https://github.com/rstudio/cheatsheets/blob/main/data-visualization.pdf)

### Estadística en R:
- [Quick-R Statistics](https://www.statmethods.net/stats/)
- [Discovering Statistics Using R](https://www.discoveringstatistics.com/books/dsur/)

---

## ✅ Checklist Pre-Publicación

Antes de usar tus gráficos en una publicación:

- [ ] Verificar que n > 3 para cada grupo
- [ ] Confirmar valores p correctos
- [ ] Revisar unidades en etiquetas de ejes
- [ ] Verificar colores (distinguibles en B/N)
- [ ] Confirmar resolución (300 DPI mínimo)
- [ ] Revisar tamaño de fuente (legible)
- [ ] Verificar ortografía en títulos
- [ ] Incluir leyenda clara
- [ ] Guardar en formato requerido por revista

---

## 🆘 Contacto y Ayuda

Si encuentras problemas:

1. Verifica el mensaje de error completo
2. Confirma que tienes todos los archivos
3. Revisa que los paquetes estén cargados
4. Verifica el directorio de trabajo

```r
# Información del sistema
sessionInfo()

# Paquetes cargados
search()

# Directorio actual
getwd()

# Archivos en el directorio
list.files()
```

---

**¡Éxito con tu análisis!** 🎉
