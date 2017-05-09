RとR Studioのインストール
=========================

quantedaはRがインストールされていればWindows，Max，Linuxのいずれでも利用できる。R StudioからRを使用することで最も快適に操作が行える。

R
-

[https://www.r-project.org](https://www.r-project.org/)

R Studio
--------

[https://www.rstudio.com](https://www.rstudio.com/)

quantedaのインストール
======================

CRAN版
------

CRAN版は安定しているが、三カ月に一回程度の更新なので、最新の機能は含まれていない。

``` r
install.packages("quanteda")
```

Git Hub版
---------

Git Hub版は毎週のように新しい機能が追加され、また、報告された不具合の多くが修正されている。

``` r
install.packages("devtools")
devtools::install_github("kbenoit/quanteda")
```

WindowsおよびMacでは、C++のコードをコンパイルするため[RtoolやXcodeをインストール](https://github.com/kbenoit/quanteda#how-to-install)する必要がある。
