import 'dart:io';

import 'package:flutter/material.dart';

import '../../Controllers/database_helper.dart';
import '../common/style.dart';
import 'all_projects.dart';
import 'completed_projects.dart';
import 'ongoing_projects.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with SingleTickerProviderStateMixin {
  final List<String> tabs = ['All', 'Ongoing', 'Completed'];

  late TabController tabController;
  String profileName = '';
  String? profilePicture;
  bool isProfilePicture = false;

  Future<void> _loadProfileData() async {
    // Fetch profile data from the database
    Map<String, dynamic> profileData = await DatabaseHelper().getProfile();

    setState(() {
      // Set the text controllers and _selectedImagePath with fetched data
      profileName = profileData['name'] ?? '';
      // phoneController.text = profileData['phone'] ?? '';
      profilePicture = profileData['profileImage'];
      if (profilePicture != null) {
        isProfilePicture = true;
      } else {
        isProfilePicture = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _loadProfileData();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Row customAppbar(String profilePicture, bool isProfilePicture) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: isProfilePicture
              ? FileImage(File(profilePicture))
              : AssetImage('assets/images/avatar.jpg') as ImageProvider,
          radius: 30,
        ),
        Spacer(),
        InkWell(
          child: ImageIcon(
            AssetImage("assets/icons/search.png"),
            size: 24,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customAppbar(profilePicture ?? '', isProfilePicture),
              const SizedBox(
                  height: 20), // Add spacing between the text and tab bar
              Text(
                "Project",
                style: AppStyle.customTextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  // color: Colors.deepPurple,   BACKGROUND COLOR FOR TABBAR
                ),
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: const Color.fromARGB(255, 116, 143, 249)
                      //active color
                      ),
                  tabs: tabs.map((String tab) {
                    return Tab(text: tab);
                  }).toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    AllProjects(),
                    OngoingProjects(),
                    CompletedProjects(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
