// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:number_connection_test/extensions/filter.dart';
// import 'package:number_connection_test/services/crud/crud_exceptions.dart';
// import 'package:mysql1/mysql1.dart';
// import 'package:path_provider/path_provider.dart'
//     show MissingPlatformDirectoryException, getApplicationDocumentsDirectory;
// import 'package:path/path.dart' show join;

// class Mysql {
//   static String host = '140.113.151.61',
//       user = 'rtes913',
//       password = '',
//       db = 'myDB';
//   static int port = 3306;
//   Mysql();

//   Future<MySqlConnection> getConnection() async {
//     var settings = ConnectionSettings(
//         host: host, port: port, user: user, password: password, db: db);

//     return await MySqlConnection.connect(settings);
//   }
// }

// ////// class for HEApp database service //////
// class RecordsService {
//   Database? _db;
//   List<DatabaseRecords> _records = [];

//   DatabaseUser? _user;

//   //Recourds should be singleton
//   static final RecordsService _shared = RecordsService._sharedInstance();
//   RecordsService._sharedInstance() {
//     _recordsStreamController =
//         StreamController<List<DatabaseRecords>>.broadcast(
//       onListen: () {
//         _recordsStreamController.sink.add(_records);
//       },
//     );
//   }
//   factory RecordsService() => _shared;

//   late final StreamController<List<DatabaseRecords>> _recordsStreamController;

//   Stream<List<DatabaseRecords>> get allRecords =>
//       _recordsStreamController.stream.filter((record) {
//         final currentUser = _user;
//         if (currentUser != null) {
//           return record.userId == currentUser.id;
//         } else {
//           throw UserShouldBeSetBeforeReadingAllRecord();
//         }
//       });

//   Future<DatabaseUser> getOrCreateUser({
//     required String email,
//     bool setAsCurrentUser = true,
//   }) async {
//     try {
//       final user = await getUser(email: email);
//       if (setAsCurrentUser) {
//         _user = user;
//       }
//       return user;
//     } on CouldNotFindUser {
//       final createNewUser = await createUser(email: email);
//       if (setAsCurrentUser) {
//         _user = createNewUser;
//       }
//       return createNewUser;
//     } catch (e) {
//       rethrow; //used for debug
//     }
//   }

//   Future<void> _cacheRecords() async {
//     final allRecords = await getAllRecords();
//     _records = allRecords.toList();
//     _recordsStreamController.add(_records);
//   }

//   // Future<DatabaseRecords> updateRecord({
//   //   required DatabaseRecords record,
//   //   required String timestamp,
//   //   required String gametime,
//   // }) async {
//   //   await _ensureDbIsOpen();
//   //   final db = _getDatabaseOrThrow();
//   //   // make sure record exists
//   //   await getRecord(recordid: record.recordId);
//   //   // update DB
//   //   final updatesCount = await db.update(
//   //     recordsTable,
//   //     {
//   //       playTimestampColumn: timestamp,
//   //       gameTimeColumn: gametime,
//   //     },
//   //     //[where] is the optional WHERE clause to apply when updating.
//   //     /// Passing null will update all rows.
//   //     where: 'recordId = ?',
//   //     whereArgs: [record.recordId],
//   //   );

//   //   if (updatesCount == 0) {
//   //     throw CouldNotUpdateRecord();
//   //   } else {
//   //     final updateRecord = await getRecord(recordid: record.recordId);
//   //     _records
//   //         .removeWhere((record) => record.recordId == updateRecord.recordId);
//   //     _records.add(updateRecord);
//   //     _recordsStreamController.add(_records);
//   //     return updateRecord;
//   //   }
//   // }

//   Future<Iterable<DatabaseRecords>> getAllRecords() async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final allRecords = await db.query(recordsTable);

//     return allRecords.map((recordRow) => DatabaseRecords.fromRow(recordRow));
//   }

//   Future<DatabaseRecords> getRecord({required int recordid}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final records = await db.query(
//       recordsTable,
//       limit: 1,
//       where:
//           'recordId = ?', // Tommy's typing habits, 'I' for db (I think this is column in DB,
//       //so it need to use same word with DB), 'i' for arg in func
//       whereArgs: [recordid],
//     );
//     if (records.isEmpty) {
//       throw CouldNotFindRecord();
//     } else {
//       final record = DatabaseRecords.fromRow(records.first);
//       _records.removeWhere((record) => record.recordId == recordid);
//       _records.add(record); //for outside world
//       _recordsStreamController.add(_records); //for outside world
//       return record;
//     }
//   }

//   Future<int> deleteAllRecords() async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final numberOfDeletions = await db.delete(recordsTable);
//     _records = []; //reset _records and streamcontroller
//     _recordsStreamController.add(_records);
//     return numberOfDeletions;
//   }

//   Future<void> deleteRecord({required int recordid}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final deletedCount = await db.delete(
//       recordsTable,
//       where: 'recordId = ?',
//       whereArgs: [recordid],
//     );

//     if (deletedCount == 0) {
//       throw CouldNotDeleteRecord();
//     } else {
//       final countBefore = _records.length;
//       _records.removeWhere((record) => record.recordId == recordid);
//       if (_records.length != countBefore) {
//         _recordsStreamController.add(_records);
//       } else {
//         throw CouldNotDeleteRecord(); //safety guard to check remove the record from _records success
//       }
//     }
//   }

//   Future<DatabaseRecords> createRecord({
//     required DatabaseUser owner,
//     required String timestamp,
//     required String gametime,
//   }) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();

//     //make sure owner exists in the db with the correct id
//     final dbUser = await getUser(email: owner.email);
//     if (dbUser != owner) {
//       throw CouldNotFindUser();
//     }

//     final textforTimestamp = timestamp;
//     final String gameTime = gametime;
//     //create the record
//     final recordId = await db.insert(recordsTable, {
//       userIdColumn: owner.id,
//       playTimestampColumn: textforTimestamp,
//       gameTimeColumn: gameTime,
//     });

//     final record = DatabaseRecords(
//       recordId: recordId,
//       userId: owner.id,
//       playTimestamp: textforTimestamp,
//       gameTime: gameTime,
//     );

//     // add record to _records and _recordsStreamController
//     _records.add(record);
//     _recordsStreamController.add(_records);

//     return record;
//   }

//   Future<DatabaseUser> getUser({required String email}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final results = await db.query(
//       userTable,
//       limit: 1,
//       where: 'email=?',
//       whereArgs: [email.toLowerCase()],
//     );
//     if (results.isEmpty) {
//       throw CouldNotFindUser();
//     } else {
//       return DatabaseUser.fromRow(results.first); // only one email
//     }
//   }

//   Future<DatabaseUser> createUser({required String email}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final results = await db.query(
//       userTable,
//       limit: 1,
//       where: 'email = ?',
//       whereArgs: [email.toLowerCase()],
//     );
//     if (results.isNotEmpty) {
//       throw UserAlreadyExists();
//     }
//     final userId = await db.insert(userTable, {
//       emailColumn: email.toLowerCase(),
//     });

//     return DatabaseUser(id: userId, email: email);
//   }

//   Future<void> deleteUser({required String email}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final deletedCount = await db.delete(
//       userTable,
//       where: 'email = ?',
//       whereArgs: [email.toLowerCase()],
//     );
//     if (deletedCount != 1) {
//       throw CouldNoteDeleteUser();
//     }
//   }

//   Database _getDatabaseOrThrow() {
//     final db = _db;
//     if (db == null) {
//       throw DatabaseIsNotOpen();
//     } else {
//       return db;
//     }
//   }

//   Future<void> close() async {
//     final db = _db;
//     if (db == null) {
//       throw DatabaseIsNotOpen();
//     } else {
//       await db.close();
//       _db = null;
//     }
//   }

//   Future<void> _ensureDbIsOpen() async {
//     try {
//       await open();
//     } on DatabaseAlreadyOpenException {}
//   }

//   Future<void> open() async {
//     if (_db != null) {
//       throw DatabaseAlreadyOpenException();
//     }
//     try {
//       final docsPath = await getApplicationDocumentsDirectory();
//       final dbPath = join(docsPath.path, dbName);
//       final db = await openDatabase(dbPath);
//       _db = db;
//       //create sqlite db
//       await db.execute(createUserTable); //create the user table
//       await db.execute(createRecordsTable); //create the records table
//       await _cacheRecords(); //when we call open, we will cache all records in _records
//     } on MissingPlatformDirectoryException {
//       throw UnableToGetDocumentsDirectory();
//     }
//   }
// }

// ////// end HEApp database class //////

// ////// class for user database //////
// @immutable
// class DatabaseUser {
//   final int id;
//   final String email;
//   final String name;
//   const DatabaseUser({
//     required this.id,
//     required this.email,
//     required this.name,
//   });

//   DatabaseUser.fromRow(Map<String, Object?> map) //name constructor
//       : id = map[idColumn] as int,
//         email = map[emailColumn] as String,
//         name = map[nameColumn] as String;

//   @override //normally used for debug on debug console
//   String toString() {
//     return 'Person, ID = $id, email = $email, name = $name';
//   }

//   @override
//   bool operator ==(covariant DatabaseUser other) => id == other.id;

//   @override
//   int get hashCode => id.hashCode;
// }

// ////// end user database class //////

// ////// class for records database //////

// class DatabaseRecords {
//   final int recordId;

//   final int userId;
//   final String playTimestamp;
//   final String gameTime;

//   DatabaseRecords({
//     required this.recordId,
//     required this.userId,
//     required this.playTimestamp,
//     required this.gameTime,
//   });

//   DatabaseRecords.fromRow(Map<String, Object?> map) //name constructor
//       : recordId = map[recordIdColumn] as int,
//         userId = map[userIdColumn] as int,
//         playTimestamp = map[playTimestampColumn] as String,
//         gameTime = map[gameTimeColumn] as String;
//   // in flutter tutorial, there was a data named isSyncedWithCloud, it was bool type as member var.
//   // but in sqlite, there is no boolean type instead of int
//   // so here comes the correct code
//   // isSyncedWithCould = (map[isSyncedWithCloudColumn] as int) == 1 ? true : false;
//   @override
//   String toString() =>
//       'Records, record_id = $recordId, user_id = $userId, play_timestamp = $playTimestamp, game_time = $gameTime';

//   @override
//   bool operator ==(covariant DatabaseRecords other) =>
//       recordId == other.recordId;

//   @override
//   int get hashCode => recordId.hashCode;
// }
// //////  end records database class  //////

// const idColumn = 'id';
// const emailColumn = 'email';
// const nameColumn = 'name';
// const recordIdColumn = 'record_id';
// const fkUserIdColumn = 'fk_user_id';
// const gameIdColumn = 'game_id';
// const gameDateTimeColumn = 'game_date_time'; //when play the game, unique
// const gameTimeColumn = 'game_time'; //play game total time
// const dbName = 'HEdb.db'; // db file name
// const userTable = 'user'; // user's table name in sqlite
// const recordsTable = 'records'; // records's table name in sqlite
// const createUserTable = '''CREATE TABLE `user` (
//   `id` int unsigned NOT NULL AUTO_INCREMENT,
//   `email` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
//   `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
//   PRIMARY KEY (`id`),
//   UNIQUE KEY `email_UNIQUE` (`email`),
//   UNIQUE KEY `id_UNIQUE` (`id`)
// ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin''';
// const createRecordsTable = '''CREATE TABLE `records` (
//   `record_id` int unsigned NOT NULL AUTO_INCREMENT,
//   `fk_user_id` int unsigned NOT NULL,
//   `game_id` int unsigned NOT NULL,
//   `game_date_time` datetime(5) NOT NULL DEFAULT CURRENT_TIMESTAMP(5),
//   `game_time` float unsigned NOT NULL,
//   PRIMARY KEY (`record_id`),
//   UNIQUE KEY `record_id_UNIQUE` (`record_id`),
//   KEY `fk_user_id_idx` (`fk_user_id`),
//   CONSTRAINT `fk_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `user` (`id`)
// ) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin''';
