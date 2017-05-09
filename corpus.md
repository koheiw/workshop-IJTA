    ## Loading required package: quanteda

    ## quanteda version 0.9.9.57

    ## Using 3 of 4 cores for parallel computing

    ## 
    ## Attaching package: 'quanteda'

    ## The following object is masked from 'package:utils':
    ## 
    ##     View

corpusの作成
------------

`corpus`を作成するためのテキストの読み込みは、Rの基本的な機能を利用する。Rに読み込むテキストの文字コードは常にUTF-8となるように注意する。

``` r
# テキストのみの場合
txt <- readLines("asahi_head.txt")
corp <- corpus(txt)
head(corp)
```

    ##                                                                                  text1 
    ##                               "解散時期、政権見極め　支持率・株価も考慮か　同日選視野" 
    ##                                                                                  text2 
    ##                                   "大統領府が談話、世論沈静化図る　日韓合意受け２度目" 
    ##                                                                                  text3 
    ## "（新発想で挑む　地方の現場から：１）常識を打ち破ろう　水田にトウモロコシ、農の救世主" 
    ##                                                                                  text4 
    ##         "「中国はいずれＴＰＰに参加」　「『Ｇゼロ』後の世界」著者、イアン・ブレマー氏"

``` r
# テキストが文書変数を伴う場合
data <- read.csv('asahi.csv', sep = "\t", stringsAsFactors = FALSE)
corp <- corpus(data, text_field = 'head')
head(corp)
```

    ##                                                                             text592027 
    ##                               "解散時期、政権見極め　支持率・株価も考慮か　同日選視野" 
    ##                                                                             text592028 
    ##                                   "大統領府が談話、世論沈静化図る　日韓合意受け２度目" 
    ##                                                                             text592029 
    ## "（新発想で挑む　地方の現場から：１）常識を打ち破ろう　水田にトウモロコシ、農の救世主" 
    ##                                                                             text592030 
    ##         "「中国はいずれＴＰＰに参加」　「『Ｇゼロ』後の世界」著者、イアン・ブレマー氏"

``` r
head(docvars(corp))
```

    ##                  date edition section page length
    ## text592027 2016-01-01    朝刊  ３総合    3   1288
    ## text592028 2016-01-01    朝刊  ３総合    3    595
    ## text592029 2016-01-01    朝刊  １経済    4   3214
    ## text592030 2016-01-01    朝刊  １経済    4    983
    ## text592031 2016-01-01    朝刊  １外報    7    375
    ## text592032 2016-01-01    朝刊  １外報    7    497
    ##                                        hash year month
    ## text592027 8b94af77cf10b662e4728e89257d252b 2016     1
    ## text592028 2c974c3cdb7a2e995fda5316d1bf6961 2016     1
    ## text592029 845f04b7f5bf7b8a3641a959bcbb93ba 2016     1
    ## text592030 ffbb56d8ce52e4faa11e2b4cc2eec56f 2016     1
    ## text592031 e3b5c2a6947176d8c9645db599ab8daa 2016     1
    ## text592032 5412a90ca34a10016410bea6a15c0d41 2016     1

``` r
# 保存
save(corp, file = 'data_corpus_asahi_head.RData')
```

テキストが複数のファイルに分かれている場合
==========================================

[readtext](https://github.com/kbenoit/readtext)パッケージを利用すると簡単にフォルダやファイルの名前から文書変数を生成できる。

corpusの操作
------------

``` r
load('data_corpus_asahi_2016.RData')
ndoc(data_corpus_asahi_2016)
```

    ## [1] 16401

``` r
# 文書の選択
corp_may <- corpus_subset(data_corpus_asahi_2016, month == 5)
ndoc(corp_may)
```

    ## [1] 1454

``` r
table(docvars(corp_may, 'month'))
```

    ## 
    ##    5 
    ## 1454

``` r
corp_toppage <- corpus_subset(data_corpus_asahi_2016, page == 1)
ndoc(corp_toppage)
```

    ## [1] 1116

``` r
table(docvars(corp_toppage, 'section'))
```

    ## 
    ##         名ａ＋Ｃ１面 新潟全県・地方別刷Ａ               １総合 
    ##                    1                    1                 1103 
    ##     週末ｂｅ・ｂ０１         グローブ１面 
    ##                   10                    1

``` r
# 文書の分割
corp_sent <- corpus_segment(data_corpus_asahi_2016, what = "other", delimiter = "。")
ndoc(corp_sent)
```

    ## [1] 392792
