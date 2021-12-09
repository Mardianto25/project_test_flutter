part of 'repo_bloc.dart';

abstract class RepoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RepoFetched extends RepoEvent {
  String name;
  int page;
  int perpage;
  String search;

  RepoFetched(
      {required this.name,
      required this.page,
      required this.perpage,
      required this.search});
  @override
  List<Object> get props => [name, page, perpage];
}
