library(io)
library(ggplot2)
library(lubridate)
library(tidyr)

xs <- qread("data", pattern="daily-treasury-rates_.*.csv");

x <- do.call(rbind, xs);
colnames(x) <- tolower(colnames(x));
x$date <- mdy(x$date);
x <- x[order(x$date), ];

d <- pivot_longer(x, !date, names_to="term", values_to="yield");
d$term <- factor(d$term, levels=colnames(x)[-1]);

qdraw(
	ggplot(d, aes(x = date, y = yield)) +
		facet_wrap(~ term, ncol=1, scales="free_y", strip.position="right") +
		theme_classic() +
		theme(
			strip.background = element_blank(),
			strip.text.y.right = element_text(angle=0),
			panel.grid.minor.x = element_line(),
			panel.grid.major.x = element_line()
		) +
		geom_line() +
		geom_vline(xintercept=ymd("2011-08-02"), colour="firebrick") +
		xlab("time") + ylab("US treasury yield")
	,
	width = 8, height = 10,
	file = "us-treasury-yield_2011_debt-ceiling.png"
)

