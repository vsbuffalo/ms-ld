## create LD decay plot
require(ggplot2)
#files <- commandArgs(trailing=TRUE)[2]

files <- c("no-recomb.txt", "recomb.txt")
d <- do.call(rbind, lapply(files, function(ff) {
    tmp <- read.delim(ff, header=TRUE)
    tmp$sim <- gsub("([^\\.]+)\\..*", "\\1", basename(ff))
    tmp$dist <- abs(tmp$pos_i - tmp$pos_j)
    tmp
}))

p <- ggplot(subset(d, rsq < 1)) + geom_jitter(aes(x=dist, y=rsq, color=sim), alpha=0.6, size=1)
p <- p + geom_smooth(aes(x=dist, y=rsq, color=sim), se=FALSE)
p <- p + xlab("distance") + ylab(expression(r^{2}))

ggsave("sim.png", plot=p)
