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
		"#e3f1ff", "#c2dffc", "#7fbdfa", "#5caaf7", "#0d41fc", 
		"#2b49b5", "#0b247d", "#090b80", "#162f4d", "#93dbf5", 
		"#6d99a8", "#55b6d9", "#2195bf", "#0381ad", "#46658a"
	),
	orange = c(
		"#fcf1d2", "#fce7ac", "#ffe08a", "#fcc426", "#f7ad23", 
		"#f78c00", "#f76f00", "#c75102", "#9c4003", "#fcc795", 
		"#fcbe95", "#e6550d", "#d14e26", "#e6400d"
	),
	green = c(
		"#F2FFEd", "#E5F5E0", "#C7E9C0", "#A1D99B", "#74C476", "#41AB5D",
		"#238B45", "#006D2C", "#00441B", "#2CA02C", "#66C2A4", "#1B9E77"
	),
	purple = c(
		"#F1E8FA", "#E6E1F2", "#D1D1EB", "#BCBDDC", "#9E9AC8", "#807DBA",
		"#6A51A3", "#54278F", "#3F007D", "#9467BD", "#8E44AD", "#7B3294"
	),
	grey = c(
		"#F0F0F0", "#D9D9D9", "#BDBDBD",
		"#737373", "#525252", "#252525"
	),
	red = c(
		"#fce0de", "#fccdca", "#f7a19c", "#fa8b84", "#f7756d", 
		"#f73d31", "#cc291f", "#ab1c13", "#96130b", "#f5bacf", 
		"#fa9bbd", "#f57aa6", "#cf5580", "#cc4576", "#f03578", 
		"#faebe6", "#cc8386", "#9e6767", "#9c3535", "#610202"
	)
)

.all_sci_colors <- unique(unlist(.sci_colors_db, use.names = FALSE))