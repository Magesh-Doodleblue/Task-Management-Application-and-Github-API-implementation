import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'View/Navigation Bar/navigation_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.ubuntuTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // home: const BottomNavigation(),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
