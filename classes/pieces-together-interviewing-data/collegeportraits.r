library(XML)

states <- state.abb

setwd("~/Desktop/dl/ideas - big/colleges")

######
## a list of college pages
######

out <- NULL
for(i in 1:length(states)){


	state <- states[i]
	url <- sprintf("http://www.collegeportraits.org/%s/", state)
	statePage <- htmlParse(url)
	collegeCode <- sapply(getNodeSet(statePage, "//div[@class='stateleft']//a"), xmlGetAttr, "href")
	temp <- data.frame(collegeCode = collegeCode)
	
	if(nrow(temp) > 0 ){
		temp$state <- state
		out <- rbind(out, temp)
	}
	print(i)
}


######
## all the graduation rates
######

schoolrates <- NULL
for(j in 1:nrow(out)){

	print(j)

	school <- out$collegeCode[j]

	data <- htmlParse(sprintf("http://www.collegeportraits.org%s/tracker", school))

	rates <- try(readHTMLTable(getNodeSet(data, "//table")[[1]]))

	if(class(rates)!="try-error"){

		rates <- subset(rates, Description!="")

		rates$cohortEnd <- names(rates)[ncol(rates)]
		names(rates)[2:7] <- paste0("year", 1:6)

		rates$school <- school
		schoolrates <- rbind(schoolrates, rates)

	}

}


save(schoolrates, file = "schoolrates.rdata")


library(stringr)
load("/Users/amanda/Dropbox/colleges/schoolrates.rdata")
these <- grep("^year", names(schoolrates))
schoolrates[,these] <- sapply(schoolrates[,these], function(x) as.numeric(gsub("%", "", x)))
schoolrates <- schoolrates[!duplicated(schoolrates),]

other <- schoolrates[grep("another|Progress|other in| at other", schoolrates$Description),]
together <- schoolrates[grep("Total .* Enrolled|Total .* Graduated", schoolrates$Description),]
together$what <- together$Description

other$what <- as.character(other$Description)
other$what[other$what=="% Enrolled at other 4-year institutions"] <- "Enrolled at another 4-year institution"
other$what[other$what=="% Enrolled at other 2-year institutions"] <- "Enrolled at another 2-year institution"
other$what[other$what=="% Graduated from other institution with 4-year degree"] <- "Bachelors degree from another institution"


original <- schoolrates[grep("another|Progress|other in|at other|Total .* Enrolled|Total .* Graduated", schoolrates$Description, invert = T),] 
original$what <- gsub(" from.*| with .*| at .*", "", original$Description)
original$type <- gsub(".* with", "", original$Description)
original$type[grep(" with ", original$Description, invert = T)] <- ""
original$what <- str_trim(paste(original$what, original$type))
original$what <- gsub("  ", " ", original$what)

original$what <- gsub("% ", "", original$what)
original$what <- gsub("Graduated 4-year degree", "Bachelors degree", original$what)
original$what <- gsub("Graduated 2-year degree", "Associates degree", original$what)
original$what <- paste0(original$what, ", original school")

original <- original[,-c(match("type", names(original)))]
schoolrates <- rbind(other, together, original)

makeSheet <- function(var, out){

gg <- schoolrates[,c("school", "what", var, "cohortEnd")]
gg$what[gg$what=="Associates degree, original school" & gg$cohortEnd=="2011-12"] <- "Associates degree, original school or some other school"

zz <- reshape(gg, direction = "wide", timevar = "what", "idvar" = c("school","cohortEnd"))
names(zz) <- gsub(paste0(var, "."), "", names(zz))

zz <- zz[ ,c("school",	
"cohortEnd",
"Bachelors degree, original school",	
"Bachelors degree from another institution",	
"Associates degree, original school",	
"Associates degree from another institution",	
"Associates degree, original school or some other school",
"Total Graduated at another institution",	
"Total Graduated, original school",	
"Total % Graduated",	
"Enrolled, original school",	
"Enrolled at another 4-year institution",	
"Enrolled at another 2-year institution",
"Total Transferred and enrolled at another institution",
"Total % Enrolled",
"Student Success & Progress")]
zz <- zz[order(zz$cohortEnd),]


these <- is.na(zz$"Total % Graduated")
zz$"Total % Graduated"[these] <- zz$"Total Graduated at another institution"[these] + zz$"Total Graduated, original school"[these]

zz$"Total Transferred and enrolled at another institution" <- zz$"Enrolled at another 4-year institution" + zz$"Enrolled at another 2-year institution"
zz$"Total % Enrolled" <- zz$"Enrolled, original school" + zz$"Total Transferred and enrolled at another institution"

these <- is.na(zz$"Associates degree, original school or some other school")
zz$"Associates degree, original school or some other school"[these] <- zz$"Associates degree, original school"[these] + zz$"Associates degree from another institution"[these]


write.csv(zz, file = out, row.names = F)
#system(paste("open", out))
zz

}
year6 <- makeSheet("year6", "schoolrates6.csv")
year4 <- makeSheet("year4", "schoolrates4.csv")


library(XML)
schools <- year6$school

#out <- NULL
for(i in 218:length(schools)){

	thisschool <- year6$school[i]

	url <- htmlParse(sprintf("http://www.collegeportraits.org/%s/undergrad_success", thisschool ))
	schoolname <- url[[("string(//h1)")]]
	progN <- xmlValue(getNodeSet(url, "//div[@class='border_level_two']//ul//li")[[1]])


	url <- htmlParse(sprintf("http://www.collegeportraits.org/%s/characteristics", thisschool ))
	oldpoor <- readHTMLTable(getNodeSet(url, '//table')[[3]], header = F)
	race <- readHTMLTable(getNodeSet(url, '//table')[[2]], header = F)

	lowincome <- as.character(subset(oldpoor, V1 == "% of Undergraduate Students Who Are Low Income Students")$V2)
	older <- as.character(subset(oldpoor, V1 == "Percent of Undergraduates Age 25 or Older")$V2)

	white <- as.character(subset(race, V1 == "White")$V3)
	black <- as.character(subset(race, V1 == "African American / Black")$V3)
	hispanic <- as.character(subset(race, V1 == "Hispanic")$V3)
	asian <- as.character(subset(race, V1 == "Asian")$V3)
	women <- as.character(subset(race, V1 == "Women")$V3)
	intl <- as.character(subset(race, V1 == "International")$V3)

	url <- htmlParse(sprintf("http://www.collegeportraits.org/%s/undergrad_admissions", thisschool ))
	scores <- try(readHTMLTable(url)[[1]])
	if(class(scores)!="try-error"){
		act <- as.character(scores[scores[,1]=="Composite",]$ACT)
		sat <- as.character(scores[scores[,1]=="Composite",]$SAT)
		gpa <- readHTMLTable(url, header = F)[[2]]
		gpaAvg <- as.character(gpa$V2[gpa$V1 == "Average High School GPA (4-point scale)"])
		top25hs <- as.character(gpa$V2[gpa$V1 == "Percent in top 25% of High School Graduating Class"])
		top50hs <- as.character(gpa$V2[gpa$V1 == "Percent in top 50% of High School Graduating Class"])
	}else{
		act <- NA
		sat <- NA
		gpaAvg <- NA
		top25hs <- NA
		top50hs <- NA
	}


	url <- htmlParse(sprintf("http://www.collegeportraits.org/%s/campus_life", thisschool ))
	classes <- readHTMLTable(url, header = F)[[1]]

	studentsPerFaculty <- as.character(classes$V2[classes$V1=="Students per Faculty"])
	classesUnder30students <- as.character(classes$V2[classes$V1=="Undergraduate classes with fewer than 30 students"])
	classesUnder50students <- as.character(classes$V2[classes$V1=="Undergraduate classes with fewer than 50 students"])
	facultyPHD <- as.character(classes$V2[classes$V1=="% of Full-Time Instructional Faculty Who Have the Highest Academic Degree Offered in Their Field of Study"])

	campus <- xmlValue(getNodeSet(url, "//div[@id='content_two']//div[@class='border_level_two']//p")[[1]])
	campus <- strsplit(campus, split = "\n")[[1]]
	freshmanInDorms <- campus[2]
	ugradsInDorms <- campus[4]

	if(length(sat)==0) sat <- NA
	if(length(act)==0) act <- NA
	if(length(top25hs)==0) top25hs <- NA
	if(length(top50hs)==0) top50hs <- NA
	if(length(gpaAvg)==0) gpaAvg <- NA

	temp <- data.frame(school = thisschool, schoolname, progN, lowincome, older, white, black, hispanic, asian, intl, women, typicalACT = act, typicalSAT = sat , gpaAvg, top25hs, top50hs, studentsPerFaculty, classesUnder30students, classesUnder50students, facultyPHD, freshmanInDorms, ugradsInDorms)
	out <- rbind(out, temp)
	print(i)
}
out$progN <- str_trim(gsub("First-Time, Full-Time Students", "", out$progN))
out$schoolname <- str_trim(gsub(" College Portrait", "", out$schoolname))
out$freshmanInDorms <- str_trim(gsub("of new freshmen live in campus-based housing or residence halls.", "", out$freshmanInDorms))
out$ugradsInDorms <- gsub("of all undergraduates live on campus", "", out$ugradsInDorms)

save(out, file = "collegechars.rdata")
out2 <- out
for(i in 3:ncol(out)){
	out[,i] <- gsub("\\%|,", "", out[,i])
}

out3 <- merge(year6, out, by = "school", all = T)

write.csv(out3, file = "~/Desktop/year6andCharacteristics.csv", row.names = F)

schoolrates$schoolname <- out3$schoolname[match(schoolrates$school, out3$school )]
schoolrates <- schoolrates[order(schoolrates$school),]
write.csv(schoolrates, file = "~/Desktop/schoolrates.csv", row.names = F)

write.csv(year4, file = '~/Desktop/year4.csv', row.names = F)





prog <- subset(schoolrates, Description == "Student Success & Progress")
prog[prog==0] <- NA


plot(0, type = "n", xlim = c(0, 9), ylim = c(0, 100), xlab = "year", ylab = "percent still making progress")
for(i in 1:nrow(prog)){
	lines(1:6, prog[i,these], col = adjustcolor("grey", alpha = .5))
	text(6.2, prog[i, these[6]], prog[i, "school"], cex = .5, adj = 0, col = adjustcolor("grey", alpha = .5))
}

library(plotrix)
prog <- prog[!duplicated(prog$school),]
prog <- subset(prog, !is.na(year4))
plot(prog$year4, prog$year6, cex = .5)
pointLabel(prog$year4, prog$year6, prog$school, offset = 0, cex = .5)


xx <- schoolrates[grep("Graduated from", schoolrates$Description),]
xx <- xx[-c(grep("other institution", xx$Description)),]
plot(xx$year6, prog$year6, type = "n", xlim = c(10, 100), ylim = c(10, 100), xlab = "6-year graduation", ylab = "6-year progress")
text(xx$year6[!duplicated(xx$school)], prog$year6[!duplicated(xx$school)], xx$school[!duplicated(xx$school)], cex = .5)
abline(h = 0)






