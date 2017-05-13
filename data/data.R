require(quanteda)

# base and stringi functions
data <- read.csv("../Kikuzo/q13/data.csv", sep='\t', quote = '', as.is = TRUE, head = FALSE)
data$txt <- readLines("../Kikuzo/q13/data.txt")
colnames(data) <- c('date', 'edition', 'section', 'page', 'length', 'head', 'hash', 'body')
data$date <- as.Date(data$date)
data$year <- as.numeric(format(data$date, '%Y'))
data$month <- as.numeric(format(data$date, '%m'))

# quanteda funcitons
data_corpus_asahi <- corpus(data, text_field = 'body')
data_corpus_asahi_2016 <- corpus_subset(data_corpus_asahi, year == 2016)
docnames(data_corpus_asahi_2016) <- paste0('text', seq_len(ndoc(data_corpus_asahi_2016)))
save(data_corpus_asahi_2016, file = 'data/data_corpus_asahi_2016.RData')
