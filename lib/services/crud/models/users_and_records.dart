import 'dart:convert';

List<User> databaseUsersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String databaseUsersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String id; // type of objectID in mongodb is string
  String name;
  String email;
  String phone;
  String birthday;
  String gender;
  String? asusvivowatchsn;
  String? photosticker;
  List<Message>? messages;
  List<MedicationType>? medications;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.gender,
    this.asusvivowatchsn,
    this.photosticker,
    this.messages,
    this.medications,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["ID"],
        name: json["Name"],
        email: json["Email"],
        phone: json["Phone"],
        birthday: json["Birthday"],
        gender: json["Gender"],
        asusvivowatchsn:
            (json["AsusvivowatchSN"] != null) ? json["AsusvivowatchSN"] : null,
        photosticker:
            (json["PhotoSticker"] != null) ? json["PhotoSticker"] : null,
        messages: json["messages"] != null
            ? List<Message>.from(
                json["messages"].map((x) => Message.fromJson(x)))
            : null,
        medications: json["medications"] != null
            ? List<MedicationType>.from(
                json["medication"].map((x) => MedicationType.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Email": email,
        "Name": name,
        "Phone": phone,
        "Birthday": birthday,
        "Gender": gender,
        "AsusvivowatchSN": asusvivowatchsn,
        "PhotoSticker": photosticker,
        "Messages": messages != null
            ? List<dynamic>.from(messages!.map((x) => x))
            : null,
        "Medication": medications != null
            ? List<dynamic>.from(medications!.map((x) => x))
            : null,
      };
}

List<DatabaseRecord> databaseRecordsFromJson(List<dynamic> recordsJson) {
  return recordsJson.map((x) => DatabaseRecord.fromJson(x)).toList();
}

String databaseRecordsToJson(List<DatabaseRecord> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatabaseRecord {
  String recordId;
  String userId;
  int gameId; // number 0: number connection, number 1: color vs word, ...
  String gameDateTime;
  String gameTime;
  int score;

  DatabaseRecord({
    required this.recordId,
    required this.userId,
    required this.gameId,
    required this.gameDateTime,
    required this.gameTime,
    required this.score,
  });

  factory DatabaseRecord.fromJson(Map<String, dynamic> json) => DatabaseRecord(
        recordId: json["record_id"],
        userId: json["user_id"],
        gameId: json["game_id"],
        gameDateTime: json["game_date_time"],
        gameTime: json["game_time"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "fk_user_id": userId,
        "game_id": gameId,
        "game_time": gameTime,
        "score": score,
      };
}

class Message {
  String message;
  String date;

  Message({required this.message, required this.date});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'date': date,
    };
  }
}

class MedicationType {
  String name;
  int dosage; // Number of pills
  int frequency; // Times per day

  MedicationType(
      {required this.name, required this.dosage, required this.frequency});

  factory MedicationType.fromJson(Map<String, dynamic> json) {
    return MedicationType(
      name: json['name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
    };
  }
}
