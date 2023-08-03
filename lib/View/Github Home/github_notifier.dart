import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import '../../Model/github_repo.dart';

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
            log("same repo exists");
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




class GitHubRepositoryList extends ChangeNotifier {
  // ...

  Future<void> fetchGitHubRepositories() async {
    // ...

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
            log("same repo exists");
          }
        }

        // ...

        // Move to the next page for the next fetch
        currentPage++;
      } else {
        throw Exception('Failed to load data from GITHUB Repository API');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  // ...
}

