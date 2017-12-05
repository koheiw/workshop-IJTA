# Linuxの場合は以下のコマンドでMecabをインストールできる
# apt-get install mecab libmecab-dev mecab-ipadic-utf8
#install.packages("RMeCab", repos = "http://rmecab.jp/R")

require(quanteda)

# Mecabを用いた分かち書き用の関数
char_segment <- function(txts) {
    txts_seg = vector("character")
    for (i in seq_along(txts)) {
        if (txts[i] != '') {
            toks <- unlist(RMeCab::RMeCabC(txts[[i]]), use.names = FALSE)
            txts_seg[i] <- stringi::stri_c(toks, collapse = ' ')
        } else {
            txts_seg[i] = ''
        }
        if (i %% 100 == 0) cat(i, "\n")
    }
    names(txts_seg) <- names(txts)
    return (txts_seg)
}

# データの読み込み
load("data/data_corpus_asahi_2016.rda")

# コーパスのコピー
data_corpus_asahi_2016_seg <- data_corpus_asahi_2016

# 本文の分かち書き
texts(data_corpus_asahi_2016_seg) <- char_segment(texts(data_corpus_asahi_2016))

# 保存
save(data_corpus_asahi_2016_seg, file='data/data_corpus_asahi_2016_seg.rda')
