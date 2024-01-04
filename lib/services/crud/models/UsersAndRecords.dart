import 'dart:convert';
import 'dart:ffi';

List<DatabaseUser> databaseUsersFromJson(String str) => List<DatabaseUser>.from(
    json.decode(str).map((x) => DatabaseUser.fromJson(x)));

String databaseUsersToJson(List<DatabaseUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatabaseUser {
  UnsignedInt id;
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

List<DatabaseRecord> databaseRecordsFromJson(String str) =>
    List<DatabaseRecord>.from(
        json.decode(str).map((x) => DatabaseRecord.fromJson(x)));

String databaseRecordsToJson(List<DatabaseRecord> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatabaseRecord {
  UnsignedInt recordId;
  UnsignedInt fkUserId;
  UnsignedInt gameId;
  String gameDateTime;
  String gameTime;

  DatabaseRecord({
    required this.recordId,
    required this.fkUserId,
    required this.gameId,
    required this.gameDateTime,
    required this.gameTime,
  });

  factory DatabaseRecord.fromJson(Map<String, dynamic> json) => DatabaseRecord(
        recordId: json["record_id"],
        fkUserId: json["fk_user_id"],
        gameId: json["game_id"],
        gameDateTime: json["game_date_time"],
        gameTime: json["game_time"],
      );

  Map<String, dynamic> toJson() => {
        "record_id": recordId,
        "fk_user_id": fkUserId,
        "game_id": gameId,
        "game_date_time": gameDateTime,
        "game_time": gameTime,
      };
}
