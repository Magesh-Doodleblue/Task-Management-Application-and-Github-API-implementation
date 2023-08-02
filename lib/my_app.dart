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
