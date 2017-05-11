``` r
require(quanteda)
```

dfm
===

dfm（document-feature matrix）は、行が文書で列が語を表す行列である。調査データなどと比較して、テキストデータは変数の数が多くなるため、dfmを作成した後に、語の頻度などに基づき、`dfm_select()`や`dfm_trim()`などで特長語の抽出を行うと、期待した分析結果が出ることが多い。

作成
----

``` r
load('data/data_corpus_asahi_2016.RData')

# 文書行列を作成
toks <- tokens(data_corpus_asahi_2016, remove_punct = TRUE)
mx <- dfm(toks)
nfeature(mx)
## [1] 69552
topfeatures(mx)
##     の     を     に     は     が     た     と     で     て   した 
## 535473 333250 282844 259779 255923 173693 170981 140091  90675  83094
```

操作
----

``` r

# 一文字語を削除
mx <- dfm_select(mx, min_nchar = 2)

# ひらがなを削除
mx <- dfm_remove(mx, '^[ぁ-ん]+$', valuetype = 'regex')

# 低頻度語を削除
mx <- dfm_trim(mx, min_count = 5)
nfeature(mx)
## [1] 27476
topfeatures(mx, 100)
##     日本     政府     政治     選挙     問題     経済     説明     投票 
##    20977    17543    16199    14754    11107    10999     9928     9554 
##     社会     首相     憲法     政権     東京     中国     考え     関係 
##     9079     9065     8841     8236     8227     8211     8148     8005 
##     政策   大統領     必要     写真     参院     議員     受け     国民 
##     7491     7406     7342     7339     7208     7170     7059     7051 
##     米国     世界     支援     安倍     反対     委員     原発     昨年 
##     6897     6683     6514     6455     6441     6045     5707     5674 
##     代表     女性     活動     支持     企業     国際     以上     参加 
##     5599     5548     5502     5490     5454     5286     5257     5254 
##     地域     会議     自分     思い     調査     向け     国会     市民 
##     5225     5088     5023     4955     4921     4917     4912     4878 
##     団体     多く     知事     安全     大学     求め     対策     今回 
##     4856     4767     4692     4673     4583     4579     4534     4505 
##     訴え   北朝鮮     野党   自民党     批判     指摘     民進     情報 
##     4440     4415     4370     4294     4280     4251     4235     4231 
##     議論     教授     改正     保障 トランプ     教育     一方     実現 
##     4228     4227     4191     4164     4149     4062     4014     4008 
##     韓国     生活     時間     沖縄     示し     市長     候補     時代 
##     3986     3915     3908     3893     3882     3856     3843     3805 
##     記者     意見     話す     戦争     思う     平和   子ども     制度 
##     3801     3788     3740     3693     3661     3653     3637     3614 
##     事業     共産     労働     賛成     発表     判断     地方     対応 
##     3596     3570     3565     3552     3550     3544     3530     3490 
##     会長     会見     計画   可能性 
##     3471     3457     3443     3399
```

分析
----

`dfm`は文字の文書内での位置を保持しないためいわゆるbag-of-wordsで、Rの一般線形モデルや主成分分析などを適用できるが、**quangteda**は、文書に特化した分析機能（`teststats_*()`）を複数含んでいる。

### 相対頻度分析

`teststat_keyness()`は二つの文書のグループを比較し、頻度が特別に高い（もしくは低い）語を抽出する。

``` r

# 社会面の特長語抽出
keys <- textstat_keyness(mx, docvars(mx, 'section') == '１社会' | docvars(mx, 'section') == '２社会')
head(keys, 20)
##             chi2 p n_target n_reference
## 沖縄   1322.2001 0      947        2946
## 名古屋 1311.5860 0      415         654
## 田母神 1254.8376 0      129          14
## 被爆   1049.5574 0      485        1091
## 小池    876.8847 0      333         629
## 大阪    846.6060 0      729        2541
## 舛添    842.1473 0      343         691
## 愛知    831.7582 0      283         480
## 東京    734.1929 0     1357        6870
## 都議会  666.8710 0      174         219
## 米兵    648.1956 0      156         177
## 都知事  645.8488 0      244         458
## 河村    610.1871 0      132         129
## 基地    581.9771 0      457        1505
## 都議    554.6627 0      143         177
## 福岡    548.5063 0      365        1079
## 参照    533.3369 0      261         614
## ｕｒ    486.0263 0       99          88
## 三笠    484.2908 0       63          21
## 被害    466.0293 0      529        2145
```

### 辞書分析

`dfm`上で辞書分析を行うために`dfm_lookup()`を利用することもできるが、`dfm()`の`dictionary`引数に辞書を渡すことで、すぐさま分析の結果を得られる。

``` r

# 感情分析辞書（Higashiyama et al. 2008) の読み込み
dict <- dictionary(file = 'extra/higashiyama_sentiment.yml')

names(toks) <- docvars(toks, 'date') # 文書名を日にちにする
wordage <- rowSums(dfm_compress(dfm(toks))) # 日ごとの総文字数

toks_trump <- as.tokens(kwic(toks, "トランプ"))
mx_trump <- dfm(toks_trump, dictionary = dict)
mx_trump <- dfm_compress(mx_trump) # 日ごとに集計
mx_trump <- dfm_select(mx_trump, documents = unique(names(toks)), valuetype = 'fixed', padding = TRUE) # 日付を補完
mx_trump <- mx_trump[order(docnames(mx_trump)),] # 日にちで並べ替え
plot((mx_trump[,'positive'] - mx_trump[,'negative']) / wordage, type = 'l')
```

![](dfm_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
toks_clinton <- as.tokens(kwic(toks, "クリントン"))
mx_clinton <- dfm(toks_clinton, dictionary = dict)
mx_clinton <- dfm_compress(mx_clinton) # 日ごとに集計
mx_clinton <- dfm_select(mx_clinton, documents = unique(names(toks)), valuetype = 'fixed', padding = TRUE) # 日付を補完
mx_clinton <- mx_clinton[order(docnames(mx_clinton)),] # 日にちで並べ替え
plot((mx_clinton[,'positive'] - mx_clinton[,'negative']) / wordage , type = 'l')
```

![](dfm_files/figure-markdown_github/unnamed-chunk-6-1.png) \#\#\#\# グラフのカスタマイズ ![](dfm_files/figure-markdown_github/unnamed-chunk-7-1.png)

### トピックモデル

トピックモデルは広く使われている教師なし文書分類手法の総称。dfmは，`convert()`によって**topicmodels**や**LDA**などトピックモデルに特化したパッケージ用の文書行列へと変換できる。これらのパッケージをLinuxで利用するためには、`sudo sudo apt-get install libgsl0-dev1`を実行し、依存ファイルをインストールする必要がある。

``` r
require(topicmodels)
## Loading required package: topicmodels

mx_front <- mx[which(docvars(mx, 'page') == 1),]
lda_k20 <- LDA(convert(mx_front, to = "topicmodels"), k = 20) # 20の話題を発見する
get_terms(lda_k20, 10) # 最も重要な10語を表示
##       Topic 1 Topic 2  Topic 3      Topic 4  Topic 5      Topic 6  Topic 7
##  [1,] "憲法"  "日本"   "沖縄"       "首相"   "社説"       "テロ"   "熊本" 
##  [2,] "国会"  "ｅｕ"   "政府"       "会談"   "日本"       "ｉｓ"   "地震" 
##  [3,] "参院"  "協定"   "知事"       "日本"   "経済"       "政府"   "被害" 
##  [4,] "法案"  "英国"   "移設"       "首脳"   "文化"       "トルコ" "退位" 
##  [5,] "民進"  "離脱"   "翁長"       "安倍"   "スポーツ"   "日本"   "政府" 
##  [6,] "改正"  "政治"   "中国"       "大統領" "国際"       "容疑"   "被災" 
##  [7,] "野党"  "世界"   "普天間"     "問題"   "将棋"       "事件"   "午前" 
##  [8,] "日本"  "欧州"   "辺野古"     "経済"   "フォーラム" "爆発"   "震度" 
##  [9,] "会議"  "投票"   "飛行場"     "協力"   "囲碁"       "組織"   "避難" 
## [10,] "首相"  "大統領" "オスプレイ" "訪問"   "地域"       "過激派" "災害" 
##       Topic 8 Topic 9  Topic 10 Topic 11 Topic 12 Topic 13   Topic 14    
##  [1,] "難民"  "舛添"   "自治体" "首相"   "原発"   "トランプ" "フィリピン"
##  [2,] "日本"  "政治"   "保育"   "政府"   "事故"   "政治"     "陛下"      
##  [3,] "東京"  "説明"   "児童"   "年金"   "電力"   "選挙"     "日本"      
##  [4,] "大学"  "資金"   "避難"   "経済"   "政府"   "控除"     "天皇陛下"  
##  [5,] "学生"  "甘利"   "対象"   "慰安"   "稼働"   "配偶"     "天皇"      
##  [6,] "社会"  "容疑"   "子ども" "消費"   "原子力" "政権"     "訪問"      
##  [7,] "自分"  "知事"   "以上"   "年度"   "号機"   "所得"     "戦没"      
##  [8,] "万人"  "問題"   "政府"   "予算"   "高速"   "女性"     "気持ち"    
##  [9,] "大阪"  "都議会" "支援"   "延期"   "福島"   "世帯"     "戦争"      
## [10,] "若者"  "調査"   "復興"   "増税"   "登録"   "年収"     "米国"      
##       Topic 15     Topic 16 Topic 17 Topic 18   Topic 19 Topic 20    
##  [1,] "北朝鮮"     "企業"   "政府"   "広島"     "会社"   "社説"      
##  [2,] "大統領"     "東京"   "ロシア" "オバマ"   "政府"   "政治"      
##  [3,] "トランプ"   "政府"   "市場"   "訪問"     "日本"   "ラジオ"    
##  [4,] "実験"       "労働"   "自衛隊" "シャープ" "法人"   "放送"      
##  [5,] "韓国"       "会社"   "経済"   "核兵器"   "処分"   "経済"      
##  [6,] "選挙"       "会場"   "ドル"   "世界"     "地域"   "東京"      
##  [7,] "ミサイル"   "日本"   "部隊"   "大統領"   "資産"   "情報"      
##  [8,] "クリントン" "五輪"   "日本"   "被爆"     "パナマ" "フォーラム"
##  [9,] "投票"       "調査"   "緩和"   "平和"     "関係"   "国際"      
## [10,] "制裁"       "軍属"   "警護"   "原爆"     "報道"   "デジタル"
```
