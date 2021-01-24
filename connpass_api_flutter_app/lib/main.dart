import 'dart:convert'; // JSONのデコードとエンコード

import 'package:connpass_api_flutter_app/detail.dart'; // detail.dartの読み出し
import 'package:connpass_api_flutter_app/model/connpass_model.dart'; // connpass_model.dartの読み出し
import 'package:connpass_api_flutter_app/model/event_model.dart'; // event_model.dartの読み出し
import 'package:flutter/material.dart'; // マテリアルデザイン
import 'package:http/http.dart' as http; // http

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connpass API FLutter APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Connpassイベント検索アプリ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _controller = TextEditingController(); // メンバ関数
  var _repository = new ConnpassRepository(); // メンバ関数

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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

  Widget _searchCount() {
    if (_repository.resultsReturned == null) {
      return Container();
    } else if (_repository.resultsReturned < 100) {
      return Padding(
        padding: EdgeInsets.all(12),
        child: Text('検索結果は' + _repository.resultsReturned.toString() + '件です'),
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
          final EventRepository event = _repository.events[index];
          return _resultCard(event);
        } else {
          return null;
        }
      },
      itemCount: _repository.resultsReturned,
    );
  }

  Widget _resultCard(EventRepository eventRepository) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
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

/*

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connpass API Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Connpassイベント検索アプリ'),
    );
  }
}

// ここから先はもう別ファイルにして、main.dartを極力小さくする。
// main.dartは基本的には初期化のことだけ記述する。
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _controller = TextEditingController();
  var _repository = new ConnpassRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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

  // ListViewで返すよりも、明示的に書いたほうがいい
  Widget _searchInput() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          // ふたつくらいならContainerよりColumnくらいでいい
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(),
              controller: _controller,
            ),
          ),
        ),
        Container(
          // Dart公式的には .0が0だったら書かない
          padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
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

  // Future{}は検索結果を取得するコード
  // MVCのCに当たるでの, このファイル自体はVに当たるため別ファイルに分けてReposityディレクトリに入れる
  // ConnpassRepositoryをModelにかえる
  Future<ConnpassRepository> _getRepository(String searchWord) async {
    final response = await http.get(
        'https://connpass.com/api/v1/event/?count=100&order=1&keyword=' +
            searchWord);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      ConnpassRepository repository = ConnpassRepository.fromJson(parsed);
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
          padding: EdgeInsets.all(12.0),
          child:
              // + で連結するよりも、
              // `検索結果は${_repository.resultsReturned.toString()}件です。`
              Text('検索結果は' + _repository.resultsReturned.toString() + '件です。'));
    } else {
      return Padding(
        padding: EdgeInsets.all(12.0),
        // 2行にわけた理由は「見た目に合わせる意図」だが1行にしていい。
        child: Text('件数が多すぎるため全件を表示できません。\n'
            '上限である100件を表示しています。'),
      );
    }
  }

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

  Widget _resultCard(EventRepository eventRepository) {
    return Card(
      // CardでInkwell使うとタップしたときに波紋が出てユーザーがわかりやすい
      child: InkWell(
        onTap: () {
          // pushNameでスラッシュフォームド等の名前にしてすぐHomeに戻せるようにする
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detail(event: eventRepository),
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(eventRepository.title),
            )
          ],
        ),
      ),
    );
  }
}
*/
