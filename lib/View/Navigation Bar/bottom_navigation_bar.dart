// ignore_for_file: library_private_types_in_public_api

import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:thiran_task/View/Dashboard/dashboard.dart';
import 'package:thiran_task/View/Projects/projects.dart';
import 'package:thiran_task/View/settings/settings.dart';

import '../Dashboard Design/dashboard_design.dart';
import '../Github Home/github_home.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Dashboard(),
    const ProjectsScreen(),
    const DashboardDesignScreen(),
    const SettingsScreen(),
    const GitHubRepositoryListScreen(), // Add GitHub screen as the last item
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.home_filled, size: 30, color: Colors.white),
          Icon(Icons.video_file_rounded, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.mail, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        inactiveIcons: const [
          Icon(Icons.home_filled, size: 25, color: Colors.grey),
          Icon(Icons.video_file_rounded, size: 25, color: Colors.grey),
          Icon(Icons.add, size: 25, color: Colors.grey),
          Icon(Icons.mail, size: 25, color: Colors.grey),
          Icon(Icons.settings, size: 25, color: Colors.grey),
        ],
        color: const Color.fromARGB(255, 240, 240, 240),
        height: 60,
        circleWidth: 60,
        // Adjust this value to be less than or equal to the height
        activeIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        circleColor: const Color.fromARGB(255, 116, 143, 249),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 3,
      ),
    );
  }
}
