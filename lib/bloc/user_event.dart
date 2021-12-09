part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserFetched extends UserEvent {
  String name;
  int page;
  int perpage;
  String search;

  UserFetched(
      {required this.name,
      required this.page,
      required this.perpage,
      required this.search});
  @override
  List<Object> get props => [name, page, perpage, search];
}
