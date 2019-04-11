library(WaveletComp)
# x = periodic.series(start.period = 20, end.period = 100, length = 1000)
# x = x + 0.2*rnorm(1000)  # add some noise
x1 <- periodic.series(start.period = 80, length = 1000)
x2 <- periodic.series(start.period = 30, length = 1000)
x <- x1 + x2 + 0.2*rnorm(1000)
plot(x, type="l")
my.data <- data.frame(x = x)
my.w <- analyze.wavelet(my.data, "x",loess.span = 0,dt = 1, 
                        dj = 1/250,lowerPeriod = 16, upperPeriod = 128,
                        make.pval = TRUE, n.sim = 10)

wt.image(my.w, color.key = "quantile", n.levels = 250,
         legend.params = list(lab = "wavelet power levels", mar = 4.7))

reconstruct(my.w, plot.waves = FALSE, lwd = c(1,2),legend.coords = "bottomleft", ylim = c(-1.8, 1.8))
