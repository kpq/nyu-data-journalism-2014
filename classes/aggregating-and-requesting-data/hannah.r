library(XML)
page <- htmlParse("http://www.yogajournal.com/poses/finder/anatomical_focus")
pages <- unlist(getNodeSet(page, "//div[@id='pose_content']//ul//li//a/@href"))
pages <- paste0("http://www.yogajournal.com/", pages)

processPage <- function(link){
	page <- htmlParse(link)
	things <- getNodeSet(page, "//div[@id='pose_content']//ul//li//a[@class='blue']")
	name <- sapply(things, xmlValue)
	poselink <- sapply(things, xmlGetAttr, "href")
	data.frame(name, poselink, link)
}


out <- NULL

for(i in 1:length(pages)){

	out <- rbind(out, processPage(pages[i]))

	otherpages <- unique(unlist(getNodeSet(htmlParse(pages[i]), "//div[@class='pages']//a/@href")))

	if(length(otherpages) > 0 ){
		otherpages <- paste0("http://www.yogajournal.com/", otherpages)
		for(j in 1:length(otherpages)){
			out <- rbind(out, processPage(otherpages[j]))
		}
	}

}

out$focus <- gsub("/\\?", "?", out$link)
out$focus <- gsub(".*/|\\?.*", "", out$focus)

write.csv(out, file = "~/Dropbox/hannah-yoga-journal.csv", row.names=F)