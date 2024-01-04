import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';
import 'package:number_connection_test/services/crud/sqlite/crud_exceptions.dart';

class Services {
  static const endpoint = "http://140.113.151.61/api/v1";
  static const crudApi = "$endpoint/crud_operations.php";

  static const _CREATE_USER = 'CREATE_USER';
  static const _DELETE_USER = 'DELETE_USER';
  static const _GET_USER = 'GET_USER';
  static const _GET_ALL_USERS = 'GET_ALL_USERS';
  static const _CREATE_RECORD = 'CREATE_RECORD';
  static const _GET_ALL_RECORD = 'GET_ALL_RECORD';

  var httpClient = http.Client();
  DatabaseUser? _user;

  Future<DatabaseUser> updateDatabaseUser(
    String name,
  ) async {
    final response = await http.put(
      Uri.parse('$endpoint/users'),
      body: jsonEncode(
        <String, String>{
          'name': name,
        },
      ),
    );
    if (response.statusCode == 200) {
      return DatabaseUser.fromJson(jsonDecode(response.body));
    } else {
      throw CouldNotUpdateUser;
    }
  }

  Future<DatabaseUser> deleteDatabaseUser(
      UnsignedInt userId, String userName) async {
    final response = await http.post(
      Uri.parse('$endpoint/users'),
      body: jsonEncode(
        <String, UnsignedInt>{
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
      throw CouldNoteDeleteUser();
    }
  }

  Future<DatabaseUser> createDatabaseUser({
    required String email,
    required String name,
    required String identity,
  }) async {
    final response = await http.post(
      Uri.parse('$endpoint/users'),
      body: jsonEncode(
        <String, String>{
          'email': email,
          'name': name,
          'identity': identity,
        },
      ),
    );
    if (response.statusCode == 200) {
      return DatabaseUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Database user.');
    }
  }

  Future<DatabaseUser?> getDatabaseUser({required String email}) async {
    final response = await http.get(
      Uri.parse(crudApi),
    );
    if (response.statusCode == 200) {
      return DatabaseUser.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<List<DatabaseUser>?> getAllDatabaseUsers() async {
    final response = await http.get(Uri.parse(crudApi));
    if (response.statusCode == 200) {
      var myjson = response.body;
      return databaseUsersFromJson(myjson);
    } else {
      return null;
    }
  }
}
