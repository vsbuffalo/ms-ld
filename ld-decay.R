## create LD decay plot
require(ggplot2)

files <- commandArgs(trailing=TRUE)
#files <- c("no-recomb.txt", "recomb.txt") # for testing

d <- do.call(rbind, lapply(files, function(ff) {
    tmp <- read.delim(ff, header=TRUE)
    tmp$type <- gsub("([^\\.]+)\\..*", "\\1", basename(ff))
    tmp$dist <- abs(tmp$pos_i - tmp$pos_j)
    tmp
}))

## p <- ggplot(subset(d, rsq < 1)) # + geom_jitter(aes(x=dist, y=rsq, color=sim), alpha=0.6, size=1)
## p <- p + geom_smooth(aes(x=dist, y=rsq, color=type), se=FALSE)
## p <- p + xlab("distance") + ylab(expression(r^{2}))

ggplot(d) + geom_smooth(aes(x=dist, y=rsq, group=sim), se=FALSE)  + facet_wrap(~type)

ggsave("sim.png", plot=p)
