class RepoData {
  final int id;
  final String? name;
  final String? createdAt;
  final int watchCount;
  final int starCount;
  final int forksCount;
  final String url;

  RepoData(
      {required this.id,
      this.name,
      this.createdAt,
      required this.watchCount,
      required this.starCount,
      required this.forksCount,
      required this.url});

  //mapping json data
  factory RepoData.fromJSON(Map<String, dynamic> jsonMap) {
    final data = RepoData(
        id: jsonMap["id"],
        name: jsonMap["name"],
        createdAt: jsonMap["created_at"],
        watchCount: jsonMap["watchers_count"],
        starCount: jsonMap["stargazers_count"],
        forksCount: jsonMap["forks_count"],
        url: jsonMap["url"]);
    return data;
  }
}
