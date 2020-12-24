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
## サーバー、クライアントとはなにか？<br>
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
## HTTP、HTTPSとは?<br>
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
## リクエストメソッドに関して<br>
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
## paramとbodyの違い、使い所<br>

・paramとは
HTTPリクエストのGETメソッドの冒頭、リクエスト行のURIのドメイン名以降(?以降)の部分。
Pathparameter(パスパラメータ)とqueryparameter(クエリパラメータ)がある。

例
https://example.com/pathparameter/{pathparameter}?queryparameter1=hoge&queryparameter2=fuga

Pathparameter(パスパラメータ)は特定のリソースを識別するために必要な情報
queryparameter(クエリパラメータ)は特定のリソースを操作して取得する際に必要な情報

・bodyとは
HTTPリクエストのPOSTメソッドのbody部分。GETメソッドのparam部分を切り出した部分でもある。
Webページでの入力画面の情報が記載されている。

参考資料
・REST APIの始め方 (主要なHTTPメソッド)
https://medium.com/@Akitsuyoshi/rest-api%E3%81%AE%E5%A7%8B%E3%82%81%E6%96%B9-%E4%B8%BB%E8%A6%81%E3%81%AAhttp%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89-a730dcb4a3a8

<br>
<br>
## header、body、footerについて<br>
HTTPリクエストにおけるheader部分
GETメソッドの「リクエスト行以降」がheader
主に下記の構成となっている

```
GET /https://example.com/pathparameter/{pathparameter}?queryparameter1=hoge&queryparameter2=fuga HTTP/1.1 
Host: localhost:8080
Connection: keep-alive
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36
Accept: */*
Referer: http://localhost:8080/
Accept-Encoding: gzip, deflate, sdch, br
Accept-Language: ja,en-US;q=0.8,en;q=0.6
```

POSTメソッドの「リクエスト行以降〜空行以前」がheader、「空行以降」がbody
主に下記の構成になっている

```
POST /hoge/ HTTP/1.1 /* リクエスト行 */
Host: localhost:8080
Connection: keep-alive
Content-Length: 22
Cache-Control: max-age=0
Origin: http://localhost:8080
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36
Content-Type: application/x-www-form-urlencoded
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Referer: http://localhost:8080/hoge/
Accept-Encoding: gzip, deflate, br
Accept-Language: ja,en-US;q=0.8,en;q=0.6
/* 空行 */
name1=hoge&comment2=fuga /* body */
```

<br>
<br>
## text、json、xmlの違いと扱いどころ<br>
・text<br>
文字(テキスト)と区切り文字(,)だけで記述されるCSV(Comma-Separated Values)などがある。<br>
使い所:Excelなど。<br>
<br>
記述例<br>

```
りんご, Apple<br>
バナナ, Banana<br>
いちご, Strawberry<br>
```

<br>
<br>
・JSON<br>
データをJavaScriptのオブジェクトの形式で記述したもの。<br>
使い所:RESTful APIのリクエスト設計のdefaultはJSONにするのが好ましい。<br>
<br>
記述例<br>

```
{<br>
    "fruits":[<br>
        "fruit":{"name":"すいか", "price":3000},<br>
        "fruit":{"name":"いちご", "price":700}<br>
    ]<br>
}<br>
```

<br>
<br>
・XML<br>
Extensible Markup Languageの略。<br>
汎用マークアップ言語SGMLの流れを受け継いで、W3Cのワーキンググループで仕様が策定された文書の構造化フォーマット。<br>
タグ(要素)でデータ(コンテント)を囲み、さらにデータを入れ子構造にできる。<br>
使い所:Ajax(Asynchronous JavaScript, XML)による非同期(ページ遷移を必要としない)通信を行う際にJavaScriptと一緒に利用する際に用いられる。RESTful APIの設計ではdefaultはJSONが好ましいとされるが、コストがかかる場合はXMLと併用する。<br>
<br>
記述例<br>

```
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
```

<br>
<br>
## Restful APIとは？<br>
RESTはWebのアーキテクチャスタイル。アーキテクチャスタイルには他にも"MVC(Model-View-Controller)"や"Pipe & Filter"などがある。<br>
アーキテクチャスタイルは「複数のアーキテクチャに共通する性質・様式・作法あるいは流儀」を指す言葉。<br>
RESTは、Web="クライアント／サーバ"のアーキテクチャスタイルから派生したネットワークのアーキテクチャスタイルで、
Web全体のアーキテクチャスタイルでもあり、個別のWebサービスやWeb APIのアーキテクチャスタイルでもある。<br>
RESTは"クライアント／サーバ"、"ステートレスサーバ"、"キャッシュ"、"統一インターフェース"、"階層化システム"、
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
## パースとは何か？<br>
一定の書式や文法に従って記述されたデータを解析し、プログラムで扱えるようなデータ構造の集合体に変換する機能・処理のこと。<br>
<br>
参考資料<br>
・パースとは<br>
http://e-words.jp/w/%E3%83%91%E3%83%BC%E3%82%B9.html<br>
<br>