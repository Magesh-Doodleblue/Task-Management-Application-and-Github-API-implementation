import 'package:flutter/material.dart';

class DashboardDesignScreen extends StatelessWidget {
  const DashboardDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Dashboard Design",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}
