より高度な分析
==============

**dfm**は、ほかのRのパッケージと互換性があるため、**quanteda**をテキストデータの前処理に用いて、さまざまな統計分析を行うことができる。

準備
----

``` r
require(quanteda) # パッケージの読み込み
```

``` r
load('data/data_corpus_asahi_2016.RData')

# 文書行列を作成
toks <- tokens(data_corpus_asahi_2016, remove_punct = TRUE)
mx <- dfm(toks)
mx <- dfm_select(mx, min_nchar = 2) # 一文字語を削除
mx <- dfm_remove(mx, '^[ぁ-ん]+$', valuetype = 'regex') # ひらがなを削除
mx <- dfm_trim(mx, min_count = 5) # 低頻度語を削除
nfeature(mx)
```

    ## [1] 27476

分析
----

### 共起ネットワーク分析

`fcm`によって文書内での語の共起関係についての行列を作成し、共起ネットワーク分析(意味ネットワーク分析)を行える。ネットワークの視覚化には**igraph**などの専門パッケージを利用する。

``` r
require(igraph)
```

``` r
mx_top <- mx[,names(topfeatures(mx, 20))] # 最も頻度が高い語を選択
mx_col <- fcm(mx_top, tri = FALSE) # 共起行列を作成
mx_nor <- dfm_weight(mx_col, 'relFreq') # 共起頻度を標準化
```

``` r
gr <- graph_from_adjacency_matrix(mx_nor, weighted = TRUE, diag = FALSE) # グラフオブジェクトを作成
igraph.options(plot.layout=layout.graphopt)
plot(gr, edge.width = E(gr)$weight * 20,  edge.arrow.size = 0.5, vertex.size = 20)
```

![](advanced_files/figure-markdown_github/plot1-1.png)
