import 'dart:developer';

import 'package:flutter/material.dart';

import '../Dashboard/dashboard.dart';
import '../Github Home/github_home.dart';
import '../Projects/projects.dart';
import '../Profile/profile.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const Dashboard(),
    const ProjectScreen(),
    const GitHubRepositoryListScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        splashColor: Colors.black12,
        backgroundColor: const Color.fromARGB(255, 116, 143, 249),
        onPressed: () {
          log("message");
          // Show a Snackbar with the message
          showSnackBar(context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), //custom shape
        notchMargin: 8.0, //adding padding from safe area
        child: Row(
          mainAxisSize: MainAxisSize.max, //fill entire space widthd
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //give space around the children widgets
          children: <Widget>[
            buildNavItem(Icons.home_filled, 0),
            buildNavItem(Icons.video_file_rounded, 1),
            SizedBox(width: 48.0), // Empty space for the floating button
            buildNavItem(Icons.mail, 2),
            buildNavItem(Icons.person_outline_rounded, 3),
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("This feature is on Development"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget buildNavItem(IconData iconData, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 55,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //taking only needed space by child widget
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: _currentIndex == index
                    ? const Color.fromARGB(255, 116, 143, 249)
                    : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
