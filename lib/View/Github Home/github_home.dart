// // ignore_for_file: library_private_types_in_public_api, avoid_print, unused_import

// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controllers/database_helper.dart';
import 'github_notifier.dart';

class GitHubRepositoryListScreen extends StatefulWidget {
  const GitHubRepositoryListScreen({super.key});

  @override
  _GitHubRepositoryListScreenState createState() =>
      _GitHubRepositoryListScreenState();
}

class _GitHubRepositoryListScreenState
    extends State<GitHubRepositoryListScreen> {
  late GitHubRepositoryList _repositoryList;
  final ScrollController _scrollController = ScrollController();
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
    _repositoryList = Provider.of<GitHubRepositoryList>(context, listen: false);

    // Fetch repositories on initial load
    _repositoryList.fetchGitHubRepositories();
    log("INIT STATE Called....");
    // Add scroll listener to detect when the user reaches the end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _repositoryList.fetchNextPage();
      }
    });
  }

  Widget customAppbar(String profilePicture, bool isProfilePicture) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: isProfilePicture
                ? FileImage(File(profilePicture))
                : AssetImage('assets/images/avatar.jpg') as ImageProvider,
            radius: 35,
          ),
          SizedBox(width: 15),
          Text(
            "High Stared Repository",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          // Spacer(),
          // InkWell(
          //   child: ImageIcon(
          //     AssetImage("assets/icons/search.png"),
          //     size: 24,
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log("BUILD widget called...");
    return SafeArea(
      child: Scaffold(
        body: Consumer<GitHubRepositoryList>(
          builder: (context, repositoryList, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: customAppbar(profilePicture ?? '', isProfilePicture),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: repositoryList.repositories.length + 1,
                    itemBuilder: (context, index) {
                      if (index == repositoryList.repositories.length) {
                        return Center(
                          //loading gif until the data is loaded.
                          child: Image.asset(
                            'assets/icons/stars.gif',
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        );
                      }

                      final repository = repositoryList.repositories[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(repository.ownerAvatarUrl),
                          ),
                          title: Text(repository.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(repository.description,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                              const SizedBox(height: 5),
                              Text('Stars: ${repository.stars} 🌟',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                              const SizedBox(height: 5),
                              Text('Username: ${repository.ownerUsername}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
