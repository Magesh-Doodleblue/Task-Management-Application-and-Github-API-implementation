// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:thiran_task/View/Dashboard%20Design/dashboard_design.dart';
import 'package:thiran_task/View/Projects/projects.dart';
import 'package:thiran_task/View/Profile/profile.dart';

import 'View/Dashboard/dashboard.dart';
import 'View/Github Home/github_home.dart';
import 'View/Github Home/github_notifier.dart';
import 'View/Navigation Bar/bottom_navigation_bar.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
      //creating a new database when app opening
      path.join(
          await getDatabasesPath(), 'github_repositories.db'), //argument 1
      version: 1, onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE repositories(id INTEGER PRIMARY KEY, name TEXT, description TEXT, stars INTEGER, ownerUsername TEXT, ownerAvatarUrl TEXT)',
    ); //return ending
  } // onCreate ending...
      ); // database variable ending
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GitHubRepositoryList(database))
        //we can create multiple change notifiers for overall application
      ],
      child: const MyApp(), //calling MyApp
    ),
  );
}
