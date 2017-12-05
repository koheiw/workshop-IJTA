より高度な分析
==============

**dfm**は、ほかのRパッケージと互換性があるため、**quanteda**をテキストデータの前処理に用いて、さまざまな統計分析を行うことができる。

準備
----

``` r
require(quanteda) # パッケージの読み込み
```

``` r
load('data/data_corpus_asahi_2016_seg.rda')

# 文書行列を作成
toks <- tokens(data_corpus_asahi_2016_seg, what = "fastestword", remove_punct = FALSE)
mx <- dfm(toks)
mx <- dfm_select(mx, min_nchar = 2) # 一文字語を削除
mx <- dfm_remove(mx, '^[ぁ-ん]+$', valuetype = 'regex') # ひらがなを削除
mx <- dfm_trim(mx, min_count = 5) # 低頻度語を削除
nfeature(mx)
```

    ## [1] 30165

分析
----

### 共起ネットワーク分析

`fcm`によって文書内での語の共起関係についての行列を作成し、共起ネットワーク分析（意味ネットワーク分析）を行える。ネットワークの視覚化には**igraph**などの専門パッケージを利用する。

``` r
# 日本が言及されている記事と言及されていない記事を比較
key_jp <- textstat_keyness(mx, which(rowSums(dfm_select(mx, '日本')) > 0))

feat <- head(rownames(key_jp), 100) # 日本と最も強く関連する100語を選択
mx_col <- fcm(mx, tri = FALSE) # 共起行列を作成
mx_col <- fcm_select(mx_col, feat)
```

``` r
textplot_network(mx_col)
```

![](advanced_files/figure-markdown_github/plot1-1.png)
