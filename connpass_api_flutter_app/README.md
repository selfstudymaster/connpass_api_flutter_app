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

====================================================================================
課題5_API関連

ゴール: connpassのAPIを受けとって画面に表示する

以下も調査してね〜
1.サーバー、クライアントとはなにか？
2.http、httpsとは？
3.リクエストメゾットに関して
4.paramとbodyの違い、使い所
5.header、body、footerについて
6.text、json、xmlの違いと扱いどころ
7.Restful APIとは？
8.パースとは何か？

【1.サーバー、クライアントとはなにか？】
サーバー : ネットワーク上の他のシステムにサービスを提供するシステム
クライアント : サーバから提供されるリモートサービスを利用するシステム

WebにおけるクライアントはWebブラウザを、サーバはWebサーバを指す。
クライアント(Webブラウザ)からサーバへリクエストを送信し、サーバで処理された後にクライアントへ送り返されたレスポンスを
クライアントが受け取った後に処理をして表示する。
リクエストとレスポンスのやりとりにはHTTPを利用する。

参考資料
・『Webを支える技術 HTTP、URI、HTML、そしてREST』山本陽平 WEB+DB PRESS plus

【2. HTTP、HTTPSとは?】
HTTPは Hypertext Transfer Protocol の略で、TCP/IP(Transmission Control Protocol/Internet Protocol)をベースとしたプロトコル(規約)。
RFC2616で規程されたバージョン1.1が長らく標準的に利用されているが、バージョン2.0、3.0も存在する。
HTTPはステートレス＝「サーバがクライアントのアプリケーション状態を保存しない制約」のプロトコルとして設計されており、
クライアントが自らのアプリケーション状態を覚え、リクエストの処理に必要な情報がすべて含まれる「自己記述的メッセージ」でリクエストを送信する。

参考資料
・『Webを支える技術 HTTP、URI、HTML、そしてREST』山本陽平 WEB+DB PRESS plus
・HTTP の進化
https://developer.mozilla.org/ja/docs/Web/HTTP/Basics_of_HTTP/Evolution_of_HTTP


【3.リクエストメソッドに関して】
HTTPリクエストは「クライアントが行いたい処理をサーバに伝える」ためにリクエストメソッドを定義している。
HTTP 1.1 におけるリクエストメソッドの定義は以下の8つである。
GET/POST/PUT/DELETE/HEAD/OPTIONS/TRACE/CONNECTの8つのメソッドのうち、CRUD処理に当たるのは以下の4つである。
Create:POST/PUT
Read:GET
Update:PUT
Delete:DELETE

参考資料
・『Webを支える技術 HTTP、URI、HTML、そしてREST』山本陽平 WEB+DB PRESS plus

【4.paramとbodyの違い、使い所】
・PARAMとは、オブジェクトの実行に必要な設定値であるパラメータを指定するタグ。
<param>タグは、<object>タグ、または<applet>タグ内で使用する。
パラメータの名前は<name>属性で指定し、<value>属性でその値を指定する。
例
<object data="sample.gif" type="image/gif" width=120 height=240>
  <param name="パラメータ名" value="パラメータの値">
  <param name="bgcolor" value="FFF0E0">
  <param name="bgimage" value="sample.gif">
</object>

・BODYとは、文章や画像など、実際にブラウザの画面上に表示される内容を指定するタグ。
<body>タグの中に書かれたテキストや画像などがブラウザの画面上に表示される。
例
<body>
    <section>
        <h2>このsectionの見出し</h2>
        <ul>
            <li><a><img src="画像のURL">paramとは</a><li>
            <li><a><img src="画像のURL">bodyとは</a><li>
        <ul>
    </section>
</body>

参考資料
・<param>
https://html-coding.co.jp/annex/dictionary/html/param/#:~:text=%E3%81%A8%E3%81%AF,%E5%80%A4%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%97%E3%81%BE%E3%81%99%E3%80%82

・<body>
https://html-coding.co.jp/annex/dictionary/html/body/


【5.header、body、footerについて】
HTMLの要素。
HTMLによるWebページ制作において、headerはページ最上部固定の箇所(ヘッダー)、bodyは本文(コンテンツ)を表示する箇所、footerはページ最下部固定の箇所(フッター)を指す。
構成としては以下のようになる。
<html>
    <head>
        <!-- ここの記述内容はWebブラウザには表示されない。主に読み込むCSSの指定等を行う。-->
        <link rel="stylesheet" href="style.css">
    </head>
    <header>
        <!-- ヘッダー部分をHTMLで記述-->
    </header>
    <body>
        <!--本文(コンテンツ)をHTMLで記述-->
    </body>
    <footer>
        <!--フッター部分をHTMLで記述-->
    </footer>
</html>


【6.text、json、xmlの違いと扱いどころ】
・text
文字(テキスト)と区切り文字(,)だけで記述されるCSV(Comma-Separated Values)などがある。
使い所:Excelなど。

記述例
りんご, Apple
バナナ, Banana
いちご, Strawberry


・JSON
データをJavaScriptのオブジェクトの形式で記述したもの。
使い所:データを登録し変数として引っ張ってくる場面。プルタブから住所の都道府県を選択する等。

記述例
{
    "fruits":[
        "fruit":{"name":"すいか", "price":3000},
        "fruit":{"name":"いちご", "price":700}
    ]
}


・XML
Extensible Markup Languageの略。
汎用マークアップ言語SGMLの流れを受け継いで、W3Cのワーキンググループで仕様が策定された文書の構造化フォーマット。
タグ(要素)でデータ(コンテント)を囲み、さらにデータを入れ子構造にできる。
使い所:Ajax(Asynchronous JavaScript, XML)による非同期(ページ遷移を必要としない)通信を行う際にJavaScriptと一緒に利用する際に用いられる。

記述例
<?xml version="1.0" encoding="utf-8"?>
<fruits>
    <fruit>
        <name>すいか</name>
        <price>3000</price>
    </fruit>
    <fruit>
        <name>いちご</name>
        <price>700</price>
    </fruit>
</fruits>


【7.Restful APIとは？】
RESTはWebのアーキテクチャスタイル。アーキテクチャスタイルには他にも"MVC(Model-View-Controller)"や"Pipe & Filter"などがある。
アーキテクチャスタイルは「複数のアーキテクチャに共通する性質・様式・作法あるいは流儀」を指す言葉。
RESTは、Web="クライアント／サーバ"のアーキテクチャスタイルから派生したネットワークのアーキテクチャスタイルで、
Web全体のアーキテクチャスタイルでもあり、個別のWebサービスやWeb APIのアーキテクチャスタイルでもある。
RESTは"クライアント／サーバ"、"ステートレスサーバ"、"キャッシュ"、"統一▶インターフェース"、"階層化システム"、
"コードオンデマンド"、"ULCODC$SS"といったアーキテクチャスタイルを使って実現される。
RESTは「Web上のリソース(URI)同士が持つリンクを辿る」ハイパーメディアの基本機能でアプリケーションを実現させる分散型ネットワークシステム。
※URIは Uniform Resource Identifier の略で、「リソースを統一的に識別するID」のこと。Web情に存在するすべてのリソースをユニークに(一意に)示せる。
RESTfulとは「RESTの制約に従っていてRESTらしいこと」を指し、RESTfull API とは「RESTの制約に従っていてRESTらしいAPI」を指す。

参考資料
・『Webを支える技術 HTTP、URI、HTML、そしてREST』山本陽平 WEB+DB PRESS plus
・0からREST APIについて調べてみた
https://qiita.com/masato44gm/items/dffb8281536ad321fb08#:~:text=RESTful%20API(REST%20API)%E3%81%A8,%E3%81%AB%E5%BE%93%E3%81%A3%E3%81%A6%E7%AD%96%E5%AE%9A%E3%81%95%E3%82%8C%E3%81%9F%E3%82%82%E3%81%AE%E3%80%82


【8.パースとは何か？】
一定の書式や文法に従って記述されたデータを解析し、プログラムで扱えるようなデータ構造の集合体に変換する機能・処理のこと。

参考資料
・パースとは
http://e-words.jp/w/%E3%83%91%E3%83%BC%E3%82%B9.html
