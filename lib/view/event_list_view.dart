import 'dart:convert'; // JSONのデコードとエンコード

import 'package:connpass_api_flutter_app/model/connpass_model.dart'; // connpass_model.dartの読み出し
import 'package:connpass_api_flutter_app/model/event_model.dart'; // event_model.dartの読み出し
import 'package:connpass_api_flutter_app/view/detail.dart'; // detail.dartの読み出し
import 'package:flutter/material.dart'; // マテリアルデザイン
import 'package:http/http.dart' as http; // http

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  // StatefulWidgetを継承したクラス(MyHomePage)ではcreateState()メソッドを実装する必要がある
  // createState()メソッドでインスタンスして返すのが、状態を保持するStateクラス
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// _MyHomePageStateクラスはStateを継承
class _MyHomePageState extends State<MyHomePage> {
  var _controller = TextEditingController();

  var _repository = new ConnpassModel();

  // ListView
  // Stateを実装したクラスにはStatelessWidgetと同様の役割を持つbuild()メソッドが存在する
  @override
  Widget build(BuildContext context) {
    // Scaffoldウィジェットはマテリアルデザイン用のウィジェットで、子孫には必ずMaterialAppウィジェットがいる
    return Scaffold(
      // appBarはScaffoldウィジェットの定番プロパティ
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // bodyプロパティに画面のボディ部分のウィジェットを記述
      body: Center(
        child: ListView(
          children: <Widget>[
            _searchInput(),
            _searchCount(),
            _searchResult(),
          ],
        ),
      ),
    );
  }

  Widget _searchInput() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(),
              controller: _controller,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
          child: RaisedButton(
            child: const Text('検索'),
            onPressed: _search,
          ),
        ),
      ],
    );
  }

  void _search() {
    _getRepository(_controller.text).then((repository) {
      setState(() {
        _repository = repository;
      });
    });
  }

  // APIを呼び出す
  Future<ConnpassModel> _getRepository(String searchWord) async {
    final http.Response response = await http.get(
        'https://connpass.com/api/v1/event/?count=100&order=1&kewword=${searchWord}');
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      ConnpassModel repository = ConnpassModel.fromJson(parsed);
      return repository;
    } else {
      throw Exception('Fail to search repository');
    }
  }

  Widget _searchCount() {
    if (_repository.resultsReturned == null) {
      return Container();
    } else if (_repository.resultsReturned < 100) {
      return Padding(
        padding: EdgeInsets.all(12),
        child: Text('検索結果は ${_repository.resultsReturned.toString()} 件です'),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(12),
        child: Text('件数が多すぎるため全件を表示できません。\n 上限の100件を表示します。'),
      );
    }
  }

  Widget _searchResult() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (_repository.events != null) {
          final EventModel event = _repository.events[index];
          return _resultCard(event);
        } else {
          return null;
        }
      },
      itemCount: _repository.resultsReturned,
    );
  }

  // タップしたらスタックに詳細をプッシュする
  Widget _resultCard(EventModel eventModel) {
    return Card(
      child: InkWell(
        // タップしたらpushされた次ページに遷移しイベント詳細を表示
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                // Detail()クラスをdetail.dartに切り出す
                builder: (context) => Detail(event: eventModel),
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(eventModel.title),
            )
          ],
        ),
      ),
    );
  }
}
