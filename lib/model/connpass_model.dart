import 'package:connpass_api_flutter_app/model/event_model.dart'; // event_model.dartの呼び出し

// ConnpassModelクラスの定義
class ConnpassModel {
  // 変数
  final int resultsReturned;
  final int resultsAvailable;
  final int resultsStart;
  final List<EventModel> events;

  // コンストラクタ
  ConnpassModel(
      {this.resultsReturned,
      this.resultsAvailable,
      this.resultsStart,
      this.events});

  // fromJson
  factory ConnpassModel.fromJson(Map<String, dynamic> json) {
    return ConnpassModel(
        resultsReturned: json['results_returned'],
        resultsAvailable: json['results_available'],
        resultsStart: json['results_start'],
        events: json['events'] != null
            ? json['events']
                .map<EventModel>((e) => EventModel.fromJson(e))
                .toList()
            : null);
  }
}
