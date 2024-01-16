import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:number_connection_test/extensions/filter.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';
import 'package:number_connection_test/services/crud/sqlite/crud_exceptions.dart';

class Services {
  static const endpoint = "http://140.113.151.61/api/v1";
  static const testAPi = "$endpoint/db_config.php";
  static const userApi = "$endpoint/user";
  static const recordApi = "$endpoint/record";

  // CRUD user
  static const createUser = "$userApi/create_user.php";
  static const getUserRoute = "$userApi/get_user.php";
  static const getAllUserRoute = "$userApi/get_all_users.php";
  static const updateUserRoute = "$userApi/update_user.php";

  // CRUD record
  // static const createRecordRoute = "$userApi/create_user.php";

  // static const _CREATE_USER = 'CREATE_USER';
  // static const _DELETE_USER = 'DELETE_USER';
  // static const _GET_USER = 'GET_USER';
  // static const _GET_ALL_USERS = 'GET_ALL_USERS';
  // static const _CREATE_RECORD = 'CREATE_RECORD';
  // static const _GET_ALL_RECORD = 'GET_ALL_RECORD';

  var httpClient = http.Client();
  late DatabaseUser? _user;
  List<DatabaseRecord> _records = [];

  late final StreamController<List<DatabaseRecord>> _recordsStreamController;

  static final Services _shared = Services._sharedInstance();
  factory Services() => _shared;

  Stream<List<DatabaseRecord>> get allRecords =>
      _recordsStreamController.stream.filter((record) {
        final currentUser = _user;
        if (currentUser != null) {
          return record.fkUserId == currentUser.id;
        } else {
          throw UserShouldBeSetBeforeReadingAllRecord();
        }
      });

  Services._sharedInstance() {
    _recordsStreamController = StreamController<List<DatabaseRecord>>.broadcast(
      onListen: () {
        _recordsStreamController.sink.add(_records);
      },
    );
  }

  // Future<DatabaseRecord> deleteDatabaseRecord({
  //   required UnsignedInt userId,
  //   required UnsignedInt recordId,
  // }) async {
  //   final response = await http.post(
  //     Uri.parse('$endpoint/record'),
  //     body: jsonEncode(
  //       <String, String>{
  //         'recordId': recordId.toString(),
  //         'userId': userId.toString(),
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     return DatabaseRecord.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to create Database user.');
  //   }
  // }

  // Future<List<DatabaseRecord>?> getAllDatabaseRecord({
  //   required UnsignedInt userId,
  //   required UnsignedInt gameId,
  // }) async {
  //   final response = await http.post(
  //     Uri.parse('$endpoint/record'),
  //     body: jsonEncode(
  //       <String, String>{
  //         'userId': userId.toString(),
  //         'gameId': gameId.toString(),
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     return databaseRecordsFromJson(jsonDecode(response.body));
  //   } else {
  //     throw CouldNotGetAllRecord;
  //   }
  // }

  // Future<DatabaseRecord> createDatabaseRecord({
  //   required UnsignedInt userId,
  //   required UnsignedInt gameId,
  //   required String gameTime,
  // }) async {
  //   final response = await http.post(
  //     Uri.parse('$endpoint/record'),
  //     body: jsonEncode(
  //       <String, String>{
  //         'userId': userId.toString(),
  //         'gameId': gameId.toString(),
  //         'gameTime': gameTime,
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     return DatabaseRecord.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to create Database user.');
  //   }
  // }

  Future<void> updateDatabaseUser(
    String name,
  ) async {
    final response = await http.put(
      Uri.parse(updateUserRoute),
      body: jsonEncode(
        <String, dynamic>{
          'id': _user!.id,
          'name': name,
        },
      ),
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      if (res['success']) {
        _user!.name = name;
      } else {
        throw CouldNotUpdateUser;
      }
    } else {
      throw DatabaseIsNotOpen;
    }
  }

  Future<DatabaseUser> deleteDatabaseUser(int userId, String userName) async {
    final response = await http.post(
      Uri.parse('$endpoint/user'),
      body: jsonEncode(
        <String, int>{
          'id': userId,
        },
      ),
    );
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    if (response.statusCode == 200) {
      return DatabaseUser.fromJson(jsonDecode(response.body));
    } else {
      throw CouldNotDeleteUser();
    }
  }

  Future<void> logOut() async {
    await AuthService.firebase().logOut();
    _user = null;
  }

  DatabaseUser getUser() {
    return _user!;
  }

  Future<DatabaseUser> getDatabaseUser({required String email}) async {
    final encodedEmail = Uri.encodeComponent(email);
    final response =
        await http.get(Uri.parse('$getUserRoute?email=$encodedEmail'));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      if (res['exist']) {
        var user = DatabaseUser.fromJson(res);
        _user = user;
        return user;
      } else {
        throw DBCouldNotFindUser();
      }
    } else {
      throw DatabaseIsNotOpen();
    }
  }

  Future<List<DatabaseUser>?> getAllDatabaseUsers() async {
    final response = await http.get(Uri.parse(getAllUserRoute));
    if (response.statusCode == 200) {
      var myjson = response.body;
      return databaseUsersFromJson(myjson);
    } else {
      return null;
    }
  }

  Future<DatabaseUser> createDatabaseUser({
    required String email,
    required String name,
    required String identity,
  }) async {
    final response = await http.post(
      Uri.parse(createUser),
      body: jsonEncode(
        <String, String>{
          'email': email,
          'name': name,
          'identity': identity,
        },
      ),
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);

      if (res['success']) {
        if (res['exist']) {
          // print(userAreadyExistCheck.toString());
          throw DBUserAlreadyExists();
        } else {
          _user = DatabaseUser.fromJson(res);
          return DatabaseUser.fromJson(res);
        }
      } else {
        throw DatabaseIsNotOpen();
      }
    } else {
      // print(response.body.toString());
      throw DBCouldNotCreateUser();
    }
  }
}
