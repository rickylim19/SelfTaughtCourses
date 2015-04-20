

# set global chunk options
# for figures
opts_chunk$set(fig.path='figs/', fig.align='center', fig.show='hold',
               dev='CairoPDF', out.width='.4\\linewidth')
# replacing "=" into "->" to make it R thing
options(replace.assign=TRUE,width=90)
# caching chunks
opts_chunk$set(cache.extra = R.version,cache.path='cache/')
opts_chunk$set(cache.extra = rand_seed)



library(ggplot2)
data(diamonds)
head(diamonds)
summary(diamonds)
dim(diamonds)
names(diamonds)
class(diamonds$color)
class(diamonds$cut)
class(diamonds$clarity)
summary(diamonds$color)



summary(diamonds$price)
p <- ggplot(aes(x=price), data=diamonds)+
        geom_histogram(binwidth=100)+
        scale_x_continuous(breaks=seq(100,20000, 500), limits=c(300, 10000))
p

p + facet_wrap(~cut, ncol=1, scales='free_y')


nrow(subset(diamonds, price < 500))
head(subset(diamonds, price < 500))
nrow(subset(diamonds, price < 250))
nrow(subset(diamonds, price >= 15000))
head(subset(diamonds, price >= 15000))

# cut prices
by(diamonds$price, diamonds$cut, summary)
by(diamonds$price, diamonds$cut, max)



head(diamonds)
summary(log10(diamonds$price.per.carat))
diamonds$price.per.carat <- diamonds$price/diamonds$carat
p <- ggplot(aes(x=price.per.carat), data=diamonds)+
        geom_histogram(binwidth=0.05)+
        scale_x_log10(breaks=seq(1000,10000, 1000))
        #scale_x_continuous(breaks=seq(100,20000, 500), limits=c(300, 10000))
p

p + facet_wrap(~cut, ncol=1, scales='free_y')



p <- ggplot(aes(x=clarity, y=price), data=diamonds) +
        geom_boxplot()
p
head(diamonds)
head(subset(diamonds, color=='D'))
                               
summary(subset(diamonds, color=='D')$price)
summary(subset(diamonds, color=='J')$price)
IQR(subset(diamonds, color=='D')$price) # the best color
IQR(subset(diamonds, color=='J')$price) # the worst color



summary(diamonds$carat)
p <- ggplot(aes(x=carat), data=diamonds) +
        geom_freqpoly(binwidth=0.01)+
        scale_x_continuous(breaks=seq(0,5,0.1))

p



library(ggplot2)
library(lubridate)
work_dir='/Users/RickyLim/Documents/OnlineLearning/DataAnalysisR/'
birthdays <- read.csv(paste0(work_dir, 'Data/birthdaysExample.csv'), 
                      header=TRUE)
dim(birthdays)
head(birthdays)
tail(birthdays)

birthdays$Date <- as.Date(birthdays$dates,format='%m/%d/%y')
birthdays$Month <- as.numeric(format(birthdays$Date, '%m'))
birthdays$Day <- as.numeric(format(birthdays$Date, '%d'))
birthdays$Year<- as.numeric(format(birthdays$Date, '%y'))

birthdays <- subset(birthdays, select=c(Date, Day, Month, Year))
birthdays$Month<- factor(birthdays$Month,levels=as.character(1:12),
                         labels=c("Jan","Feb","Mar","Apr","May","Jun",
                                 "Jul","Aug","Sep","Oct","Nov","Dec"),
                         ordered=TRUE)



head(birthdays)
p <- ggplot(aes(x=Month), data=birthdays) + 
        geom_histogram() + 
        scale_x_discrete() 
p

ggsave('figs/Month_bod.png', p)




library(xtable)
month_freq <- as.data.frame(table(birthdays$Month))
colnames(month_freq) <- c('Month', 'Freq')
print(xtable(month_freq))



Day_bod <- as.data.frame(table(birthdays$Day))
colnames(Day_bod) <- c('Day', 'Freq')
subset(Day_bod, Freq == max(Day_bod$Freq))



p <- ggplot(aes(x=Day), data=birthdays) + 
        geom_histogram() + 
        scale_x_discrete(breaks=1:31)+ 
        facet_wrap(~Month, ncol=1)
p
ggsave('figs/Day_bod.png', p)



sessionInfo()



library(knitr)
knit("problemSet3.Rnw" ) # compile to tex
purl("problemSet3.Rnw", documentation = 0) # extract R code only
knit2pdf("problemSet3.Rnw")


