RとR Studioのインストール
=========================

**quanteda**はRがインストールされていればWindows、Mac OS、Linuxのいずれでも利用できる。R StudioからRを使用することで最も快適に操作を行える。

R
-

[https://www.r-project.org](https://www.r-project.org/)

R Studio
--------

[https://www.rstudio.com](https://www.rstudio.com/)

quantedaのインストール
======================

**quanteda**はCRAN(Comprehensive R Archive Network)版とGithub版があるが本稿の例は、後者の最新版がインストールされていることを前提としている。

CRAN版
------

CRAN版は安定しているが、三カ月に一回程度の更新なので、最新の機能は含まれていない。

``` r
install.packages("quanteda")
```

Github版
--------

Github版は毎週のように新しい機能が追加され、また、報告された不具合の多くが修正されている。

``` r
install.packages("devtools")
devtools::install_github("kbenoit/quanteda")
```

WindowsおよびMacでは、C++のコードをコンパイルするため[Rtools](https://cran.r-project.org/bin/windows/Rtools/)や[Xcode](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/)をインストールする必要がある。

### Rtoolsのインストール

[Rtools](https://cran.r-project.org/bin/windows/Rtools/)は、Rのバージョンに適合したものをインストールする。RtoolsはRBuldToolsを同梱するが、後者はRそのものをコンパイルするためのものであり、インストールする必要はない。

文字化けを避ける方法
--------------------

### Windows

Windowsで文字化けが発生する場合、無料の仮想化プログラムである[VitualBox](https://www.virtualbox.org/)を用いて、Windows上で[Ubuntu](https://www.ubuntu.com/)や[KDE Neon](https://neon.kde.org/) などのLinuxを実行すると問題を根本から解消できる。近年のLinuxはWindowsよりもデータ分析環境として大幅に優れていながら、同等の操作性を持っている。

### Microsoft Excel

CSVファイルを編集する際に表計算ソフトが使われることが多いが、Microsoft ExcelはUTF-8に対応しないため、使うべきではない。UTF-8のCSVファイルの編集では、[Libre Office](https://www.libreoffice.org/)を使うと良い。
