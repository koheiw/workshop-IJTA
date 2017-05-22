# Rによる日本語のテキスト分析入門
Rによるテキスト分析へを始める人のための、日本語による[**quanteda**](https://github.com/kbenoit/quanteda)の使用法の説明。メディア分析を事例とし、サンプルデータは朝日新聞の2016年の政治および外交に関する記事。

## quantedaについて
**quanteda**は、London School of Economics and Poltical Science（LSE）の[Kenneth Benoit](https://github.com/kbenoit)が、2012年頃から欧州連合（EU）の支援を受けて開発を始めた社会科学向けの量的テキスト分析のRパッケージ。現在は、日本人やアジア人を含む、国際チームによってオープンソースで開発が進められ、欧米の政治科学者の間で人気を集めている。

なお、**quanteda**はquantitative analysis textual dataを短くしたものであり、カタカナで**クオンティーダ**とも表記できる。

## quantedaの特徴
- Rのパッケージとの互換性を重視し、既存の日本語向けのテキスト分析ツールなどよりも柔軟な統計分析を行うことができる。
- テキストの内部処理はユニコードの準拠するため、あらゆる言語で利用でき、特に、日本語と中国語では形態素解析を用いずに文の分かち書きを行える。
- プログラムの中核がC++で実装されているため、同等の処理を[Pythonで実装されたシステムの半分の実行時間とメモリー使用量](http://koheiw.net/?p=468)で行うことができる。
- 外部のプログラムやライブラリーに依存しないためインストールが容易で、Windows、Mac OSおよびLinux上で動作する。

**quanteda**と他のRパッケージの違いについてはJohns Hopkins Universityの[Len Greskiによる説明](https://github.com/lgreski/datasciencectacontent/blob/master/markdown/capstone-ngramComputerCapacity.md#appendix-choosing-a-text-analysis-package-for-the-capstone)がわかりやすい。


# 目次

1. [インストール](documents/install.md)
2. [基本](documents/introduction.md)
3. [corpusの作成・操作](documents/corpus.md)
4. [tokensの作成・操作・分析](documents/tokens.md)
5. [dfmの作成・操作・分析](documents/dfm.md)
6. [追加資料](documents/links.md)