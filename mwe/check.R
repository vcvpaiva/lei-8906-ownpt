
options(width=155, digits=6, digits.secs=6)

wiki <- read.csv("ptwiki-20180622-all-titles-in-ns-0")
wiki$source  <- "wiki"
names(wiki)  <- c("term","source")
wiki$term  <- tolower(gsub("_"," ", wiki$term))

vp <- read.csv("mwes_proposed.txt", sep = "\t", comment.char = "#", header=FALSE)
vp$source  <- "vp"
names(vp)  <- c("term","source")

ar <- read.csv("antconc-AR.txt", sep = "\t", comment.char = "#", header=FALSE)
ar$source  <- "ar"
names(ar)  <- c("rank","freq","range","term","source")

antc  <- read.csv("antconc_results-0.txt", sep = "\t", comment.char = "#", header=FALSE)
antc$source  <- "antc"
names(antc)  <- c("rank","freq","range","term","source")

tmp.1 <- merge(antc,ar,by = "term", all=TRUE, suffixes = c(".antc",".ar"))
tmp.1$rank.ar  <- NULL
tmp.1$freq.ar  <- NULL
tmp.1$range.ar <- NULL

tmp.2 <- merge(tmp.1, vp, by = "term", all = TRUE, suffixes = c(".1",".vp"))
tmp.3 <- merge(tmp.2, wiki, by = "term", all = TRUE, suffixes = c(".vp",".wiki"))

tmp.3$source.AVWT  <- paste(ifelse(!is.na(tmp.3$source.ar),"A","0"),
                            ifelse(!is.na(tmp.3$source.vp),"V","0"),
                            ifelse(!is.na(tmp.3$source.wiki),"W","0"),
                            ifelse(!is.na(tmp.3$source.antc),"T","0"),
                            sep="")
tmp.3$source.ar  <- NULL
tmp.3$source.vp  <- NULL
tmp.3$source.wiki <- NULL
tmp.3$source.antc <- NULL

tmp.4  <- tmp.3[!duplicated(tmp.3), ]
tmp.4  <- subset(tmp.4, source.AVWT != "00W0")
write.table(tmp.4[order(tmp.4$freq.antc, decreasing=TRUE),], "mwe-consolidadas.csv", sep="\t", row.names=FALSE)
