import 'package:connpass_api_flutter_app/view/event_list_view.dart'; // event_list_view.dartの読み出し
import 'package:flutter/material.dart'; // マテリアルデザイン

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  // StatelessWidgetはbuild()メソッドを実装する必要がある
  Widget build(BuildContext context) {
    // MaterialAppクラスはhomeプロパティにアプリケーションが正常に開始された時に最初に表示されるウィジェットを指定する
    return MaterialApp(
      title: 'Connpass API Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Connpassイベント検索アプリ'), // ヘッダー部分のタイトル
    );
  }
}
// MyHomePage() のStatefulWidgetを別ファイルevent_list_view.dartに切り出す
