import 'dart:convert';

List<DatabaseUser> databaseUsersFromJson(String str) => List<DatabaseUser>.from(
    json.decode(str).map((x) => DatabaseUser.fromJson(x)));

String databaseUsersToJson(List<DatabaseUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatabaseUser {
  int id;
  String email;
  String name;
  String identity;

  DatabaseUser({
    required this.id,
    required this.email,
    required this.name,
    required this.identity,
  });

  factory DatabaseUser.fromJson(Map<String, dynamic> json) => DatabaseUser(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        identity: json["identity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "identity": identity,
      };
}

List<DatabaseRecord> databaseRecordsFromJson(List<dynamic> recordsJson) {
  return recordsJson.map((x) => DatabaseRecord.fromJson(x)).toList();
}

String databaseRecordsToJson(List<DatabaseRecord> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatabaseRecord {
  int recordId;
  int fkUserId;
  int gameId;
  String gameDateTime;
  String gameTime;
  int score;

  DatabaseRecord({
    required this.recordId,
    required this.fkUserId,
    required this.gameId,
    required this.gameDateTime,
    required this.gameTime,
    required this.score,
  });

  factory DatabaseRecord.fromJson(Map<String, dynamic> json) => DatabaseRecord(
        recordId: json["record_id"],
        fkUserId: json["fk_user_id"],
        gameId: json["game_id"],
        gameDateTime: json["game_date_time"],
        gameTime: json["game_time"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "fk_user_id": fkUserId,
        "game_id": gameId,
        "game_time": gameTime,
        "score": score,
      };
}
