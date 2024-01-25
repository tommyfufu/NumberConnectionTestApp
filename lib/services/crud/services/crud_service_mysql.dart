import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:number_connection_test/extensions/filter.dart';
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
  static const createRecord = "$recordApi/create_record.php";
  static const getAllRecord = "$recordApi/get_all_records.php";

  var httpClient = http.Client();
  DatabaseUser? _user;
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

  Future<void> _cacheRecords() async {
    final allRecords = await getAllRecords();
    _records = allRecords.toList();
    _recordsStreamController.add(_records);
  }

  Future<Iterable<DatabaseRecord>> getAllRecords() async {
    var currentUser = _user;
    if (currentUser == null) {
      throw UserNotLoggedInException(); // Define this exception as per your requirement
    }
    final response =
        await http.get(Uri.parse('$getAllRecord?userId=${currentUser.id}'));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      if (res['success']) {
        return databaseRecordsFromJson(res['records']);
      } else {
        throw Exception('test');
      }
    } else {
      // Handle server errors or bad requests
      throw CouldNotGetAllRecord(); // Define this exception as per your requirement
    }
  }

  Future<DatabaseRecord?> getLatestDatabaseRecord() async {
    if (_records.isNotEmpty) {
      return _records.last;
    } else {
      return null;
    }
  }

  Future<DatabaseRecord> createDatabaseRecord({
    required DatabaseUser owner,
    required int gameId,
    required String gameTime,
    required int score,
  }) async {
    //make sure owner exists in the db with the correct id
    final recordUser = await getDatabaseUser(email: owner.email);
    if (recordUser != owner) {
      throw DBCouldNotFindUser();
    }
    print('${recordUser.id}, $gameId, $gameTime, $score');
    final response = await http.post(
      Uri.parse(createRecord),
      body: jsonEncode(
        <String, dynamic>{
          'userId': recordUser.id,
          'gameId': gameId,
          'gameTime': gameTime,
          'score': score,
        },
      ),
    );
    if (response.statusCode == 200) {
      final record = DatabaseRecord.fromJson(jsonDecode(response.body));
      _records.add(record);
      _recordsStreamController.add(_records);
      return record;
    } else {
      throw Exception('Failed to create Database Record.');
    }
  }

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

  Future<DatabaseUser> getDatabaseUser({required String email}) async {
    if (_user != null) return _user!;
    // print('test');
    final encodedEmail = Uri.encodeComponent(email);
    final response =
        await http.get(Uri.parse('$getUserRoute?email=$encodedEmail'));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      if (res['exist']) {
        var user = DatabaseUser.fromJson(res);
        _user = user;
        await _cacheRecords();
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
