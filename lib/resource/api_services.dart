import 'dart:convert';

import 'package:project_belajar/models/issue.dart';
import 'package:http/http.dart' as http;
import 'package:project_belajar/models/repo.dart';
import 'package:project_belajar/models/user.dart';

class ApiServices {
  final String _url = 'https://api.github.com/search';

  Future<List<Issue>> fetchIssues(query, page, perpage) async {
    final response = await http
        .get(Uri.parse('$_url/issues?q=$query&page=$page&per_page=$perpage'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      var userDataList = body["items"] as List;
      return userDataList.map((i) => Issue.fromJSON(i)).toList();
    } else if (response.statusCode == 403) {
      return [];
    }
    throw Exception('error fetching Issues');
  }

  Future<List<RepoData>> fetchRepos(query, page, perpage) async {
    final response = await http.get(
        Uri.parse('$_url/repositories?q=$query&page=$page&per_page=$perpage'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      var repoDataList = body["items"] as List;
      return repoDataList.map((i) => RepoData.fromJSON(i)).toList();
    } else if (response.statusCode == 403) {
      return [];
    }
    throw Exception('error fetching Repos');
  }

  Future<List<UserData>> fetchUsers(query, page, perpage) async {
    final response = await http
        .get(Uri.parse('$_url/users?q=$query&page=$page&per_page=$perpage'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      var userDataList = body["items"] as List;
      return userDataList.map((i) => UserData.fromJSON(i)).toList();
    } else if (response.statusCode == 403) {
      return [];
    }
    throw Exception('error fetching Users');
  }
}
