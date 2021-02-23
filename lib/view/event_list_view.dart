import 'dart:convert'; // JSONのデコードとエンコード

import 'package:connpass_api_flutter_app/detail.dart'; // detail.dartの読み出し
import 'package:connpass_api_flutter_app/model/connpass_model.dart'; // connpass_model.dartの読み出し
import 'package:connpass_api_flutter_app/model/event_model.dart'; // event_model.dartの読み出し
import 'package:flutter/material.dart'; // マテリアルデザイン
import 'package:http/http.dart' as http; // http

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // メンバ関数 テキストフィールド
  var _controller = TextEditingController();
  // メンバ関数 event_model.dartで定義したConnpassRepositoryのインスタンス化
  var _repository = new ConnpassRepository();

  // ListView
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          // ListViewのメンバ関数
          children: <Widget>[
            _searchInput(),
            _searchCount(),
            _searchResult(),
          ],
        ),
      ),
    );
  }

  // メンバ関数 _searchInput()
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
            child: const Text('Search'),
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
  Future<ConnpassRepository> _getRepository(String searchWord) async {
    final response = await http.get(
        'https://connpass.com/api/v1/event/?count=100&order=1&kewword=' +
            searchWord);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      ConnpassRepository repository = ConnpassRepository.fromJson(parsed);
      return repository;
    } else {
      throw Exception('Fail to search repository');
    }
  }

  // メンバ関数 _searchCount()
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

  // メンバ関数 _searchResult()
  Widget _searchResult() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (_repository.events != null) {
          final EventRepository event = _repository.events[index];
          return _resultCard(event);
        } else {
          return null;
        }
      },
      itemCount: _repository.resultsReturned,
    );
  }

  // タップしたら詳細をプッシュする
  Widget _resultCard(EventRepository eventRepository) {
    return Card(
      child: InkWell(
        // タップしたらpushされた次ページに遷移しイベント詳細を表示
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                // Detail()クラスをdetail.dartに切り出す
                builder: (context) => Detail(event: eventRepository),
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(eventRepository.title),
            )
          ],
        ),
      ),
    );
  }
}
