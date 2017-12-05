Rの基本的な操作
===============

Rの基本関数はベクトル処理に最適化されており、変数を個別のベクトルとして保存する。**data.frame**は同じ長さのベクトルをまとめるためのオブジェクトであり、通常、多変量データはこのオブジェクトに格納される。ベクトルには数値(numeric)・整数(integer)・因子(factor)・文字列(character)などがある。Rの基本関数でも、ある程度の文字列処理ができるが、機能が限られ、ユニコードにも十分に対応していない。

``` r
# データの読み込み
data <- read.csv('data/asahi.csv', sep = "\t", stringsAsFactors = FALSE, encoding = 'UTF-8')

# データの最初の部分を表示
head(data)
```

    ##                  date edition section page length
    ## text592027 2016-01-01    朝刊  ３総合    3   1288
    ## text592028 2016-01-01    朝刊  ３総合    3    595
    ## text592029 2016-01-01    朝刊  １経済    4   3214
    ## text592030 2016-01-01    朝刊  １経済    4    983
    ## text592031 2016-01-01    朝刊  １外報    7    375
    ## text592032 2016-01-01    朝刊  １外報    7    497
    ##                                                                                            head
    ## text592027                               解散時期、政権見極め　支持率・株価も考慮か　同日選視野
    ## text592028                                   大統領府が談話、世論沈静化図る　日韓合意受け２度目
    ## text592029 （新発想で挑む　地方の現場から：１）常識を打ち破ろう　水田にトウモロコシ、農の救世主
    ## text592030         「中国はいずれＴＰＰに参加」　「『Ｇゼロ』後の世界」著者、イアン・ブレマー氏
    ## text592031                                                       国産空母の建造、中国政府認める
    ## text592032                                   韓国、大学生３０人を検挙　慰安婦問題合意で抗議行動
    ##                                        hash year month
    ## text592027 8b94af77cf10b662e4728e89257d252b 2016     1
    ## text592028 2c974c3cdb7a2e995fda5316d1bf6961 2016     1
    ## text592029 845f04b7f5bf7b8a3641a959bcbb93ba 2016     1
    ## text592030 ffbb56d8ce52e4faa11e2b4cc2eec56f 2016     1
    ## text592031 e3b5c2a6947176d8c9645db599ab8daa 2016     1
    ## text592032 5412a90ca34a10016410bea6a15c0d41 2016     1

``` r
# 数値の割り算
head(data$length / 1000)
```

    ## [1] 1.288 0.595 3.214 0.983 0.375 0.497

``` r
# 文字列の連結
head(paste(data$year, '年', data$month, '月', sep = ''))
```

    ## [1] "2016年1月" "2016年1月" "2016年1月" "2016年1月" "2016年1月" "2016年1月"

``` r
head(paste(data$edition, '_', data$page, '頁', sep = ''))
```

    ## [1] "朝刊_3頁" "朝刊_3頁" "朝刊_4頁" "朝刊_4頁" "朝刊_7頁" "朝刊_7頁"

``` r
# 文字列の分割
head(strsplit(data$head, split= '[　、]'))
```

    ## [[1]]
    ## [1] "解散時期"             "政権見極め"           "支持率・株価も考慮か"
    ## [4] "同日選視野"          
    ## 
    ## [[2]]
    ## [1] "大統領府が談話"     "世論沈静化図る"     "日韓合意受け２度目"
    ## 
    ## [[3]]
    ## [1] "（新発想で挑む"                      
    ## [2] "地方の現場から：１）常識を打ち破ろう"
    ## [3] "水田にトウモロコシ"                  
    ## [4] "農の救世主"                          
    ## 
    ## [[4]]
    ## [1] "「中国はいずれＴＰＰに参加」" "「『Ｇゼロ』後の世界」著者"  
    ## [3] "イアン・ブレマー氏"          
    ## 
    ## [[5]]
    ## [1] "国産空母の建造" "中国政府認める"
    ## 
    ## [[6]]
    ## [1] "韓国"                     "大学生３０人を検挙"      
    ## [3] "慰安婦問題合意で抗議行動"

quantedaの基礎
==============

基本オブジェクト
----------------

``` r
require(quanteda)
```

    ## Loading required package: quanteda

    ## quanteda version 0.99.9027

    ## Using 3 of 4 threads for parallel computing

    ## 
    ## Attaching package: 'quanteda'

    ## The following object is masked from 'package:utils':
    ## 
    ##     View

### corpus

**corpus**は、**data.frame**もしくは、文字列ベクトルから作成され、文書および文書変数を元の状態で格納する。

``` r
corp <- corpus(data, text_field = 'head')
summary(corp, n = 10)
```

    ## Corpus consisting of 16401 documents, showing 10 documents:
    ## 
    ##        Text Types Tokens Sentences       date edition          section
    ##  text592027    15     15         1 2016-01-01    朝刊           ３総合
    ##  text592028    15     15         1 2016-01-01    朝刊           ３総合
    ##  text592029    23     24         1 2016-01-01    朝刊           １経済
    ##  text592030    22     24         1 2016-01-01    朝刊           １経済
    ##  text592031     8      8         1 2016-01-01    朝刊           １外報
    ##  text592032    15     15         1 2016-01-01    朝刊           １外報
    ##  text592033    16     16         1 2016-01-01    朝刊           １外報
    ##  text592034    18     19         1 2016-01-01    朝刊 新年特集別刷０７
    ##  text592035    14     14         2 2016-01-01    朝刊 新年特集別刷０３
    ##  text592036    15     17         1 2016-01-01    朝刊           ２外報
    ##  page length                             hash year month
    ##     3   1288 8b94af77cf10b662e4728e89257d252b 2016     1
    ##     3    595 2c974c3cdb7a2e995fda5316d1bf6961 2016     1
    ##     4   3214 845f04b7f5bf7b8a3641a959bcbb93ba 2016     1
    ##     4    983 ffbb56d8ce52e4faa11e2b4cc2eec56f 2016     1
    ##     7    375 e3b5c2a6947176d8c9645db599ab8daa 2016     1
    ##     7    497 5412a90ca34a10016410bea6a15c0d41 2016     1
    ##     7    125 7c55fe3d1ac26476b2dd7f8e31a33db4 2016     1
    ##     7   1691 2dc85a2badfceb4c4ea771017db4af35 2016     1
    ##     7   1639 8f762ba278c257b60d8ede09c1503fb6 2016     1
    ##     9   1713 dafe45e5026c53126801d7acd6c9aad4 2016     1
    ## 
    ## Source:  /home/kohei/Documents/IJTA/* on x86_64 by kohei
    ## Created: Tue Dec  5 11:07:11 2017
    ## Notes:

``` r
ndoc(corp)
```

    ## [1] 16401

### tokens

**tokens**は、**corpus**から作成され、文を語に分割した状態で格納する。**tokens**は語の位置関係を保持するため、複合語の選択・削除・結合を行える。

``` r
toks <- tokens(corp)
head(toks)
```

    ## tokens from 6 documents.
    ## text592027 :
    ##  [1] "解散"   "時期"   "、"     "政権"   "見極め" "支持"   "率"    
    ##  [8] "・"     "株価"   "も"     "考慮"   "か"     "同日"   "選"    
    ## [15] "視野"  
    ## 
    ## text592028 :
    ##  [1] "大統領" "府"     "が"     "談話"   "、"     "世論"   "沈静"  
    ##  [8] "化"     "図る"   "日"     "韓"     "合意"   "受け"   "２"    
    ## [15] "度目"  
    ## 
    ## text592029 :
    ##  [1] "（"           "新"           "発想"         "で"          
    ##  [5] "挑む"         "地方"         "の"           "現場"        
    ##  [9] "から"         "："           "１"           "）"          
    ## [13] "常識"         "を"           "打ち"         "破"          
    ## [17] "ろう"         "水田"         "に"           "トウモロコシ"
    ## [21] "、"           "農"           "の"           "救世主"      
    ## 
    ## text592030 :
    ##  [1] "「"       "中国"     "は"       "いずれ"   "ＴＰＰ"   "に"      
    ##  [7] "参加"     "」"       "「"       "『"       "Ｇ"       "ゼ"      
    ## [13] "ロ"       "』"       "後"       "の"       "世界"     "」"      
    ## [19] "著者"     "、"       "イアン"   "・"       "ブレマー" "氏"      
    ## 
    ## text592031 :
    ## [1] "国産"   "空母"   "の"     "建造"   "、"     "中国"   "政府"   "認める"
    ## 
    ## text592032 :
    ##  [1] "韓国"   "、"     "大学生" "３"     "０"     "人"     "を"    
    ##  [8] "検挙"   "慰安"   "婦"     "問題"   "合意"   "で"     "抗議"  
    ## [15] "行動"

``` r
head(ntoken(toks))
```

    ## text592027 text592028 text592029 text592030 text592031 text592032 
    ##         15         15         24         24          8         15

### dfm

**dfm** (document-feature matrix)は、**tokens**から作成される文書行列であり、文書内の語の種類と頻度を記録する。**dfm**は**tokens**と異なり、語の位置関係を保持しない。

``` r
mx <- dfm(toks)
head(mx)
```

    ## Document-feature matrix of: 6 documents, 6 features (69.4% sparse).
    ## 6 x 6 sparse Matrix of class "dfm"
    ##             features
    ## docs         解散 時期 、 政権 見極め 支持
    ##   text592027    1    1  1    1      1    1
    ##   text592028    0    0  1    0      0    0
    ##   text592029    0    0  1    0      0    0
    ##   text592030    0    0  1    0      0    0
    ##   text592031    0    0  1    0      0    0
    ##   text592032    0    0  1    0      0    0

``` r
ndoc(mx)
```

    ## [1] 16401

``` r
nfeature(mx)
```

    ## [1] 15970

基本的なワークフロー
--------------------

**quanteda**における基本的な分析の流れは、**corpus**、**tokens**、**dfm**の順である。

簡略化されたワークフロー
------------------------

`dfm()`が自動的に必要な前処理を施し、**dfm**を作成するが、処理の柔軟性はやや低下する。

### 文字列ベクトルから直接dfmを作成

``` r
mx <- dfm(data$head)
head(mx)
```

    ## Document-feature matrix of: 6 documents, 6 features (69.4% sparse).
    ## 6 x 6 sparse Matrix of class "dfm"
    ##        features
    ## docs    解散 時期 、 政権 見極め 支持
    ##   text1    1    1  1    1      1    1
    ##   text2    0    0  1    0      0    0
    ##   text3    0    0  1    0      0    0
    ##   text4    0    0  1    0      0    0
    ##   text5    0    0  1    0      0    0
    ##   text6    0    0  1    0      0    0

``` r
ndoc(mx)
```

    ## [1] 16401

``` r
nfeature(mx)
```

    ## [1] 15970

### corpusから直接dfmを作成

``` r
mx <- dfm(corp)
head(mx)
```

    ## Document-feature matrix of: 6 documents, 6 features (69.4% sparse).
    ## 6 x 6 sparse Matrix of class "dfm"
    ##             features
    ## docs         解散 時期 、 政権 見極め 支持
    ##   text592027    1    1  1    1      1    1
    ##   text592028    0    0  1    0      0    0
    ##   text592029    0    0  1    0      0    0
    ##   text592030    0    0  1    0      0    0
    ##   text592031    0    0  1    0      0    0
    ##   text592032    0    0  1    0      0    0

``` r
ndoc(mx)
```

    ## [1] 16401

``` r
nfeature(mx)
```

    ## [1] 15970
