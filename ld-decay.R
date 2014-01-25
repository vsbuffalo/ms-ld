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

samps <- sample(unique(d$sim), 12)
p <- ggplot(subset(d, sim %in% samps))
p <- p + geom_jitter(aes(x=dist, y=rsq, color=type), alpha=0.3, size=0.1)
p <- p + geom_smooth(aes(x=dist, y=rsq, color=type), se=FALSE)
p <- p + facet_wrap(~sim)
p <- p + xlab("distance") + ylab(expression(r^{2}))

ggsave("sim.png", plot=p)
