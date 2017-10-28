#20150219 yamakita modified from pairs.panels2 and panelcor3.r
#usage
#x <- read.table("clipboard",sep="\t",header=T)
#x2 <- as.matrix(x)
#x3 <-matrix(as.numeric(x2),nrow=nrow(x2), ncol=ncol(x2))
#
#pairs.panels3(x3)
#
pairs.panels3 <- function (x, smooth = TRUE, scale = FALSE, density = TRUE, ellipses = TRUE, digits = 2, method = "pearson", pch = 20, lm = FALSE, cor = TRUE, jiggle = FALSE, factor = 2, hist.col = "cyan", show.points = TRUE, rug = TRUE, ...) 
{
    "panel.jiggle" <- function(x, y, pch = par("pch"), col.smooth = "red", span = 2/3, iter = 3, ...) {
        xm <- mean(x, na.rm = TRUE)
        ym <- mean(y, na.rm = TRUE)
        xs <- sd(x, na.rm = TRUE)
        ys <- sd(y, na.rm = TRUE)
        r = cor(x, y, use = "pairwise", method = method)
        x <- jitter(x, factor = factor)
        y <- jitter(y, factor = factor)
        points(x, y, pch = pch, ...)
        ok <- is.finite(x) & is.finite(y)
        if (any(ok)) 
            lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), col = col.smooth, ...)
        panel.ellipse1(xm, ym, xs, ys, r, col.smooth = col.smooth, ...)
    }
    "panel.hist.density" <- function(x, ...) {
        usr <- par("usr")
        on.exit(par(usr))
        par(usr = c(usr[1:2], 0, 1.5))
        h <- hist(x, plot = FALSE)
        breaks <- h$breaks
        nB <- length(breaks)
        y <- h$counts
        y <- y/max(y)
        rect(breaks[-nB], 0, breaks[-1], y, col = hist.col)
        tryd <- try(d <- density(x, na.rm = TRUE, bw = "nrd", adjust = 1.2), silent = TRUE)
        if (class(tryd) != "try-error") {
            d$y <- d$y/max(d$y)
            lines(d)
            if (rug) 
                rug(x)
        }
    }
    "panel.hist" <- function(x, ...) {
        usr <- par("usr")
        on.exit(par(usr))
        par(usr = c(usr[1:2], 0, 1.5))
        h <- hist(x, plot = FALSE)
        breaks <- h$breaks
        nB <- length(breaks)
        y <- h$counts
        y <- y/max(y)
        rect(breaks[-nB], 0, breaks[-1], y, col = hist.col)
        if (rug) 
            rug(x)
    }
    "panel.cor.scale" <- function(x, y, digits = 2, prefix = "", cex.cor, ...) {
        usr <- par("usr")
        on.exit(par(usr))
        par(usr = c(0, 1, 0, 1))
        r = cor(x, y, use = "pairwise", method = method)
        txt <- format(c(r, 0.123456789), digits = digits)[1]
        txt <- paste(prefix, txt, sep = "")
        if (missing(cex.cor)) 
            cex <- 0.8/strwidth(txt)
        cex1 <- cex * abs(r)
        if (cex1 < 0.25) 
            cex1 <- 0.25
        text(0.5, 0.5, txt, cex = cex1)
    }
    "panel.smoother" <- function(x, y, pch = par("pch"), col.smooth = "red", span = 2/3, iter = 3, ...) {
        xm <- mean(x, na.rm = TRUE)
        ym <- mean(y, na.rm = TRUE)
        xs <- sd(x, na.rm = TRUE)
        ys <- sd(y, na.rm = TRUE)
        r = cor(x, y, use = "pairwise", method = method)
        points(x, y, pch = pch, ...)
        ok <- is.finite(x) & is.finite(y)
        if (any(ok)) 
            lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), col = col.smooth, ...)
        panel.ellipse1(xm, ym, xs, ys, r, col.smooth = col.smooth, ...)
    }
    "panel.smoother.no" <- function(x, y, pch = par("pch"), col.smooth = "red", span = 2/3, iter = 3, ...) {
        xm <- mean(x, na.rm = TRUE)
        ym <- mean(y, na.rm = TRUE)
        xs <- sd(x, na.rm = TRUE)
        ys <- sd(y, na.rm = TRUE)
        r = cor(x, y, use = "pairwise", method = method)
        ok <- is.finite(x) & is.finite(y)
        if (any(ok)) 
            lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), col = col.smooth, ...)
        panel.ellipse1(xm, ym, xs, ys, r, col.smooth = col.smooth, ...)
    }
    "panel.smoother.noellipse" <- function(x, y, pch = par("pch"), col.smooth = "red", span = 2/3, iter = 3, ...) {
        xm <- mean(x, na.rm = TRUE)
        ym <- mean(y, na.rm = TRUE)
        xs <- sd(x, na.rm = TRUE)
        ys <- sd(y, na.rm = TRUE)
        r = cor(x, y, use = "pairwise", method = method)
        points(x, y, pch = pch, ...)
        ok <- is.finite(x) & is.finite(y)
        if (any(ok)) 
            lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), col = col.smooth, ...)
    }
    "panel.smoother.no.noellipse" <- function(x, y, pch = par("pch"), col.smooth = "red", span = 2/3, iter = 3, ...) {
        xm <- mean(x, na.rm = TRUE)
        ym <- mean(y, na.rm = TRUE)
        xs <- sd(x, na.rm = TRUE)
        ys <- sd(y, na.rm = TRUE)
        r = cor(x, y, use = "pairwise", method = method)
        ok <- is.finite(x) & is.finite(y)
        if (any(ok)) 
            lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), col = col.smooth, ...)
    }
    "panel.lm" <- function(x, y, pch = par("pch"), col.lm = "red", ...) {
        ymin <- min(y)
        ymax <- max(y)
        xmin <- min(x)
        xmax <- max(x)
        ylim <- c(min(ymin, xmin), max(ymax, xmax))
        xlim <- ylim
        points(x, y, pch = pch, ylim = ylim, xlim = xlim, ...)
        ok <- is.finite(x) & is.finite(y)
        if (any(ok)) 
            abline(lm(y[ok] ~ x[ok]), col = col.lm, ...)
    }
    "panel.lm.ellipse" <- function(x, y, pch = par("pch"), col.lm = "red", ...) {
        ymin <- min(y)
        ymax <- max(y)
        xmin <- min(x)
        xmax <- max(x)
        ylim <- c(min(ymin, xmin), max(ymax, xmax))
        xlim <- ylim
        points(x, y, pch = pch, ylim = ylim, xlim = xlim, ...)
        ok <- is.finite(x) & is.finite(y)
        if (any(ok)) 
            abline(lm(y[ok] ~ x[ok]), col = col.lm, ...)
        xm <- mean(x, na.rm = TRUE)
        ym <- mean(y, na.rm = TRUE)
        xs <- sd(x, na.rm = TRUE)
        ys <- sd(y, na.rm = TRUE)
        r = cor(x, y, use = "pairwise", method = method)
        panel.ellipse1(xm, ym, xs, ys, r, col.smooth = col.lm, ...)
    }
    "panel.cor" <- function(x, y, digits = 2, prefix = "", cex.cor, ...) {
        usr <- par("usr")
        on.exit(par(usr))
        par(usr = c(0, 1, 0, 1))
        r <- cor(x, y, use = "pairwise", method = method)
        txt <- format(c(round(r, digits), 0.123456789), digits = digits)[1]
        txt <- paste(prefix, txt, sep = "")
        if (missing(cex.cor)) {
            cex <- 0.8/strwidth(txt)
        }
        else {
            cex <- cex.cor
        }
        text(0.5, 0.5, txt, cex = cex)
        # borrowed from printCoefmat #v3で追記
        test <- cor.test(x,y) 
        Signif <- symnum(test$p.value, corr = FALSE, na = FALSE, 
                  cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                  symbols = c("***", "**", "*", ".", " ")) 
        text(.8, .8, Signif, cex=cex, col=2)#v3で追記終了        
        
    }
    "panel.ellipse1" <- function(x = 0, y = 0, xs = 1, ys = 1, r = 0, col.smooth, add = TRUE, segments = 51, ...) {
        angles <- (0:segments) * 2 * pi/segments
        unit.circle <- cbind(cos(angles), sin(angles))
        if (!is.na(r)) {
            if (abs(r) > 0) 
                theta <- sign(r)/sqrt(2)
            else theta = 1/sqrt(2)
            shape <- diag(c(sqrt(1 + r), sqrt(1 - r))) %*% matrix(c(theta, theta, -theta, theta), ncol = 2, byrow = TRUE)
            ellipse <- unit.circle %*% shape
            ellipse[, 1] <- ellipse[, 1] * xs + x
            ellipse[, 2] <- ellipse[, 2] * ys + y
            points(x, y, pch = 19, col = col.smooth, cex = 1.5)
            lines(ellipse, ...)
        }
    }
    "panel.ellipse.no" <- function(x, y, pch = par("pch"), col.smooth = "red", ...) {
        segments = 51
        xm <- mean(x, na.rm = TRUE)
        ym <- mean(y, na.rm = TRUE)
        xs <- sd(x, na.rm = TRUE)
        ys <- sd(y, na.rm = TRUE)
        r = cor(x, y, use = "pairwise", method = method)
        angles <- (0:segments) * 2 * pi/segments
        unit.circle <- cbind(cos(angles), sin(angles))
        if (!is.na(r)) {
            if (abs(r) > 0) 
                theta <- sign(r)/sqrt(2)
            else theta = 1/sqrt(2)
            shape <- diag(c(sqrt(1 + r), sqrt(1 - r))) %*% matrix(c(theta, theta, -theta, theta), ncol = 2, byrow = TRUE)
            ellipse <- unit.circle %*% shape
            ellipse[, 1] <- ellipse[, 1] * xs + xm
            ellipse[, 2] <- ellipse[, 2] * ys + ym
            points(xm, ym, pch = 19, col = col.smooth, cex = 1.5)
            lines(ellipse, ...)
        }
    }
    "panel.ellipse" <- function(x, y, pch = par("pch"), col.smooth = "red", ...) {
        segments = 51
        xm <- mean(x, na.rm = TRUE)
        ym <- mean(y, na.rm = TRUE)
        xs <- sd(x, na.rm = TRUE)
        ys <- sd(y, na.rm = TRUE)
        r = cor(x, y, use = "pairwise", method = method)
        points(x, y, pch = pch, ...)
        angles <- (0:segments) * 2 * pi/segments
        unit.circle <- cbind(cos(angles), sin(angles))
        if (!is.na(r)) {
            if (abs(r) > 0) 
                theta <- sign(r)/sqrt(2)
            else theta = 1/sqrt(2)
            shape <- diag(c(sqrt(1 + r), sqrt(1 - r))) %*% matrix(c(theta, theta, -theta, theta), ncol = 2, byrow = TRUE)
            ellipse <- unit.circle %*% shape
            ellipse[, 1] <- ellipse[, 1] * xs + xm
            ellipse[, 2] <- ellipse[, 2] * ys + ym
            points(xm, ym, pch = 19, col = col.smooth, cex = 1.5)
            lines(ellipse, ...)
        }
    }
    old.par <- par(no.readonly = TRUE)
    on.exit(par(old.par))
    par(pch = pch)
    if (!lm) {
        if (density) {
            if (smooth) {
                if (scale) {
                  if (ellipses) {
                    if (show.points) {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor.scale, lower.panel = panel.smoother, ...)
                    }
                    else {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor.scale, lower.panel = panel.smoother.no, ...)
                    }
                  }
                  else {
                    if (show.points) {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor.scale, lower.panel = panel.smoother.noellipse, ...)
                    }
                    else {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor.scale, lower.panel = panel.smoother.no.noellipse, ...)
                    }
                  }
                }
                else {
                  if (ellipses) {
                    if (jiggle) {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.jiggle, ...)
                    }
                    else {
                      if (show.points) {
                        pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.smoother, ...)
                      }
                      else {
                        pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.smoother.no, ...)
                      }
                    }
                  }
                  else {
                    if (show.points) {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.smoother.noellipse, ...)
                    }
                    else {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.smoother.no.noellipse, ...)
                    }
                  }
                }
            }
            else {
                if (scale) {
                  if (ellipses) {
                    if (show.points) {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor.scale, lower.panel = panel.ellipse, ...)
                    }
                    else {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor.scale, lower.panel = panel.ellipse.no, ...)
                    }
                  }
                  else {
                    if (show.points) {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor.scale, ...)
                    }
                    else {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor.scale, lower.panel = panel.ellipse.no, ...)
                    }
                  }
                }
                else {
                  if (ellipses) {
                    if (show.points) {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.ellipse, ...)
                    }
                    else {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.ellipse.no, ...)
                    }
                  }
                  else {
                    if (show.points) {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, ...)
                    }
                    else {
                      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.ellipse.no, ...)
                    }
                  }
                }
            }
        }
        else {
            if (smooth) {
                if (scale) {
                  if (ellipses) {
                    pairs(x, diag.panel = panel.hist, upper.panel = panel.cor.scale, lower.panel = panel.smoother, ...)
                  }
                  else {
                    pairs(x, diag.panel = panel.hist, upper.panel = panel.cor.scale, lower.panel = panel.smooth, ...)
                  }
                }
                else {
                  if (ellipses) {
                    pairs(x, diag.panel = panel.hist, upper.panel = panel.cor, lower.panel = panel.smoother, ...)
                  }
                  else {
                    pairs(x, diag.panel = panel.hist, upper.panel = panel.cor, lower.panel = panel.smooth, ...)
                  }
                }
            }
            else {
                if (scale) {
                  if (ellipses) {
                    pairs(x, diag.panel = panel.hist, upper.panel = panel.cor.scale, lower.panel = panel.ellipse, ...)
                  }
                  else {
                    pairs(x, diag.panel = panel.hist, upper.panel = panel.cor.scale, ...)
                  }
                }
                else {
                  if (ellipses) {
                    if (show.points) {
                      pairs(x, diag.panel = panel.hist, upper.panel = panel.cor, lower.panel = panel.ellipse, ...)
                    }
                    else {
                      pairs(x, diag.panel = panel.hist, upper.panel = panel.cor, lower.panel = panel.ellipse.no, ...)
                    }
                  }
                  else {
                    pairs(x, diag.panel = panel.hist, upper.panel = panel.cor, ...)
                  }
                }
            }
        }
    }
    else {
        if (cor) {
            if (density) {
                if (ellipses) {
                  if (jiggle) {
                    pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.lm.ellipse, ...)
                  }
                  else {
                    pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.lm.ellipse, ...)
                  }
                }
                else {
                  pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, lower.panel = panel.lm, ...)
                }
            }
            else {
                if (ellipses) {
                  pairs(x, diag.panel = panel.hist, upper.panel = panel.cor, lower.panel = panel.lm.ellipse, ...)
                }
                else {
                  pairs(x, diag.panel = panel.hist, upper.panel = panel.cor, lower.panel = panel.lm, ...)
                }
            }
        }
        else {
            if (density) {
                if (ellipses) {
                  if (jiggle) {
                    pairs(x, diag.panel = panel.hist.density, upper.panel = panel.jiggle, lower.panel = panel.lm.ellipse, ...)
                  }
                  else {
                    pairs(x, diag.panel = panel.hist.density, upper.panel = panel.lm.ellipse, lower.panel = panel.lm.ellipse, ...)
                  }
                }
                else {
                  pairs(x, diag.panel = panel.hist.density, upper.panel = panel.lm, lower.panel = panel.lm, ...)
                }
            }
            else {
                if (ellipses) {
                  pairs(x, diag.panel = panel.hist, upper.panel = panel.lm, lower.panel = panel.lm.ellipse, ...)
                }
                else {
                  pairs(x, diag.panel = panel.hist, upper.panel = panel.lm, lower.panel = panel.lm, ...)
                }
            }
        }
    }
}
