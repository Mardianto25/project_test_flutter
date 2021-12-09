part of 'issue_bloc.dart';

abstract class IssueEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IssueFetched extends IssueEvent {
  String name;
  int page;
  int perpage;
  String search;

  IssueFetched(
      {required this.name,
      required this.page,
      required this.perpage,
      required this.search});
  @override
  List<Object> get props => [name, page, perpage];
}
