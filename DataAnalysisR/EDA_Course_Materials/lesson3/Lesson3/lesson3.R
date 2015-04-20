

# set global chunk options
# for figures
opts_chunk$set(fig.path='figs/', fig.align='center', fig.show='hold',
               dev='CairoPDF', out.width='.4\\linewidth')
# replacing "=" into "->" to make it R thing
options(replace.assign=TRUE,width=90)
# caching chunks
opts_chunk$set(cache.extra = R.version,cache.path='cache/')
opts_chunk$set(cache.extra = rand_seed)



work_dir = '/Users/RickyLim/Documents/OnlineLearning/DataAnalysisR/'
library(ggplot2)



pf <- read.csv(paste0(work_dir, 'Data/pseudo_facebook.tsv'), 
               sep = '\t')
dim(pf)
head(pf)



names(pf)
p <- qplot(x = dob_day, data=pf ) +
        scale_x_discrete(breaks=1:31) + 
        facet_wrap(~dob_month, ncol=3)
ggsave('figs/user_bod.pdf')




sessionInfo()



library(knitr)
knit("lesson3.Rnw" ) # compile to tex
purl("lesson3.Rnw", documentation = 0) # extract R code only
knit2pdf("lesson3.Rnw")


