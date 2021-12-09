import 'package:project_belajar/models/issue.dart';
import 'package:project_belajar/models/repo.dart';
import 'package:project_belajar/models/user.dart';
import 'package:project_belajar/resource/api_services.dart';

class ApiRepository {
  final _provider = ApiServices();

  Future<List<Issue>> fetchIssueList(query, page, perpage) {
    return _provider.fetchIssues(query, page, perpage);
  }

  Future<List<UserData>> fetchUserList(query, page, perpage) {
    return _provider.fetchUsers(query, page, perpage);
  }

  Future<List<RepoData>> fetchRepoList(query, page, perpage) {
    return _provider.fetchRepos(query, page, perpage);
  }
}

class NetworkError extends Error {}
