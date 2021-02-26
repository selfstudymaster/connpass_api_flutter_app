// EventModelクラスの定義
class EventModel {
  // メンバ変数
  final int eventId;
  final String title;
  final String catchMessage;
  // final String description;
  final String eventUrl;
  // final String hashTag;
  final String startedAt;
  final String endedAt;
  // final int limit;
  // final String eventType;
  // final String address;
  // final String place;

  // コンストラクタ
  EventModel({
    this.eventId,
    this.title,
    this.catchMessage,
    // this.description,
    this.eventUrl,
    // this.hashTag,
    this.startedAt,
    this.endedAt,
    // this.limit,
    // this.eventType,
    // this.address,
    // this.place,
  });

  // fromJson
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['event_id'],
      title: json['title'],
      catchMessage: json['catch'],
      // description: json['description'],
      eventUrl: json['event_url'],
      // hashTag: json['hash_tag'],
      startedAt: json['started_at'],
      endedAt: json['ended_at'],
      // limit: json['limit'],
      // eventType: json['event_type'],
      // address: json['address'],
      // place: json['place'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() => {
        'event_id': eventId,
        'title': title,
        'catch': catchMessage,
        // 'description': description,
        'event_url': eventUrl,
        // 'hash_tag': hashTag,
        'started_at': startedAt,
        'ended_at': endedAt,
        // 'limit': limit,
        // 'event_type': eventType,
        // 'address': address,
        // 'place': place,
      };
}
