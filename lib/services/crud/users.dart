import 'dart:ffi';

class DatabasaUsers {
  UnsignedInt id;
  String email;
  String name;
  String identity;
  DatabasaUsers({
    required this.id,
    required this.email,
    required this.name,
    required this.identity,
  });

  factory DatabasaUsers.fromJson(Map<String, dynamic> json) {
    return DatabasaUsers(
      id: json['id'] as UnsignedInt,
      email: json['email'] as String,
      name: json['email'] as String,
      identity: json['identity'] as String,
    );
  }
}

class DatabaseRecords {
  UnsignedInt id;
  UnsignedInt userId;
  UnsignedInt gameId;
  String gameDateTime;
  Float gameTime;
  DatabaseRecords({
    required this.id,
    required this.userId,
    required this.gameId,
    required this.gameDateTime,
    required this.gameTime,
  });
}
