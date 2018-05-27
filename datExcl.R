library(openxlsx)
mainDF <- read.xlsx("DATABASE of Director and CEO.xlsx", sheet = 1, colNames = TRUE, rowNames = FALSE,skipEmptyCols = TRUE, startRow = 1)

workDF <- subset(mainDF,!duplicated(mainDF$Company.Name))

workDF2 <- subset(workDF,!duplicated(workDF$Email.ID,incomparables = NA))

workDF2 <- workDF2[,colSums(is.na(workDF2))<nrow(workDF2)] # remove empty cols

x <- c(1:23543)
workDF2$Sr..No<-x

workDF3 <- workDF2

#unique(workDF3$Region)
workDF3$Region<-tolower(workDF3$Region)
workDF3$Region <- gsub('\\s+', '', workDF3$Region)

colnames(workDF3)<-tolower(colnames(workDF3))

workDF3$country<-tolower(workDF3$country)
workDF3$country <- gsub('\\s+', '', workDF3$country)
unique(workDF3$country)

##industry
workDF3$industry<-tolower(workDF3$industry)
workDF3$industry <- gsub('\\s+', '', workDF3$industry)
#unique(workDF3$industry)

workDF3$industry[workDF3$industry=="+91(040)27819327"|
                   workDF3$industry=="-"|
                   workDF3$industry=="ignore"|
                   workDF3$industry=="yes"] <- NA

workDF3$industry[workDF3$industry=="networking&telecommunication"]<-"networking&telecommunications"

workDF3$industry[workDF3$industry=="it&ites"]<-"it/ites"

workDF3$industry[workDF3$industry=="lifescience"]<-"lifesciences"
workDF3$industry[workDF3$industry=="e-comerce"]<-"e-commerce"

workDF3$industry[workDF3$industry=="aerospace&defence"]<-"aerospace&defense"
workDF3$industry[workDF3$industry=="automobile,autoancillaries"]<-"automobile&autoancillaries"
workDF3$industry[workDF3$industry=="chemical"]<-"chemicals"
workDF3$industry[workDF3$industry=="electricalandelectronics"]<-"electrical&electronics"
workDF3$industry[workDF3$industry=="gems&jwellery"]<-"gems&jewellery"

workDF3$industry[workDF3$industry=="logistics&tranportation"|
                   workDF3$industry=="logisticsandtransportation"]<-"logistics&transportation"


workDF3$industry[workDF3$industry=="telecommunication&networking"|
                   workDF3$industry=="telecommunications&networking"]<-"networking&telecommunications"


workDF3$industry[workDF3$industry=="textileandgarments"|
                   workDF3$industry=="textile&garments"]<-"textiles&garments"

workDF3$industry[workDF3$industry=="retailandtrading"]<-"retail&trading"

workDF3$industry[workDF3$industry=="energyandutility"]<-"energy&utilities"


##cities

workDF3$city<-tolower(workDF3$city)
workDF3$city <- gsub('\\s+', '', workDF3$city)
#unique(workDF4$city)


##states
workDF3$state<-tolower(workDF3$state)
workDF3$state <- gsub('\\s+', '', workDF3$state)

#a <- sort(unique(workDF3$state))


workDF3$state[workDF3$state=="chhattisgarh"] <- "chattisgarh"

workDF3$state[workDF3$state=="chhattisgarh"] <- "chattisgarh"

workDF3$state[workDF3$state=="gujrat"] <- "gujarat"

workDF3$state[workDF3$state=="hyderabad"|workDF3$state=="teleangna"|
                workDF3$state=="telengna"] <- "telangana"

workDF3$state[workDF3$state=="newdelhi"] <- "delhi"

workDF3$state[workDF3$state=="kerela"] <- "kerala"

workDF3$state[workDF3$state=="kakinada"|workDF3$state=="karanataka"|
                workDF3$state=="karnatka"|
                workDF3$state=="kranataka"] <- "karnataka"

workDF3$state[workDF3$state=="odisha"] <- "orissa"

workDF3$state[workDF3$state=="uttaranchal"] <- "uttarakhand"

workDF3$state[workDF3$state=="maharastra"|workDF3$state=="maharshtra"|
                workDF3$state=="maharstra"|workDF3$state=="mahrashtra"|
                workDF3$state=="mahrashtra400007"|workDF3$state=="mahrastra"|
                workDF3$state=="mahrshtra"|workDF3$state=="kolhapur"|
                workDF3$state=="mumbai"] <- "maharashtra"

workDF3$state[workDF3$state=="andaman&nicobar"] <- "unionterritory"
workDF3$state[workDF3$state=="chennai"] <- "tamilnadu"
workDF3$state[workDF3$state=="-"] <- NA

expData <- data.frame(workDF3)
write.xlsx(expData,"DATABASE of Director and CEO.xlsx")
