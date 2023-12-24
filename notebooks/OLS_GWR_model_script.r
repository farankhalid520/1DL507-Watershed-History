
# R-4.3.2 used in the script
# Author: Venugopal

#loading the required libraries for the script
library(spgwr)
library(sp)
library(spdep)
library(gstat)
library(sf)
library(tmap)
library(stars)


#setwd("path/to/working/directory/of/the/shapefile")

# reading and loading the data
y20s04 <- st_read("E:\\test\\shapefile.shp")
#head(y20s04, 5)

# Ordinary Least Squares model
fit.ols <- glm(toc ~ ph + cond25 + alk_acid
               + ca + mg + na + k + so4 + cl + f + nh4_n + no2_no3_n
               + po4_p + tot_p + si + fe + tot_n + toc_ton, data = y20s04)
summary(fit.ols)


# Geographically weighted regression

# Turning the data into a spatial object
y20s04.sp <- as(y20s04,"Spatial")

# Calculating the optimal bandwidth. The default method is cross-validation
gwr.b1 <- gwr.sel(toc ~ ph + cond25 + alk_acid
                  + ca + mg + na + k + so4 + cl + f + nh4_n + no2_no3_n
                  + po4_p + tot_p + si + fe + tot_n + toc_ton, y20s04.sp)

# Outputs the estimated optimal bandwidth. The weighting function uses this BW
# and includes all the observations within this radius distance
gwr.b1

# The bandwidth estimated above is plugged into the gwr() 
gwr.fit1 <- gwr(toc ~ ph + cond25 + alk_acid 
                + ca + mg + na + k + so4 + cl + f + nh4_n + no2_no3_n 
                + po4_p + tot_p + si + fe + tot_n + toc_ton,
                data = y20s04.sp, bandwidth = gwr.b1, se.fit =T , hatmatrix = T)

# The default weighting function is Gaussian function, which can be 
# changed using the "gweight" argument to other options. This needs
# to specified in both estimating the optimal bandwidth and running GWR.

# Outputs the model
gwr.fit1  

# using Bi-square for estimating the bandwidth.
gwr.b2 <- gwr.sel(toc ~ ph + cond25 + alk_acid 
                  + ca + mg + na + k + so4 + cl + f + nh4_n + no2_no3_n
                  +po4_p +tot_p +si + fe + tot_n + toc_ton,
                  data = y20s04.sp, gweight = gwr.bisquare)

gwr.fit2 <- gwr(toc ~ ph + cond25 + alk_acid
                + ca + mg + na + k + so4 + cl + f + nh4_n + no2_no3_n
                + po4_p + tot_p + si + fe + tot_n + toc_ton,
                data = y20s04.sp, bandwidth = gwr.b2,
                gweight = gwr.bisquare, se.fit = T, hatmatrix = T) 


# Outputs the model for bisquare
gwr.fit2


# Using adaptive kernel to find the optimal bandwidth
gwr.b3 <- gwr.sel(toc ~ ph + cond25 + alk_acid
                  + ca + mg + na + k + so4 + cl + f + nh4_n + no2_no3_n
                  + po4_p + tot_p + si + fe + tot_n + toc_ton,
                  data = y20s04.sp, adapt = TRUE)

# The bandwidth will change as per the spatial density of features 
# in the input feature class. The bandwidth becomes a function of 
# the number of nearest neighbours. 
gwr.b3   


gwr.fit3 <- gwr(toc ~ ph + cond25 + alk_acid
                + ca + mg + na + k + so4 + cl + f + nh4_n + no2_no3_n
                + po4_p + tot_p + si + fe + tot_n + toc_ton,
                data = y20s04.sp, adapt = gwr.b3, se.fit = T, hatmatrix = T)

gwr.fit3   


# The degree of multi-collinearity can be examined using correlations
# between the coeffecients produced by the GWR. cor() is used for this purpose.
round(cor(as.data.frame(gwr.fit3$SDF[,2:11]),use = "complete.obs"),2)

# plots the correlations 
pairs(as(gwr.fit3$SDF, "data.frame")[,2:11],pch=".")


# "spgwr" has a suite of tests comparing the OLS and GWR models. The null in
# in these tests are OLS.

###  Brunsdon, Fotheringham & Charlton (2002, pp. 91-2) ANOVA
BFC02.gwr.test(gwr.fit3)

##  Brunsdon, Fotheringham & Charlton (1999) ANOVA
BFC99.gwr.test(gwr.fit3)

##  Leung et al. (2000) F(1) test
LMZ.F1GWR.test(gwr.fit3)

##  Leung et al. (2000) F(2) test
LMZ.F2GWR.test(gwr.fit3)

## Leung et al. (2000) F(3) test
LMZ.F3GWR.test(gwr.fit3)