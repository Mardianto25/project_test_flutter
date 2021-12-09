import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_belajar/bloc/issue_bloc.dart';
import 'package:project_belajar/bloc/repo_bloc.dart';
import 'package:project_belajar/bloc/user_bloc.dart';
import 'package:project_belajar/resource/api_repository.dart';
import 'package:project_belajar/widget/bottom_loader.dart';
import 'package:project_belajar/widget/item.dart';
import 'package:http/http.dart' as http;
import 'package:project_belajar/widget/repo_item.dart';
import 'package:project_belajar/widget/user_item.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final _scrollController = ScrollController();
  late IssueBloc _issueBloc;
  late UserBloc _userBloc;
  late RepoBloc _repoBloc;
  int page = 1;
  int perpage = 10;
  late int totalPages;
  TextEditingController controller = new TextEditingController();

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'User';
  int id = 1;

  onSearch(String text) async {
    if (text.isEmpty) {
      text = "doraemon";
    }
    if (radioButtonItem == "User") {
      _userBloc.add(UserFetched(
          name: text, page: page, perpage: perpage, search: "search"));
    } else if (radioButtonItem == "Issues") {
      _issueBloc.add(IssueFetched(
          name: text, page: page, perpage: perpage, search: "search"));
    } else {
      _repoBloc.add(RepoFetched(
          name: text, page: page, perpage: perpage, search: "search"));
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _issueBloc = IssueBloc(ApiRepository());
    _userBloc = UserBloc(ApiRepository());
    _repoBloc = RepoBloc(ApiRepository());
    reload();
    super.initState();
  }

  void reload() {
    _userBloc.add(
        UserFetched(name: "doraemon", page: page, perpage: 10, search: ""));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.blue,
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: TextField(
                  controller: controller,
                  onChanged: onSearch,
                  decoration: const InputDecoration(
                      hintText: "Search", border: InputBorder.none),
                ),
                trailing: IconButton(
                  onPressed: () {
                    controller.clear();
                    onSearch('');
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'User';
                    id = 1;
                    String text = controller.text;
                    if (text.isEmpty) text = "doraemon";
                    _userBloc.add(UserFetched(
                        name: text, page: 1, perpage: 10, search: 'search'));
                  });
                },
              ),
              Text(
                'User',
                style: new TextStyle(fontSize: 17.0),
              ),
              Radio(
                value: 2,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'Issues';
                    id = 2;
                    String text = controller.text;
                    if (text.isEmpty) text = "doraemon";
                    _issueBloc.add(IssueFetched(
                        name: text, page: 1, perpage: 10, search: 'search'));
                  });
                },
              ),
              Text(
                'Issues',
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
              Radio(
                value: 3,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'Repositories';
                    id = 3;
                    String text = controller.text;
                    if (text.isEmpty) text = "doraemon";
                    _repoBloc.add(RepoFetched(
                        name: text, page: page, perpage: 10, search: 'search'));
                  });
                },
              ),
              Text(
                'Repositories',
                style: new TextStyle(fontSize: 17.0),
              ),
            ],
          ),
          Expanded(
              child: radioButtonItem == "User"
                  ? _userBuild()
                  : (radioButtonItem == "Issues"
                      ? _issueBuild()
                      : _repoBuild())),
        ],
      ),
    );
  }

  Widget _issueBuild() {
    return BlocConsumer<IssueBloc, IssueState>(
      bloc: _issueBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.status) {
          case IssueStatus.failure:
            return const Center(child: Text('failed to fetch Issues'));
          case IssueStatus.success:
            if (state.issues.isEmpty) {
              return const Center(child: Text('no Issues'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.issues.length
                    ? BottomLoader()
                    : IssueListItem(issue: state.issues[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.issues.length
                  : state.issues.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _userBuild() {
    return BlocConsumer<UserBloc, UserState>(
      bloc: _userBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.status) {
          case UserStatus.failure:
            return const Center(child: Text('failed to load User'));
          case UserStatus.success:
            if (state.users.isEmpty) {
              return const Center(child: Text('no User'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.users.length
                    ? BottomLoader()
                    : UserListItem(user: state.users[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.users.length
                  : state.users.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _repoBuild() {
    return BlocConsumer<RepoBloc, RepoState>(
      bloc: _repoBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.status) {
          case RepoStatus.failure:
            return const Center(child: Text('failed to load Repositories'));
          case RepoStatus.success:
            if (state.repos.isEmpty) {
              return const Center(child: Text('no Repositories'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.repos.length
                    ? BottomLoader()
                    : RepoListItem(repo: state.repos[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.repos.length
                  : state.repos.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      setState(() {
        page = page + 1;
      });
      if (controller.text.isEmpty) {
        controller.text = "doraemon";
      }
      if (radioButtonItem == "User") {
        _userBloc.add(UserFetched(
            name: controller.text, page: page, perpage: perpage, search: ""));
      } else if (radioButtonItem == "Issues") {
        _issueBloc.add(IssueFetched(
            name: controller.text, page: page, perpage: perpage, search: ""));
      } else {
        _repoBloc.add(RepoFetched(
            name: controller.text, page: page, perpage: perpage, search: ""));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
