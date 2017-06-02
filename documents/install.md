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

### RStudio

本稿のファイルの日本語がRStudioで正しく表示されない場合は、"File"メニューの"Reope with Encoding"で、UTF-8を選ぶ必要がある。その際は、"Set as default encoding for source files"にチェックを入れることが望ましい。

### Windows

Windowsは、標準の文字コードがUTF-8ではないため、テキスト分析において、頻繁に文字コードの問題が発生する。Windowsの英語版で、日本語の文字が正しく表示されない場合は、[Windowsの言語設定をコントロールパネルで変更する](http://koheiw.net/?p=490)必要がある。 Windowsがインストールされたパソコンの利用者は、無料の仮想化プログラムである[VitualBox](https://www.virtualbox.org/)を用いて、[Ubuntu](https://www.ubuntu.com/)や[KDE Neon](https://neon.kde.org/) などのLinuxを実行し、その中で、テキスト分析を行うと、多くの文字コードに起因する問題を回避できる。

### Microsoft Excel

CSVファイルを編集する際に表計算ソフトが使われることが多いが、Microsoft ExcelはUTF-8に対応しないため、使うべきではない。UTF-8のCSVファイルの編集では、[Libre Office](https://www.libreoffice.org/)を使うと良い。
