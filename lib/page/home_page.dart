import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:project_belajar/bloc/issue_bloc.dart';
import 'package:project_belajar/bloc/repo_bloc.dart';
import 'package:project_belajar/bloc/user_bloc.dart';
import 'package:project_belajar/page/home_list.dart';
import 'package:project_belajar/resource/api_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text('Issue')),
        body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => IssueBloc(ApiRepository()),
        ),
        BlocProvider(
          create: (_) => UserBloc(ApiRepository()),
        ),
        BlocProvider(
          create: (_) => RepoBloc(ApiRepository()),
        ),
      ],
      child: HomeList(),
    ));
  }
}
