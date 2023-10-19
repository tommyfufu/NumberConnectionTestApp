import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:number_connection_test/services/crud/crud_exceptions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'
    show MissingPlatformDirectoryException, getApplicationDocumentsDirectory;
import 'package:path/path.dart' show join;

////// class for HEApp database service //////
class HEAppService {
  Database? _db;

  Future<DatabaseRecords> createRecord({required DatabaseUser owner}) async {
    final db = _getDatabaseOrThrow();

    //make sure owner exists in the db with the correct id
    final dbUser = await getUser(email: owner.email);
    if (dbUser != owner) {
      throw CouldNotFindUser();
    }

    const textforTimestamp = '';
    const double gameTime = 0.0;
    //create the record
    final recordId = await db.insert(recordsTable, {
      userIdColumn: owner.id,
      playTimestampColumn: textforTimestamp,
      gameTimeColumn: gameTime,
    });

    final record = DatabaseRecords(
      recordId: recordId,
      userId: owner.id,
      playTimestamp: textforTimestamp,
      gameTime: gameTime,
    );

    return record;
  }

  Future<DatabaseUser> getUser({required String email}) async {
    // await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email=?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isEmpty) {
      throw CouldNotFindUser();
    } else {
      return DatabaseUser.fromRow(results.first); // only one email
    }
  }

  Future<DatabaseUser> createUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isNotEmpty) {
      throw UserAlreadyExists();
    }
    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase(),
    });

    return DatabaseUser(id: userId, email: email);
  }

  Future<void> deleteUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (deletedCount != 1) {
      throw CouldNoteDeleteUser();
    }
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      await db.close();
      _db = null;
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      //create sqlite db
      await db.execute(createUserTable); //create the user table
      await db.execute(createRecordsTable); //create the records table
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}

////// end HEApp database class //////

////// class for user database //////
@immutable
class DatabaseUser {
  final int id;
  final String email;
  const DatabaseUser({
    required this.id,
    required this.email,
  });

  DatabaseUser.fromRow(Map<String, Object?> map) //name constructor
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;

  @override //normally used for debug on debug console
  String toString() {
    return 'Person, ID = $id, email = $email';
  }

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

////// end user database class //////

////// class for records database //////

class DatabaseRecords {
  final int recordId;
  final int userId;
  final String playTimestamp;
  final double gameTime;

  DatabaseRecords({
    required this.recordId,
    required this.userId,
    required this.playTimestamp,
    required this.gameTime,
  });

  DatabaseRecords.fromRow(Map<String, Object?> map) //name constructor
      : recordId = map[recordIdColumn] as int,
        userId = map[userIdColumn] as int,
        playTimestamp = map[playTimestampColumn] as String,
        gameTime = map[gameTimeColumn] as double;
  // in flutter tutorial, there was a data named isSyncedWithCloud, it was bool type as member var.
  // but in sqlite, there is no boolean type instead of int
  // so here comes the correct code
  // isSyncedWithCould = (map[isSyncedWithCloudColumn] as int) == 1 ? true : false;
  @override
  String toString() =>
      'Records, record_id = $recordId, user_id = $userId, play_timestamp = $playTimestamp, game_time = $gameTime';

  @override
  bool operator ==(covariant DatabaseRecords other) =>
      recordId == other.recordId;

  @override
  int get hashCode => recordId.hashCode;
}
//////  end records database class  //////

const idColumn = 'id';
const emailColumn = 'email';
const recordIdColumn = 'record_id';
const userIdColumn = 'user_id';
const playTimestampColumn = 'play_timestamp';
const gameTimeColumn = 'game_time';
const dbName = 'records.db'; // db file name
const userTable = 'user'; // user's table name in sqlite
const recordsTable = 'records'; // records's table name in sqlite
const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
          "id"	INTEGER NOT NULL,
          "email"	TEXT NOT NULL UNIQUE,
          PRIMARY KEY("id" AUTOINCREMENT)
        );''';
const createRecordsTable = '''CREATE TABLE IF NOT EXISTS "records" (
          "record_id"	INTEGER NOT NULL,
          "user_id"	INTEGER NOT NULL,
          "play_timestamp"	TEXT NOT NULL UNIQUE,
          "game_time"	REAL NOT NULL,
          FOREIGN KEY("user_id") REFERENCES "user"("id"),
          PRIMARY KEY("record_id" AUTOINCREMENT)
        );''';
