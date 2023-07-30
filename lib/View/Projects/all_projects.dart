import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../common/dialog_box.dart';

class AllProjects extends StatelessWidget {
  const AllProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("App Animation",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text("Today, Shared by - Unbox Digital",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Colors.black54)),
                  const SizedBox(height: 12),
                  const Text("Team",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _showCustomDialog,
                    child: SizedBox(
                      width: 120,
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/man.jpg"),
                            radius: 16,
                          ),
                          const Positioned(
                            left: 18,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/woman.jpg"),
                              radius: 16,
                            ),
                          ),
                          const Positioned(
                            left: 38,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/man2.jpg"),
                              radius: 16,
                            ),
                          ),
                          const Positioned(
                            left: 58,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/woman2.jpg"),
                              radius: 16,
                            ),
                          ),
                          Positioned(
                            left: 78,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange.withOpacity(0.7),
                              radius: 16,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CircularStepProgressIndicator(
                totalSteps: 100,
                currentStep: 70,
                stepSize: 10,
                selectedColor: const Color.fromARGB(255, 116, 143, 249),
                unselectedColor: Colors.grey[200],
                padding: 0,
                width: 90,
                height: 90,
                selectedStepSize: 10,
                child: const Center(
                    child: Text(
                  "65%",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                roundedCap: (_, __) => true,
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlertDialog(
          title: 'Add Team Member',
          description: 'You can add the team member by typing the name',
        );
      },
    );
  }
}
