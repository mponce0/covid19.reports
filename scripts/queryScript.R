## queryScript.R

# load library
#library(covid19.analytics)
source("./testing.R")

# read data latest data
data <- covid19.data()

# save data...
write.csv(data,file=paste0("covid19_data-",Sys.Date(),".csv"))

# static and interactive plot 
TS.data <- covid19.data("ts-ALL")
totals.plt(TS.data, fileName="totals")
totals.plt(TS.data, "ALL", fileName="totals-all")

# interactive map of cases
live.map(data, fileName="livemap")

# REPORT
report.summary(Nentries=15,graphical.output=FALSE,saveReport=TRUE)

#############################################

### TOTS.PER.LOCATION()

cases <- c("confirmed","deaths","recovered")

for (i in seq_along(cases)) {
        i.case <- cases[i]
        header("",paste('processing ',i.case))

        # read the time series data for confirmed cases
        all.data <- covid19.data(paste0('ts-',i.case))

        # run on all the cases
        pdf(paste0("Japan_",i.case,".pdf"))
        tots.per.location(all.data,"Japan")
        dev.off()

}



##W GROWTH.RATE()

# read time series data for confirmed cases
TS.data <- covid19.data("ts-confirmed")

locs <- c("Hubei","Italy","Germany","Canada")
for (i in seq_along(locs)) {
        i.loc <- locs[i]

        print(i.loc)

        # compute changes and growth rates per location for 'Italy'
        pdf(paste0("gr-changes_",i.loc,".pdf"))
        growth.rate(TS.data,geo.loc=i.loc)
        dev.off()

}

###############################################

