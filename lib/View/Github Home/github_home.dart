// // ignore_for_file: library_private_types_in_public_api, avoid_print, unused_import

// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class GitHubRepository {
  final int id;
  final String name;
  final String description;
  final int stars;
  final String ownerUsername;
  final String ownerAvatarUrl;

  GitHubRepository({
    required this.id,
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerUsername,
    required this.ownerAvatarUrl,
  });

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? 'No description available',
      stars: json['stargazers_count'],
      ownerUsername: json['owner']['login'],
      ownerAvatarUrl: json['owner']['avatar_url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stars': stars,
      'ownerUsername': ownerUsername,
      'ownerAvatarUrl': ownerAvatarUrl,
    };
  }
}

class GitHubRepositoryList extends ChangeNotifier {
  List<GitHubRepository> repositories = [];
  int currentPage = 1;
  final int itemsPerPage = 10; // Number of items to fetch per page

  final Database _database;

  GitHubRepositoryList(this._database);

  Future<void> fetchGitHubRepositories() async {
    final String apiUrl =
        'https://api.github.com/search/repositories?q=created:>2023-06-27&sort=stars&order=desc&page=$currentPage';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> repos = jsonData['items'];
        final List<GitHubRepository> fetchedRepositories =
            repos.map((item) => GitHubRepository.fromJson(item)).toList();

        // Store the fetched repositories in the local database
        for (var repository in fetchedRepositories) {
          final existingRepository = await _database.query('repositories',
              where: 'id = ?', whereArgs: [repository.id]);
          if (existingRepository.isEmpty) {
            // If the repository with the same id doesn't exist, insert it into the database
            await _database.insert('repositories', repository.toJson());
          } else {
            // If the repository with the same id already exists, you can update it here if needed.
            // For simplicity, we are skipping the insertion in this example.
          }
        }

        log("Date inserted inside DB");
        // Update the repositories list and notify listeners
        repositories.addAll(fetchedRepositories);
        notifyListeners();

        // Move to the next page for the next fetch
        currentPage++;
      } else {
        throw Exception('Failed to load data from GITHUB Repository API');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> fetchNextPage() async {
    await fetchGitHubRepositories();
    log("Fetching new data at end of list view...");
  }
}

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

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    log("BUILD widget called...");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Favorite GitHub Repositories'),
      ),
      body: Consumer<GitHubRepositoryList>(
        builder: (context, repositoryList, _) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: repositoryList.repositories.length + 1,
            itemBuilder: (context, index) {
              if (index == repositoryList.repositories.length) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.black));
              }

              final repository = repositoryList.repositories[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(repository.ownerAvatarUrl),
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
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      const SizedBox(height: 5),
                      Text('Stars: ${repository.stars} 🌟',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      const SizedBox(height: 5),
                      Text('Username: ${repository.ownerUsername}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}