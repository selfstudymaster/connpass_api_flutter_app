import 'package:connpass_api_flutter_app/model/event_model.dart'; // event_model.dartの呼び出し
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'; // マテリアルデザイン
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatelessWidget {
  final EventRepository event;
  Detail({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('イベント詳細'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            titleSection(), // タイトル
            detailSection(), // ディティール
          ],
        ),
      ),
    );
  }

  // サムネイル
  Widget thumbnailSection() {
    return Container();
  }

  // タイトル
  Widget titleSection() {
    return Container(
      padding: EdgeInsets.all(28),
      child: Column(
        children: [
          Text(
            event.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            event.catchMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ディティール
  Widget detailSection() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildDetail(),
          buildUrlLink(),
        ],
      ),
    );
  }

  // ディティールのビルド
  Widget buildDetail() {
    Map<String, String> detailMap = {
      '開催日時': changeTimeFormat(event.startedAt),
      '終了日時': changeTimeFormat(event.endedAt),
      // '会場': event.place,
      // '会場の所在地': event.address,
    };

    return Container(child: buildDetailRow(detailMap));
  }

  Widget buildDetailRow(Map<String, String> detailMap) {
    List<Widget> detailList = [];
    detailMap.forEach((key, value) {
      detailList.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
              child: Text(key == null ? '' : key),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(value == null ? '' : value),
            ),
          ),
        ],
      ));
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: detailList,
    );
  }

  // URLリンクのビルド
  Widget buildUrlLink() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
      width: double.infinity,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          children: [
            TextSpan(
              style: TextStyle(
                color: Colors.black,
              ),
              text: '公式サイトは',
            ),
            TextSpan(
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                text: 'こちらから',
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await launch(
                      event.eventUrl,
                      forceWebView: true,
                      forceSafariVC: true,
                    );
                  })
          ],
        ),
      ),
    );
  }

  String changeTimeFormat(String before) {
    initializeDateFormatting("ja_JP");

    DateTime datetime = DateTime.parse(before);
    var formatter = new DateFormat('yyyy年MM月dd日HH時mm分', "ja_JP");
    var formatted = formatter.format(datetime);
    return formatted;
  }
}
