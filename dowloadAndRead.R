#get various type of data
if (!file.exists("data")) {
    dir.create("data")
}
#url of data
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
#download csv (for mac, set method = "curl)
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
dateDownloaded <- date()
#read data
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

#XML
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternalNodes  = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
#tag names of the sub-nodes of rootNode
names(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
#programatically extract parts of the file
xmlSApply(rootNode, xmlValue)
#Xpath
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)
#html
fileUrl <- "http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternalNodes = TRUE)
scores <- xpathSApply(doc, "//div[@class = 'score']", xmlValue)
teams <- xpathSApply(doc, "//div[@class = 'game-info']", xmlValue)
scores
teams
#JSON
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
head(jsonData)
names(jsonData)
# items in owner
names(jsonData$owner)
# to JSON
myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)

#mySQL




