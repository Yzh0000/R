library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
#melting data frame
## melt(df, id, measure.vars)
carMelt <- melt(mtcars, id=c("carname","gear","cyl"), measure.vars = c("mpg","hp"))
head(carMelt, n =3)
# casting data frame
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData
