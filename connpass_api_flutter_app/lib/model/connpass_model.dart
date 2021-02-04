import 'package:connpass_api_flutter_app/model/event_model.dart'; // event_model.dartの呼び出し

// ConnpassRepositoryクラスの定義
class ConnpassRepository {
  final int resultsReturned;
  final int resultsAvailable;
  final int resultsStart;
  final List<EventRepository> events;

  // コンストラクタ
  ConnpassRepository(
      {this.resultsReturned,
      this.resultsAvailable,
      this.resultsStart,
      this.events});

  factory ConnpassRepository.fromJson(Map<String, dynamic> json) {
    return ConnpassRepository(
        resultsReturned: json['results_returned'],
        resultsAvailable: json['results_available'],
        resultsStart: json['results_start'],
        events: json['events'] != null
            ? json['events']
                .map<EventRepository>((e) => EventRepository.fromJson(e))
                .toList()
            : null);
  }
}
