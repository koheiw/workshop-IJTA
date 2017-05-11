require(quanteda)

data <- read.csv2('extra/higashiyama_sentiment.csv', 
                  sep = "\t", head = FALSE, stringsAsFactors = FALSE)
colnames(data) <- c('word', 'sentiment', 'desc')

dict <- dictionary(positive = data$word[data$sentiment == 'p'], 
                   negative = data$word[data$sentiment == 'n'])
cat(as.yaml(dict), file = 'extra/higashiyama_sentiment.yaml')
