import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'View/Navigation Bar/navigation_bar.dart';

class MyApp extends StatelessWidget {
  // APPLICATION
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //root of the app
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.ubuntuTextTheme(
          //textstyle for overall app
          Theme.of(context).textTheme,
        ),
      ),
      // home: const BottomNavigation(),    //used by custom navigation bar package
      home: MyHomePage(), //own implementation for navigation without package
      debugShowCheckedModeBanner: false,
    );
  }
}




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
    path.join(await getDatabasesPath(), 'profile.db'),
    version: 1,
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE repositories(id INTEGER PRIMARY KEY, name TEXT, description TEXT, stars INTEGER, ownerUsername TEXT, ownerAvatarUrl TEXT)',
      );
    },
  );

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
      ],
      child: const MyApp(),
    ),
  );
}

final databaseProvider = Provider<Database>((ref) {
  throw UnimplementedError('Not implemented yet');
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GitHubRepositoryListScreen(),
    );
  }
}

class GitHubRepositoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = context.read(databaseProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repositories'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: db.query('repositories'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final repositories = snapshot.data;
            return ListView.builder(
              itemCount: repositories!.length,
              itemBuilder: (context, index) {
                final repository = repositories[index];
                return ListTile(
                  title: Text(repository['name']),
                  subtitle: Text(repository['description']),
                  // ... Other fields
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data from database'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
