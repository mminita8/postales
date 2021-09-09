library(readxl)
library(dplyr)

setwd("C:/Users/lenovo/Documents/analisis/postales")

## Leyendo EEFF 2020 SUPERCIAS
postales<-read.csv("bal2020.txt", sep="\t", header=TRUE, dec=",", colClasses = c("RUC"="character"), fileEncoding="UTF-16", skipNul = TRUE, fill=TRUE)

## EEFF de empresas con TH postal
postalTH<-read_excel("registrados.xlsx")
postalTH<-postalTH %>% select(-c(5:13))
colnames(postalTH)[2]<-"RUC"
postal<-postales
postal<-merge(postal, postalTH, by="RUC")
write.table(postal, "EEFFTH.txt", sep="\t", col.names=TRUE, row.names = FALSE)

## Posibles operadores postales
CIIU<-postal$CIIU
CIIU<-CIIU[!duplicated(CIIU)]
Npostal<-postales[(postales$CIIU %in% CIIU),]
Npostal<-Npostal[!(Npostal$RUC %in% postal$RUC),]
write.table(Npostal, "posibles.txt", sep="\t", col.names=TRUE, row.names = FALSE)

## Posibles H53 y con ingresos
NpostalH53<-Npostal[grep("H53", Npostal$CIIU),]
write.table(Npostalh53, "posiblesH53.txt", sep="\t", col.names=TRUE, row.names = FALSE)

