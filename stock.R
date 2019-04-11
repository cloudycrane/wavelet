library(quantmod)
library(WaveletComp)

setSymbolLookup(WK=list(name='FB',src='yahoo'))
getSymbols("FB")
chartSeries(FB)


# x <- WK$`000002.SZ.Close`
x <- FB$FB.Close
x <- log(x)
index.na <- which(is.na(x))
x[index.na, ] = x[index.na-1,]
plot(x, type="l")
my.data <- data.frame(x = x, row.names=NULL)
my.w <- analyze.wavelet(my.data, 1, loess.span = 0.5,dt = 1, 
                        dj = 1/250,lowerPeriod = 16, 
                        # upperPeriod = 512,
                        make.pval = TRUE, n.sim = 10)

wt.image(my.w, color.key = "quantile", n.levels = 250,
         legend.params = list(lab = "wavelet power levels", mar = 4.7))

wt.avg(my.w, siglvl = 0.05, sigcol = "red", 
       periodlab = "period (days)")

reconstruct(my.w, plot.waves = FALSE, lwd = c(1,2),legend.coords = "bottomleft", ylim = c(-1.8, 1.8))
