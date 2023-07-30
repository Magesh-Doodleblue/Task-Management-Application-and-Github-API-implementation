import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'View/Navigation Bar/bottom_navigation_bar.dart';
import 'View/Projects/projects.dart';

import 'View/Dashboard/dashboard.dart';
import 'View/Dashboard Design/dashboard_design.dart';
import 'View/settings/settings.dart';

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
      home: const BottomNavigation(),

      debugShowCheckedModeBanner: false,
      // You can add additional routes here if needed
      routes: {
        '/dashboard': (_) => const Dashboard(),
        '/project': (_) => const ProjectScreen(),
        '/dashboarddesign': (_) => const DashboardDesignScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}
