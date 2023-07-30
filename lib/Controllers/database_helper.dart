import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path; // Import path from the path package
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path.join(documentsDirectory.path, "profile.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE Profile(id INTEGER PRIMARY KEY, name TEXT, phone TEXT, profileImage TEXT)",
        );
      },
    );
  }

  Future<void> insertProfile(Map<String, dynamic> profile) async {
    final db = await database;
    await db.insert('Profile', profile,
        conflictAlgorithm: ConflictAlgorithm.replace);
    // Show a Toast with the message
    Fluttertoast.showToast(
      msg: "Data Successfully Updated",
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  Future<Map<String, dynamic>> getProfile() async {
    final db = await database;
    List<Map<String, dynamic>> profiles = await db.query('Profile', limit: 1);

    if (profiles.isEmpty) {
      return {};
    } else {
      return profiles.first;
    }
  }

  Future<void> deleteProfile() async {
    final db = await database;
    await db.delete('Profile');
  }
}
