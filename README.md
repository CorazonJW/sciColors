## sciColors: Scientific Journal Color Palettes

A small R package that provides curated Hex colors commonly seen in biology journals.

### Install (development)
```r
devtools::install_github("CorazonJW/sciColors")
```

### Usage
```r
library(sciColors)

# 5 high-contrast colors (random from database, theme ignored)
sci_colors(5, effect = "contrast")

# 7 blue gradient colors (light -> dark)
sci_colors(7, effect = "gradient", theme = "blue")

# 20 green gradient colors (light -> dark)
sci_colors(20, effect = "gradient", theme = "green")
```

- **effect = "contrast"**: returns `n` random colors sampled from the full database (theme is ignored).
- **effect = "gradient"**: returns `n` colors forming a light-to-dark gradient within the chosen theme.
