import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Row customAppbar() {
    return const Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/avatar.jpg"),
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
              customAppbar(),
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
                  children: const [
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
