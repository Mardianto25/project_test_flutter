class Issue {
  final int id;
  final String? title;
  final String? state;
  final String? updatedAt;
  final String? url;

  Issue({required this.id, this.title, this.state, this.updatedAt, this.url});

  //mapping json data
  factory Issue.fromJSON(Map<String, dynamic> jsonMap) {
    final data = Issue(
        id: jsonMap["id"],
        title: jsonMap["title"],
        state: jsonMap["state"],
        updatedAt: jsonMap["updated_at"],
        url: jsonMap["repository_url"]);
    return data;
  }
}
