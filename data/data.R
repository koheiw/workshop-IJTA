require(quanteda)

# 文書変数の読み込み
data <- read.csv("../Kikuzo/q13/data.csv", sep='\t', quote = '', as.is = TRUE, head = FALSE)

# 本文の読み込み
data$txt <- readLines("../Kikuzo/q13/data.txt", encoding = 'utf8')

# 変数を命名
colnames(data) <- c('date', 'edition', 'section', 'page', 'length', 'head', 'hash', 'body')

# 文字列から日付に変換
data$date <- as.Date(data$date)
data$year <- as.numeric(format(data$date, '%Y'))
data$month <- as.numeric(format(data$date, '%m'))

# corpusを生成
data_corpus_asahi <- corpus(data, text_field = 'body')

# 2016年の記事を抽出
data_corpus_asahi_2016 <- corpus_subset(data_corpus_asahi, year == 2016)

# 文書名の振り直し
docnames(data_corpus_asahi_2016) <- paste0('text', seq_len(ndoc(data_corpus_asahi_2016)))

# 保存
save(data_corpus_asahi_2016, file = 'data/data_corpus_asahi_2016.RData')
