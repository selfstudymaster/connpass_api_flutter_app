import 'package:connpass_api_flutter_app/model/event_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";
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
            titleSection(),
            thumbnailSection(),
            detailSection(),
          ],
        ),
      ),
    );
  }

  // TODO サムネイルのスクレイピング？
  Widget thumbnailSection() {
    return Container();
  }

  Widget titleSection() {
    return Container(
      padding: EdgeInsets.all(20.0),
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

  Widget buildDetail() {
    Map<String, String> detailMap = {
      '開催日時': changeTimeFormat(event.startedAt),
      '終了日時': changeTimeFormat(event.endedAt),
      '会場': event.place,
      '会場の所在地': event.address,
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
              padding: EdgeInsets.fromLTRB(
                10.0,
                5.0,
                5.0,
                5.0,
              ),
              child: Text(key == null ? '' : key),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                10.0,
                5.0,
                10.0,
                5.0,
              ),
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

  Widget buildUrlLink() {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 15.0, 0, 0),
      // Infinityは極力使わないほうがいい(壊れる可能性がある)
      // 幅いっぱいにしたいなら MediaQuery.of(context).size.widthで指定する
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
                  // .ひとつと..ふたつと...みっつで挙動が異なる
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

  // ISO-8601形式を「○○年○○月○○日○○時○○分」に変換
  // 以下は使い回す予定なので別クラスを作ってchangeTypeFormatかなにかにするのがいい
  String changeTimeFormat(String before) {
    initializeDateFormatting("ja_JP");

    DateTime datetime = DateTime.parse(before);
    var formatter = new DateFormat('yyyy年MM月dd日HH時mm分', "ja_JP");
    var formatted = formatter.format(datetime);
    return formatted;
  }
}
