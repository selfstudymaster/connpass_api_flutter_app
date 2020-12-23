# connpass_api_flutter_app

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

====================================================================================<br>
# 課題5_API関連<br>
<br>
ゴール: connpassのAPIを受けとって画面に表示する<br>
<br>
以下も調査してね〜<br>
1.サーバー、クライアントとはなにか？<br>
2.http、httpsとは？<br>
3.リクエストメゾットに関して<br>
4.paramとbodyの違い、使い所<br>
5.header、body、footerについて<br>
6.text、json、xmlの違いと扱いどころ<br>
7.Restful APIとは？<br>
8.パースとは何か？<br>
<br>
# 【1.サーバー、クライアントとはなにか？】<br>
サーバー : ネットワーク上の他のシステムにサービスを提供するシステム<br>
クライアント : サーバから提供されるリモートサービスを利用するシステム<br>
<br>
WebにおけるクライアントはWebブラウザを、サーバはWebサーバを指す。<br>
クライアント(Webブラウザ)からサーバへリクエストを送信し、サーバで処理された後にクライアントへ送り返されたレスポンスを
クライアントが受け取った後に処理をして表示する。<br>
リクエストとレスポンスのやりとりにはHTTPを利用する。<br>
<br>
参考資料<br>
・『Webを支える技術 HTTP、URI、HTML、そしてREST』山本陽平 WEB+DB PRESS plus<br>
<br>
# 【2. HTTP、HTTPSとは?】<br>
HTTPは Hypertext Transfer Protocol の略で、TCP/IP(Transmission Control Protocol/Internet Protocol)をベースとしたプロトコル(規約)。<br>
RFC2616で規程されたバージョン1.1が長らく標準的に利用されているが、バージョン2.0、3.0も存在する。<br>
HTTPはステートレス＝「サーバがクライアントのアプリケーション状態を保存しない制約」のプロトコルとして設計されており、
クライアントが自らのアプリケーション状態を覚え、リクエストの処理に必要な情報がすべて含まれる「自己記述的メッセージ」でリクエストを送信する。<br>
<br>
参考資料<br>
・『Webを支える技術 HTTP、URI、HTML、そしてREST』山本陽平 WEB+DB PRESS plus<br>
・HTTP の進化<br>
https://developer.mozilla.org/ja/docs/Web/HTTP/Basics_of_HTTP/Evolution_of_HTTP<br>
<br>
<br>
# 【3.リクエストメソッドに関して】<br>
HTTPリクエストは「クライアントが行いたい処理をサーバに伝える」ためにリクエストメソッドを定義している。<br>
HTTP 1.1 におけるリクエストメソッドの定義は以下の8つである。<br>
GET/POST/PUT/DELETE/HEAD/OPTIONS/TRACE/CONNECTの8つのメソッドのうち、CRUD処理に当たるのは以下の4つである。<br>
Create:POST/PUT<br>
Read:GET<br>
Update:PUT<br>
Delete:DELETE<br>
<br>
参考資料<br>
・『Webを支える技術 HTTP、URI、HTML、そしてREST』山本陽平 WEB+DB PRESS plus<br>
<br>
# 【4.paramとbodyの違い、使い所】<br>
・PARAMとは、オブジェクトの実行に必要な設定値であるパラメータを指定するタグ。<br>
<param>タグは、<object>タグ、または<applet>タグ内で使用する。<br>
パラメータの名前は<name>属性で指定し、<value>属性でその値を指定する。<br>
例<br>
<object data="sample.gif" type="image/gif" width=120 height=240><br>
  <param name="パラメータ名" value="パラメータの値"><br>
  <param name="bgcolor" value="FFF0E0"><br>
  <param name="bgimage" value="sample.gif"><br>
</object><br>
<br>
・BODYとは、文章や画像など、実際にブラウザの画面上に表示される内容を指定するタグ。<br>
<body>タグの中に書かれたテキストや画像などがブラウザの画面上に表示される。<br>
例<br>
<body><br>
    <section><br>
        <h2>このsectionの見出し</h2><br>
        <ul><br>
            <li><a><img src="画像のURL">paramとは</a><li><br>
            <li><a><img src="画像のURL">bodyとは</a><li><br>
        <ul><br>
    </section><br>
</body><br>
<br>
参考資料<br>
・param<br>
https://html-coding.co.jp/annex/dictionary/html/param/#:~:text=%E3%81%A8%E3%81%AF,%E5%80%A4%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%97%E3%81%BE%E3%81%99%E3%80%82 <br>
<br>
・body<br>
https://html-coding.co.jp/annex/dictionary/html/body/<br>
<br>
<br>
# 【5.header、body、footerについて】<br>
HTMLの要素。<br>
HTMLによるWebページ制作において、headerはページ最上部固定の箇所(ヘッダー)、bodyは本文(コンテンツ)を表示する箇所、footerはページ最下部固定の箇所(フッター)を指す。<br>
構成としては以下のようになる。<br>
<html><br>
    <head><br>
        <!-- ここの記述内容はWebブラウザには表示されない。主に読み込むCSSの指定等を行う。--><br>
        <link rel="stylesheet" href="style.css"><br>
    </head><br>
    <header><br>
        <!-- ヘッダー部分をHTMLで記述--><br>
    </header><br>
    <body><br>
        <!--本文(コンテンツ)をHTMLで記述--><br>
    </body><br>
    <footer><br>
        <!--フッター部分をHTMLで記述--><br>
    </footer><br>
</html><br>
<br>
<br>
# 【6.text、json、xmlの違いと扱いどころ】<br>
・text<br>
文字(テキスト)と区切り文字(,)だけで記述されるCSV(Comma-Separated Values)などがある。<br>
使い所:Excelなど。<br>
<br>
記述例<br>
りんご, Apple<br>
バナナ, Banana<br>
いちご, Strawberry<br>
<br>
<br>
・JSON<br>
データをJavaScriptのオブジェクトの形式で記述したもの。<br>
使い所:データを登録し変数として引っ張ってくる場面。プルタブから住所の都道府県を選択する等。<br>
<br>
記述例<br>
{<br>
    "fruits":[<br>
        "fruit":{"name":"すいか", "price":3000},<br>
        "fruit":{"name":"いちご", "price":700}<br>
    ]<br>
}<br>
<br>
<br>
・XML<br>
Extensible Markup Languageの略。<br>
汎用マークアップ言語SGMLの流れを受け継いで、W3Cのワーキンググループで仕様が策定された文書の構造化フォーマット。<br>
タグ(要素)でデータ(コンテント)を囲み、さらにデータを入れ子構造にできる。<br>
使い所:Ajax(Asynchronous JavaScript, XML)による非同期(ページ遷移を必要としない)通信を行う際にJavaScriptと一緒に利用する際に用いられる。<br>
<br>
記述例<br>
<?xml version="1.0" encoding="utf-8"?><br>
<fruits><br>
    <fruit><br>
        <name>すいか</name><br>
        <price>3000</price><br>
    </fruit><br>
    <fruit><br>
        <name>いちご</name><br>
        <price>700</price><br>
    </fruit><br>
</fruits><br>
<br>
<br>
# 【7.Restful APIとは？】<br>
RESTはWebのアーキテクチャスタイル。アーキテクチャスタイルには他にも"MVC(Model-View-Controller)"や"Pipe & Filter"などがある。<br>
アーキテクチャスタイルは「複数のアーキテクチャに共通する性質・様式・作法あるいは流儀」を指す言葉。<br>
RESTは、Web="クライアント／サーバ"のアーキテクチャスタイルから派生したネットワークのアーキテクチャスタイルで、
Web全体のアーキテクチャスタイルでもあり、個別のWebサービスやWeb APIのアーキテクチャスタイルでもある。<br>
RESTは"クライアント／サーバ"、"ステートレスサーバ"、"キャッシュ"、"統一▶インターフェース"、"階層化システム"、
"コードオンデマンド"、"ULCODC$SS"といったアーキテクチャスタイルを使って実現される。<br>
RESTは「Web上のリソース(URI)同士が持つリンクを辿る」ハイパーメディアの基本機能でアプリケーションを実現させる分散型ネットワークシステム。<br>
※URIは Uniform Resource Identifier の略で、「リソースを統一的に識別するID」のこと。Web情に存在するすべてのリソースをユニークに(一意に)示せる。<br>
RESTfulとは「RESTの制約に従っていてRESTらしいこと」を指し、RESTfull API とは「RESTの制約に従っていてRESTらしいAPI」を指す。<br>
<br>
参考資料<br>
・『Webを支える技術 HTTP、URI、HTML、そしてREST』山本陽平 WEB+DB PRESS plus<br>
・0からREST APIについて調べてみた<br>
https://qiita.com/masato44gm/items/dffb8281536ad321fb08#:~:text=RESTful%20API(REST%20API)%E3%81%A8,%E3%81%AB%E5%BE%93%E3%81%A3%E3%81%A6%E7%AD%96%E5%AE%9A%E3%81%95%E3%82%8C%E3%81%9F%E3%82%82%E3%81%AE%E3%80%82 <br>
<br>
<br>
# 【8.パースとは何か？】<br>
一定の書式や文法に従って記述されたデータを解析し、プログラムで扱えるようなデータ構造の集合体に変換する機能・処理のこと。<br>
<br>
参考資料<br>
・パースとは<br>
http://e-words.jp/w/%E3%83%91%E3%83%BC%E3%82%B9.html<br>
<br>