#' sci_colors
#'
#' Return a vector of Hex colors tailored for scientific figures.
#'
#' @param n Integer. Number of colors to return.
#' @param effect One of "contrast" or "gradient". If "contrast", theme is ignored and
#'   random colors are sampled from the curated database. If "gradient", a light-to-dark
#'   gradient is generated within the selected theme using grDevices::colorRampPalette.
#' @param theme One of "blue", "red", "orange", "green", "yellow", "purple", "grey", "pink".
#'   Only used when `effect = "gradient"`.
#' @return Character vector of Hex colors.
#' @examples
#' sci_colors(5, effect = "contrast")
#' sci_colors(7, effect = "gradient", theme = "blue")
#' sci_colors(12, effect = "gradient", theme = "purple")
#' @export
sci_colors <- function(n,
                       effect = c("contrast", "gradient"),
                       theme = c("blue", "red", "orange", "green", "yellow", "purple", "grey", "pink")) {
	effect <- match.arg(effect)
	theme <- match.arg(theme)

	if (!is.numeric(n) || length(n) != 1 || is.na(n) || n <= 0) {
		stop("n must be a positive number.", call. = FALSE)
	}
	n <- as.integer(n)

	if (effect == "contrast") {
		pool <- .all_sci_colors
		replace <- n > length(pool)
		return(sample(pool, size = n, replace = replace))
	}

	# gradient
	anchors <- .sci_colors_db[[theme]]
	if (length(anchors) < 2) {
		stop("Not enough anchor colors to build gradient.", call. = FALSE)
	}
	grad_fun <- grDevices::colorRampPalette(anchors)
	grad_fun(n)
}

#' Access the internal color database
#' @keywords internal
get_sci_colors_db <- function() .sci_colors_db

# Curated database: 100 total hex colors, categorized by theme.
# Colors are ordered from light to dark within each theme to support gradient creation.
.sci_colors_db <- list(
	blue = c(
		"#F7FBFF", "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6",
		"#2171B5", "#08519C", "#08306B", "#B3CDE3", "#6DAEDB", "#1F77B4", "#2C3E50"
	),
	red = c(
		"#FFF5F0", "#FEE0D2", "#FCBBA1", "#FC9272", "#FB6A4A", "#EF3B2C",
		"#CB181D", "#A50F15", "#67000D", "#E41A1C", "#D62728", "#C0392B", "#B22222"
	),
	orange = c(
		"#FFF5EB", "#FEE6CE", "#FDD0A2", "#FDAE6B", "#FD8D3C", "#F16913",
		"#D94801", "#A63603", "#7F2704", "#E6550D", "#F4A261", "#FF7F0E", "#CC4C02"
	),
	green = c(
		"#F7FCF5", "#E5F5E0", "#C7E9C0", "#A1D99B", "#74C476", "#41AB5D",
		"#238B45", "#006D2C", "#00441B", "#2CA02C", "#66C2A4", "#31A354", "#1B9E77"
	),
	yellow = c(
		"#FFFFE5", "#FFFDE7", "#FFF9C4", "#FFF59D", "#FFF176", "#FFEE58",
		"#FFE082", "#FFEB3B", "#FDD835", "#FBC02D", "#FFD700", "#FFC107"
	),
	purple = c(
		"#FCFBFD", "#EFEDF5", "#DADAEB", "#BCBDDC", "#9E9AC8", "#807DBA",
		"#6A51A3", "#54278F", "#3F007D", "#9467BD", "#8E44AD", "#7B3294"
	),
	grey = c(
		"#FFFFFF", "#F0F0F0", "#E5E5E5", "#D9D9D9", "#CCCCCC", "#BDBDBD",
		"#969696", "#737373", "#525252", "#4D4D4D", "#252525", "#000000"
	),
	pink = c(
		"#FFF7F3", "#FDE0DD", "#FCC5C0", "#FA9FB5", "#F768A1", "#DD3497",
		"#AE017E", "#7A0177", "#49006A", "#F1B6DA", "#E78AC3", "#FF69B4"
	)
)

.all_sci_colors <- unique(unlist(.sci_colors_db, use.names = FALSE))
