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
