import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
// 事前に出力するデータが揃ってる場合その1
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 出力するデータを記述
    const data = [
      Text("item0"),Text("item1"),Text("item2"),Text("item3"),Text("item4"),
    ];
    // 上記データを出力
    return MaterialApp(
      home: Scaffold(
        body: ListView(
            // dataを呼び出すchildrenは必須
            children: data
        ),
      ),
    );
  }
}
*/

// 事前に出力するデータが揃ってる場合その2
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView'),
        ),
        body: ListView(
            // 事前にWidgetの一覧を作成しておくchildren必須
            children: [
              _menuItem("メニュー1", Icon(Icons.settings)),
              _menuItem("メニュー2", Icon(Icons.map)),
              _menuItem("メニュー3", Icon(Icons.room)),
              _menuItem("メニュー4", Icon(Icons.local_shipping)),
              _menuItem("メニュー5", Icon(Icons.airplanemode_active)),
            ]
        ),
      ),
    );
  }
  Widget _menuItem(String title, Icon icon) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child:ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
              color:Colors.black,
              fontSize: 18.0
          ),
        ),
        onTap: () {
          print("onTap called.");
        }, // タップ
        onLongPress: () {
          print("onLongPress called.");
        }, // 長押し
      ),
    );
  }
}
*/

// 表示する要素が事前にわからない場合 ListView.builder

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = [
      "メッセージ",
      "メッセージ",
      "メッセージ",
      "メッセージ",
      "メッセージ",
    ];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('connpass_api_flutter_app'),
            ),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index >= list.length) {
                  list.addAll([
                    "メッセージ",
                    "メッセージ",
                    "メッセージ",
                    "メッセージ",
                  ]);
                }
                return _messageItem(list[index]);
              },
            )));
  }

  Widget _messageItem(String title) {
    return Container(
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        onTap: () {
          print("onTap called.");
        }, // タップ
        onLongPress: () {
          print("onLongTap called.");
        }, // 長押し
      ),
    );
  }
}

// ListView.separated
// 表示する要素が事前にわかっており、一行ごとに何か要素を差し込みたい場合に利用
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = ["メッセージ", "メッセージ", "メッセージ", "メッセージ", "メッセージ","メッセージ","メッセージ","メッセージ",];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('ListView'),
            ),
            body: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return _messageItem(list[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return separatorItem();
              },
              itemCount: list.length,
            )
        )
    );
  }
  Widget separatorItem() {
    return Container(
      height: 10,
      color: Colors.orange,
    );
  }
  Widget _messageItem(String title) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child:ListTile(
        title: Text(
          title,
          style: TextStyle(
              color:Colors.black,
              fontSize: 18.0
          ),
        ),
        onTap: () {
          print("onTap called.");
        }, // タップ
        onLongPress: () {
          print("onLongTap called.");
        }, // 長押し
      ),
    );
  }
}
*/

/*
// ScrollDirection
// スクロールの方向を変える
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = ["0","1","2","3","4","5","6","7","8","9"];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('ListView'),
            ),
            body: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                if (index >= list.length) {
                  list.addAll(["0","1","2","3","4","5","6","7","8","9",]);
                }
                return _messageItem(list[index]);
              },
            )
        )
    );
  }
  Widget _messageItem(String title) {
    return Container(
        width: 100,
        decoration: new BoxDecoration(
            border: new Border(right: BorderSide(width: 1.0, color: Colors.grey))
        ),
        child:Center(
          child:Text(
            title,
            style: TextStyle(
                color:Colors.black,
                fontSize: 20.0
            ),
          ),
        )
    );
  }
}
*/
