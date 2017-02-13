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
library(RMySQL)
ucscDb <- dbConnect(MySQL(), user="genome", 
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);

hg19 <- dbConnect(MySQL(), user="genome", db ="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
dbListFields(hg19, "HInv")
#nrow
dbGetQuery(hg19, "select count(*) from HInv")
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)
#select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10); dbClearResult(query)
dim(affyMisSmall)
#close connection
dbDisconnect(hg19)
